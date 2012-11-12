//
//  ANResource+Magic.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/22/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANResource+Magic.h"
#import <objc/runtime.h>
#import "NSObject+AssociatedObject.h"

// This category is responsible for ANResource's magically appearing accessors.
//
// The short version is that, when Objective-C detects that you're trying to call a getter that doesn't exist, it calls +resolveInstanceMethod:, passing in the name of the getter it's looking for. We then calculate the .representation key corresponding to that property name, look up that property's type, and install an appropriate block under the getter's name.
//
// Supported types include:
// 
// - Objects, with special support for:
//   - NSDate
//   - NSTimeZone
//   - NSLocale
//   - NSURL
//   - ANResource subclasses
// - BOOL
// - ANResourceID (in the form of unsigned long long)
// - NSUInteger (in the form of unsigned long and unsigned int)
// 
// Add a type in ANBlockForGetterReturningType.
// 
// Warning, no user serviceable parts inside.

@implementation ANResource (Magic)

static BOOL ANSelectorIsReadOnly(NSString * name) {
    // A selector that takes any parameters at all will always end in a colon.
    return ![name hasSuffix:@":"];
}

static objc_property_t ANPropertyNamed(Class class, NSString * name) {
    if(!ANSelectorIsReadOnly(name)) {
        return NULL;
    }
    
    if([name hasPrefix:@"is"]) {
        name = [NSString stringWithFormat:@"%@%@",
                [name substringWithRange:NSMakeRange(2, 1)].lowercaseString,
                [name substringFromIndex:3]];
    }

    return class_getProperty(class, [name UTF8String]);
}

static NSString * ANTypeEncodingForPropertyNamed(Class class, NSString * name) {
    objc_property_t prop = ANPropertyNamed(class, name);
    if(!prop) {
        return nil;
    }
    char * bytes = property_copyAttributeValue(prop, "T");
    if(!bytes) {
        return nil;
    }
    
    return [[NSString alloc] initWithBytesNoCopy:bytes length:strlen(bytes) encoding:NSUTF8StringEncoding freeWhenDone:YES];
}

static NSString * ANKeyForGetterSelector(NSString * name) {
    NSMutableString * key = name.mutableCopy;
    
    // Exceptions to the usual rules.
    [key replaceOccurrencesOfString:@"ID" withString:@"_id" options:0 range:NSMakeRange(0, key.length)];
    [key replaceOccurrencesOfString:@"HTML" withString:@"_html" options:0 range:NSMakeRange(0, key.length)];
    [key replaceOccurrencesOfString:@"URL" withString:@"_url" options:0 range:NSMakeRange(0, key.length)];
    [key replaceOccurrencesOfString:@"numberOf" withString:@"_num" options:0 range:NSMakeRange(0, key.length)];
    [key replaceOccurrencesOfString:@"userDescription" withString:@"description" options:0 range:NSMakeRange(0, key.length)];
    [key replaceOccurrencesOfString:@"tag" withString:@"hashtag" options:0 range:NSMakeRange(0, key.length)];
    
    // Used to get at raw versions of processed fields.
    // Note that this will turn things like linkRepresentations into links.
    [key replaceOccurrencesOfString:@"Representation" withString:@"" options:0 range:NSMakeRange(0, key.length)];
    [key replaceOccurrencesOfString:@"String" withString:@"" options:0 range:NSMakeRange(0, key.length)];
    
    // Convert uppercase to lowercase-plus-underscore.
    NSRange range;
    NSCharacterSet * uppercase = NSCharacterSet.uppercaseLetterCharacterSet;
    while((range = [key rangeOfCharacterFromSet:uppercase]).location != NSNotFound) {
        NSString * ch = [key substringWithRange:range];
        [key replaceCharactersInRange:range withString:[NSString stringWithFormat:@"_%@", ch.lowercaseString]];
    }
    
    // If we ended up with a leading underscore, remove it.
    [key replaceOccurrencesOfString:@"_" withString:@"" options:NSAnchoredSearch range:NSMakeRange(0, 1)];
    
    return key.copy;
}

static Class ANClassFromObjectTypeEncoding(NSString * encoding) {
    if(![encoding hasPrefix:@"@\""]) {
        return Nil;
    }
    
    // Find the end of the class name
    NSRange range = [encoding rangeOfString:@"\"" options:0 range:NSMakeRange(2, encoding.length - 2)];
    
    // Adjust the range to cover the class name
    range.length = range.location - 2;
    range.location = 2;
    
    NSString * className = [encoding substringWithRange:range];
    
    return NSClassFromString(className);
}

