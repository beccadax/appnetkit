//
//  ANEntity.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/22/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANEntity.h"

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
    NSArray * groupedEntities = @[ self.mentions, self.tags, self.links, ];
    NSMutableArray * allEntities = [NSMutableArray new];
    
    for(NSArray * entities in groupedEntities) {
        [allEntities addObjectsFromArray:entities];
    }
    
    return [allEntities sortedArrayUsingDescriptors:@[
            [[NSSortDescriptor alloc] initWithKey:@"_location" ascending:YES],
            [[NSSortDescriptor alloc] initWithKey:@"type" ascending:YES] ]];
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
    return NSMakeRange([self.representation[@"pos"] unsignedIntegerValue], [self.representation[@"len"] unsignedIntegerValue]);
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
