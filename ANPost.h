//
//  ANPost.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANIdentifiedResource.h"
#import "ANSession.h"

@class ANDraft;
@class ANSource;
@class ANAnnotationSet;

@interface ANPost : ANIdentifiedResource <ANTextualResource>

@property (readonly) ANUser * user;
@property (readonly) NSDictionary * userRepresentation;
@property (readonly) NSDate * createdAt;

@property (readonly) ANAnnotationSet * annotations;
@property (readonly) NSArray * annotationRepresentations;

@property (readonly) ANSource * source;
@property (readonly) NSDictionary * sourceRepresentation;

@property (readonly) ANResourceID replyTo;
- (void)postRepliedToWithCompletion:(ANPostRequestCompletion)completion;
- (void)replyPostsWithCompletion:(ANPostListRequestCompletion)completion;

@property (readonly) ANResourceID threadID;
@property (readonly) NSUInteger numberOfReplies;
- (void)postAtThreadRootWithCompletion:(ANPostRequestCompletion)completion;

@property (readonly,getter=isDeleted) BOOL deleted;
- (void)deleteWithCompletion:(ANPostRequestCompletion)completion;

@property (readonly) NSUInteger numberOfStars;
@property (readonly) BOOL youStarred;

@property (readonly) NSArray * starredBy;
@property (readonly) NSArray * starredByRepresentation;

- (ANDraft*)draftForward;
- (ANDraft*)draftCopy;

- (ANDraft*)draftReply;
// The exception is usually the user who will post the draft.
- (ANDraft*)draftReplyToAllExceptUser:(ANUser*)user;
- (ANDraft*)draftReplyToAllExceptUsername:(NSString*)username;

@end