static NSString * ANTypeEncodingForIMPReturningType(NSString * returnEncoding) {
    if([returnEncoding hasPrefix:@"@\""]) {
        returnEncoding = @"@";
    }
    
    return [NSString stringWithFormat:@"%@%s%s", returnEncoding, @encode(id), @encode(SEL)];
}

static id ANBlockForGetterReturningType(NSString * name, NSString * propType) {
    NSString * key = ANKeyForGetterSelector(name);
    
    if([propType hasPrefix:@"@"]) {
        Class class = ANClassFromObjectTypeEncoding(propType);
        
        if([class isSubclassOfClass:NSDate.class]) {
            SEL _cmd = NSSelectorFromString(name);
            
            return ^NSDate*(ANResource * self) {
                id object = [self associatedObjectForKey:_cmd];
                
                if(!object) {
                    object = [self.representation objectForKey:key];
                    object = [ANResource.dateFormatter dateFromString:object];
                    
                    [self setAssociatedObject:object forKey:_cmd];
                }
                
                return object;
            };
        }
        else if([class isSubclassOfClass:NSTimeZone.class]) {
            return ^NSTimeZone*(ANResource * self) {
                id object = [self.representation objectForKey:key];
                return [NSTimeZone timeZoneWithName:object];
            };
        }
        else if([class isSubclassOfClass:NSLocale.class]) {
            return ^NSLocale*(ANResource * self) {
                id object = [self.representation objectForKey:key];
                return [[NSLocale alloc] initWithLocaleIdentifier:object];
            };
        }
        else if([class isSubclassOfClass:NSURL.class]) {
            return ^NSURL*(ANResource * self) {
                id object = [self.representation objectForKey:key];
                return [NSURL URLWithString:object];
            };
        }
        else if([class isSubclassOfClass:ANResource.class]) {
            SEL _cmd = NSSelectorFromString(name);
            
            return ^ANResource*(ANResource * self) {
                id object = [self associatedObjectForKey:_cmd];
                
                if(!object) {
                    object = [self.representation objectForKey:key];
                    object = [[class alloc] initWithRepresentation:object session:self.session];
                    
                    [self setAssociatedObject:object forKey:_cmd];
                }
                
                return object;
            };
        }
        else {
            return ^id(ANResource * self) {
                return [self.representation objectForKey:key];
            };
        }
    }
    else if([propType hasPrefix:@"c"]) {
        return ^BOOL(ANResource * self) {
            id object = [self.representation objectForKey:key];
            return [object boolValue];
        };
    }
    else if([propType hasPrefix:@"Q"]) {
        SEL _cmd = NSSelectorFromString(name);
        
        return ^unsigned long long(ANResource * self) {
            id object = [self associatedObjectForKey:_cmd];
            
            if(!object) {
                object = [self.representation objectForKey:key];
                
                if([object isKindOfClass:NSString.class]) {
                    object = [ANResource.IDFormatter numberFromString:object];
                }
                
                [self setAssociatedObject:object forKey:_cmd];
            }
            
            return [object unsignedLongLongValue];
        };
    }
    else if([propType hasPrefix:@"L"]) {
        return ^unsigned long(ANResource * self) {
            id object = [self.representation objectForKey:key];
            return [object unsignedLongValue];
        };
    }
    else if([propType hasPrefix:@"I"]) {
        return ^unsigned int(ANResource * self) {
            id object = [self.representation objectForKey:key];
            return [object unsignedIntValue];
        };
    }
    else {
        NSLog(@"Warning: tried to access property '%@', but did not know how to handle type encoding '%@'", name, propType);
        return nil;
    }
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if([super resolveInstanceMethod:sel]) {
        return YES;
    }
    
    NSString * selString = NSStringFromSelector(sel);
    
    NSString * propType = ANTypeEncodingForPropertyNamed(self, selString);
    if(!propType) {
        return NO;
    }
    
    id block = ANBlockForGetterReturningType(selString, propType);
    if(!block) {
        return NO;
    }
    
    NSString * IMPType = ANTypeEncodingForIMPReturningType(propType);
    class_addMethod(self, sel, imp_implementationWithBlock(block), IMPType.UTF8String);
    
    return YES;
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    NSSet * keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    if(ANPropertyNamed(self, key)) {
        keyPaths = [[NSSet setWithObject:@"representation"] setByAddingObjectsFromSet:keyPaths];
    }
    return keyPaths;
}

@end
