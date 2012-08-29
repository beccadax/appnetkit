//
//  ANEntity.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/22/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANEntity.h"

#import <objc/runtime.h>

@interface ANEntity ()

+ (NSArray*)entitiesWithRepresentations:(NSArray*)reps session:(ANSession*)session;

@property (readonly) ANResourceID ID;

@end

@interface ANMentionEntity : ANEntity @end
@interface ANTagEntity : ANEntity @end
@interface ANLinkEntity : ANEntity @end

@implementation ANEntitySet

@dynamic mentionRepresentations;
@dynamic tagRepresentations;
@dynamic linkRepresentations;

- (NSArray *)mentions {
    return [ANMentionEntity entitiesWithRepresentations:self.mentionRepresentations session:self.session];
}

- (NSArray *)tags {
    return [ANTagEntity entitiesWithRepresentations:self.tagRepresentations session:self.session];
}

- (NSArray *)links {
    return [ANLinkEntity entitiesWithRepresentations:self.linkRepresentations session:self.session];
}

- (NSArray *)all {
    NSArray * ret = objc_getAssociatedObject(self, _cmd);
    
    if(!ret) {
        NSMutableArray * allEntities = [NSMutableArray new];
        
        NSMutableArray * groupedEntities = [NSMutableArray arrayWithObjects:
                                            self.mentions.mutableCopy,
                                            self.tags.mutableCopy,
                                            self.links.mutableCopy,
                                            nil];
        
        for(NSMutableArray * someEntities in groupedEntities.copy) {
            if(someEntities.count == 0) {
                [groupedEntities removeObject:someEntities];
            }
        }
        
        while(groupedEntities.count) {
            NSMutableArray * nextEntityArray;
            
            for(NSMutableArray * someEntities in groupedEntities) {
                if(!nextEntityArray) {
                    nextEntityArray = someEntities;
                    continue;
                }
                if([[nextEntityArray objectAtIndex:0] range].location > [[someEntities objectAtIndex:0] range].location) {
                    nextEntityArray = someEntities;
                    continue;
                }
            }
            
            [allEntities addObject:[nextEntityArray objectAtIndex:0]];
            [nextEntityArray removeObjectAtIndex:0];
            
            if(nextEntityArray.count == 0) {
                [groupedEntities removeObject:nextEntityArray];
            }
        }
        
        ret = allEntities.copy;
        
        objc_setAssociatedObject(self, _cmd, ret, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return ret;
}

@end

@implementation ANEntity

- (NSUInteger)_location {
    return self.range.location;
}

+ (NSArray *)entitiesWithRepresentations:(NSArray *)reps session:(ANSession *)session {
    NSMutableArray * entities = [NSMutableArray new];
    for(NSDictionary * rep in reps) {
        [entities addObject:[[self alloc] initWithRepresentation:rep session:session]];
    }
    return entities.copy;
}

@dynamic entityType;
@dynamic URL;
@dynamic name;
@dynamic text;
@dynamic ID;

- (NSRange)range {
    return NSMakeRange([[self.representation objectForKey:@"pos"] unsignedIntegerValue],
                       [[self.representation objectForKey:@"len"] unsignedIntegerValue]);
}

- (ANResourceID)userID {
    return self.ID;
}

@end

@implementation ANMentionEntity

- (ANEntityType)entityType {
    return ANEntityTypeMention;
}

- (NSString *)text {
    return [NSString stringWithFormat:@"@%@", self.name];
}

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://alpha.app.net/%@", self.name]];
}

@end

@implementation ANTagEntity

- (ANEntityType)entityType {
    return ANEntityTypeTag;
}

- (NSString *)text {
    return [NSString stringWithFormat:@"#%@", self.name];
}

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://alpha.app.net/hashtags/%@", self.name]];
}

@end

@implementation ANLinkEntity

- (ANEntityType)entityType {
    return ANEntityTypeLink;
}

@end
