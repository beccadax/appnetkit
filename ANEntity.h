//
//  ANEntity.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/22/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANResource.h"
#import "AppNetKit.h"

extern const NSRange ANEntityNoRange;

typedef enum {
    ANEntityTypeMention,
    ANEntityTypeTag,
    ANEntityTypeLink
} ANEntityType;

@class ANDraftEntitySet;
@class ANDraftEntity;

@interface ANEntitySet : ANResource

@property (readonly) NSArray * all;

@property (readonly) NSArray * mentions;
@property (readonly) NSArray * mentionRepresentations;

@property (readonly) NSArray * tags;
@property (readonly) NSArray * tagRepresentations;

@property (readonly) NSArray * links;
@property (readonly) NSArray * linkRepresentations;

- (ANDraftEntitySet*)draftEntitySet;

@end

@interface ANEntity : ANResource

@property (readonly) ANEntityType entityType;
@property (readonly) NSRange range;

@property (readonly) NSString * name;
@property (readonly) ANResourceID userID;

@property (readonly) NSURL * URL;
@property (readonly) NSString * text;

- (ANDraftEntity*)draftEntity;

@end

@interface ANDraftEntitySet : NSObject

@property (readonly) NSMutableArray * links;
@property (readonly) NSMutableArray * mentions;

@property (copy) NSDictionary * representation;

- (NSUInteger)addLinkEntityWithURL:(NSURL*)url range:(NSRange)range;

- (NSUInteger)addMentionEntityForUsername:(NSString*)username;
- (NSUInteger)addMentionEntityForUserID:(ANResourceID)userID;
- (NSUInteger)addMentionEntityForUser:(ANUser*)user;

- (void)removeAllEntities;

@end

@interface ANDraftEntity : NSObject

@property (assign) NSRange range;

@property (strong) NSURL * URL;
@property (strong) NSString * name;
@property (assign) ANResourceID userID;

@property (copy) NSDictionary * representation;

@end

