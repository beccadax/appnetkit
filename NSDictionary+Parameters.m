//
//  NSDictionary+Parameters.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "NSDictionary+Parameters.h"

@implementation NSDictionary (Parameters)

- (NSString*)_stringForBody:(BOOL)body {
    NSMutableString * string = [NSMutableString new];
    for(NSString * key in self) {
        NSString * name = [self _escapedString:key forBody:body];
        
        id value = [self objectForKey:key];
        if(![value isKindOfClass:NSString.class]) {
            if([value isKindOfClass:NSNumber.class]) {
                value = [value description];
            }
            else {
                value = [NSJSONSerialization dataWithJSONObject:value options:0 error:NULL];
                NSAssert(value, @"Value %@ (in key %@) is not JSON serializable", [self objectForKey:key], key);
                value = [[NSString alloc] initWithData:value encoding:NSUTF8StringEncoding];
            }
        }
        value = [self _escapedString:value forBody:body];
        
        [string appendFormat:@"%@=%@&", name, value];
    }
    
    [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
    
    return string.copy;
}

- (NSString*)queryString {
    return [self _stringForBody:NO];
}

- (NSData*)formBodyData {
    return [[self _stringForBody:YES] dataUsingEncoding:NSASCIIStringEncoding];
}

- (id)initWithString:(NSString*)string forBody:(BOOL)body {
    NSMutableArray * keys = [NSMutableArray new];
    NSMutableArray * values = [NSMutableArray new];
    
    NSCharacterSet * seps = [NSCharacterSet characterSetWithCharactersInString:body ? @"&" : @"&;"];
    
    for(NSString * pair in [string componentsSeparatedByCharactersInSet:seps]) {
        NSArray * parts = [pair componentsSeparatedByString:@"="];
        [keys addObject:[self _unescapedString:[parts objectAtIndex:0] forBody:body]];
        [values addObject:[self _unescapedString:[parts objectAtIndex:1] forBody:body]];
    }
    
    return [self initWithObjects:values forKeys:keys];
}

- (id)initWithQueryString:(NSString*)queryString {
    return [self initWithString:queryString forBody:NO];
}

- (id)initWithFormBodyData:(NSData*)formData {
    return [self initWithString:[[NSString alloc] initWithData:formData encoding:NSASCIIStringEncoding] forBody:YES];
}

- (NSString*)_unescapedString:(NSString*)string forBody:(BOOL)body {
    NSMutableString * str = string.mutableCopy;
    if(body) {
        [str replaceOccurrencesOfString:@"+" withString:@"%20" options:0 range:NSMakeRange(0, str.length)];
    }
    
    return [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString*)_escapedString:(NSString*)string forBody:(BOOL)body {
    NSMutableString * source = string.mutableCopy;
    
    // First, normalize line endings into CR/LF.
    [source replaceOccurrencesOfString:@"\r\n" withString:@"\n" options:0 range:NSMakeRange(0, source.length)];
    [source replaceOccurrencesOfString:@"\r" withString:@"\n" options:0 range:NSMakeRange(0, source.length)];
    [source replaceOccurrencesOfString:@"\n" withString:@"\r\n" options:0 range:NSMakeRange(0, source.length)];
    
    NSMutableString * e = [NSMutableString stringWithCapacity:string.length];
    
    NSCharacterSet * safe = [NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$-_.!*'(),"];
    
    NSScanner * scanner = [NSScanner scannerWithString:source];
    scanner.charactersToBeSkipped = nil;
    while(!scanner.isAtEnd) {
        NSString * safeString;
        if([scanner scanCharactersFromSet:safe intoString:&safeString]) {
            [e appendString:safeString];
        }
        
        NSString * unsafeString;
        if([scanner scanUpToCharactersFromSet:safe intoString:&unsafeString]) {
            for(NSUInteger i = 0; i < unsafeString.length; i++) {
                NSString * chr = [unsafeString substringWithRange:NSMakeRange(i, 1)];
                
                if(body && [chr isEqualToString:@" "]) {
                    [e appendString:@"+"];
                }
                else if(!body && [chr isEqualToString:@"+"]) {
                    [e appendString:@"+"];
                }
                else {
                    NSData * data = [chr dataUsingEncoding:NSUTF8StringEncoding];
                    for(NSUInteger j = 0; j < data.length; j++) {
                        [e appendFormat:@"%%%02X", ((unsigned char*)data.bytes)[j]];
                    }
                }
            }
        }
    }
    
    return e.copy;
}


@end
