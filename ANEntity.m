//
//  ANEntity.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/22/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANEntity.h"

#import "NSObject+AssociatedObject.h"

const NSRange ANEntityNoRange = (NSRange){ NSNotFound, 0 };

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
    // We use associated objects here because associated objects are cleared when the representation is set.
    NSArray * ret = [self associatedObjectForKey:_cmd];
    
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
        
        [self setAssociatedObject:ret forKey:_cmd];
    }
    
    return ret;
}

- (ANDraftEntitySet *)draftEntitySet {
    ANDraftEntitySet * draftSet = [ANDraftEntitySet new];
    
    [draftSet.links addObjectsFromArray:[self.links valueForKey:@"draftEntity"]];
    [draftSet.mentions addObjectsFromArray:[self.mentions valueForKey:@"draftEntity"]];
    
    return draftSet;
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
    if(![self.representation objectForKey:@"pos"]) {
        return ANEntityNoRange;
    }
    
    return NSMakeRange([[self.representation objectForKey:@"pos"] unsignedIntegerValue],
                       [[self.representation objectForKey:@"len"] unsignedIntegerValue]);
}

- (ANResourceID)userID {
    return self.ID;
}

- (ANDraftEntity *)draftEntity {
    ANDraftEntity * draft = [ANDraftEntity new];
    
    if(!NSEqualRanges(self.range, ANEntityNoRange)) {
        draft.range = self.range;
    }
    
    return draft;
}

@end

@implementation ANMentionEntity

- (ANEntityType)entityType {
    return ANEntityTypeMention;
}

- (NSString *)text {
    return self.name.appNetUsernameString;
}

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://alpha.app.net/%@", self.name]];
}

- (ANDraftEntity *)draftEntity {
    ANDraftEntity * draft = [super draftEntity];
    draft.userID = self.userID;
    draft.name = self.name;
    return draft;
}

@end

@implementation ANTagEntity

- (ANEntityType)entityType {
    return ANEntityTypeTag;
}

- (NSString *)text {
    return self.name.appNetTagString;
}

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://alpha.app.net/hashtags/%@", self.name]];
}

- (ANDraftEntity *)draftEntity {
    return nil;
}

@end

@implementation ANLinkEntity

- (ANEntityType)entityType {
    return ANEntityTypeLink;
}

- (ANDraftEntity *)draftEntity {
    ANDraftEntity * draft = [super draftEntity];
    draft.URL = self.URL;
    return draft;
}

@end

@implementation ANDraftEntitySet

- (id)init {
    if((self = [super init])) {
        _links = [NSMutableArray new];
        _mentions = [NSMutableArray new];
    }
    return self;
}

- (NSUInteger)addLinkEntityWithURL:(NSURL*)url range:(NSRange)range {
    NSUInteger i = self.links.count;
    
    ANDraftEntity * entity = [ANDraftEntity new];
    entity.URL = url;
    entity.range = range;
    
    [self.links insertObject:entity atIndex:i];
    
    return i;
}

- (NSUInteger)addMentionEntityForUsername:(NSString*)username {
    NSUInteger i = self.mentions.count;
    
    ANDraftEntity * entity = [ANDraftEntity new];
    entity.name = username;
    
    [self.mentions insertObject:entity atIndex:i];
    
    return i;
}

- (NSUInteger)addMentionEntityForUserID:(ANResourceID)userID {
    NSUInteger i = self.mentions.count;
    
    ANDraftEntity * entity = [ANDraftEntity new];
    entity.userID = userID;
    
    [self.mentions insertObject:entity atIndex:i];
    
    return i;
}

- (NSUInteger)addMentionEntityForUser:(ANUser*)user {
    NSUInteger i = self.mentions.count;
    
    ANDraftEntity * entity = [ANDraftEntity new];
    entity.name = user.username;
    entity.userID = user.ID;
    
    [self.mentions insertObject:entity atIndex:i];
    
    return i;
}

- (void)removeAllEntities {
    [self.links removeAllObjects];
    [self.mentions removeAllObjects];
}

- (NSDictionary *)representation {
    NSMutableDictionary * rep = [NSMutableDictionary new];
    
    if(self.links.count) {
        [rep setObject:[self.links valueForKey:@"representation"] forKey:@"links"];
    }
    if(self.mentions.count) {
        [rep setObject:[self.mentions valueForKey:@"representation"] forKey:@"mentions"];
    }
    
    if(!rep.count) {
        return nil;
    }
    
    return rep;
}

- (void)setRepresentation:(NSDictionary *)rep {
    [self removeAllEntities];
    
    for(NSDictionary * entityRep in [rep objectForKey:@"links"]) {
        ANDraftEntity * draftEntity = [ANDraftEntity new];
        draftEntity.representation = entityRep;
        
        [self.links addObject:draftEntity];
    }

    for(NSDictionary * entityRep in [rep objectForKey:@"mentions"]) {
        ANDraftEntity * draftEntity = [ANDraftEntity new];
        draftEntity.representation = entityRep;
        
        [self.mentions addObject:draftEntity];
    }
}

@end

@implementation ANDraftEntity

- (id)init {
    if((self = [super init])) {
        _range = ANEntityNoRange;
    }
    return self;
}

- (NSDictionary *)representation {
    NSMutableDictionary * rep = [NSMutableDictionary new];
    
    if(self.URL) {
        [rep setObject:self.URL.absoluteString forKey:@"url"];
    }
    if(self.name) {
        [rep setObject:self.name forKey:@"name"];
    }
    if(self.userID != 0) {
        [rep setObject:[ANResource.IDFormatter stringFromNumber:[NSNumber numberWithUnsignedLongLong:self.userID]]  forKey:@"id"];
    }
    if(!NSEqualRanges(self.range, ANEntityNoRange)) {
        [rep setObject:[NSString stringWithFormat:@"%d", self.range.location] forKey:@"pos"];
        [rep setObject:[NSString stringWithFormat:@"%d", self.range.length] forKey:@"len"];
    }
    
    return rep;
}

- (void)setRepresentation:(NSDictionary *)rep {
    self.URL = [NSURL URLWithString:[rep objectForKey:@"url"]];
    self.name = [rep objectForKey:@"name"];
    self.userID = [[ANResource.IDFormatter numberFromString:[rep objectForKey:@"id"]] unsignedLongLongValue];
    
    if([rep objectForKey:@"pos"]) {
        self.range = NSMakeRange([[rep objectForKey:@"pos"] integerValue], [[rep objectForKey:@"len"] integerValue]);
    }
    else {
        self.range = ANEntityNoRange;
    }
}

@end
