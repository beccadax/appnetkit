//
//  ANStreamMarker.h
//  Alef
//
//  Created by Brent Royal-Gordon on 11/13/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANResource.h"
#import "ANDefines.h"
#import "ANCompletions.h"

extern const NSUInteger ANStreamMarkerUnspecifiedPercentage;
@class ANDraftStreamMarker;

@interface ANStreamMarker : ANResource

@property (nonatomic,readonly) NSString * name;
@property (nonatomic,readonly,getter=isMarked) BOOL marked;

@property (nonatomic,readonly) ANResourceID postID;
@property (nonatomic,readonly) NSUInteger percentage;

@property (nonatomic,readonly) NSDate * updatedAt;
@property (nonatomic,readonly) NSString * version;

- (ANDraftStreamMarker*)draftStreamMarkerWithPostID:(ANResourceID)postID percentage:(NSUInteger)percentage;
- (void)updateWithPostID:(ANResourceID)postID percentage:(NSUInteger)percentage completion:(ANStreamMarkerRequestCompletion)completion;

@end

@interface ANDraftStreamMarker : NSObject

@property (nonatomic,copy) NSString * name;
@property (nonatomic,assign) ANResourceID postID;
@property (nonatomic,assign) NSUInteger percentage;

@property (nonatomic,copy) NSDictionary * representation;

- (void)updateViaSession:(ANSession*)session completion:(ANStreamMarkerRequestCompletion)completion;

@end
