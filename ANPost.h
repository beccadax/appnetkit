//
//  ANPost.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
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
@property (readonly) NSURL * canonicalURL;

@property (readonly) ANAnnotationSet * annotations;
@property (readonly) NSArray * annotationRepresentations;

@property (readonly) ANSource * source;
@property (readonly) NSDictionary * sourceRepresentation;

@property (readonly) BOOL machineOnly;

// self.repostOf if this is a repost, self otherwise.
@property (readonly) ANPost * originalPost;
@property (readonly) ANResourceID originalID;

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

// Note: will be nil unless your request has includeStarredBy = YES. (The default is NO.)
@property (readonly) NSArray * starredBy;
@property (readonly) NSArray * starredByRepresentation;

- (void)starWithCompletion:(ANPostRequestCompletion)completion;
- (void)unstarWithCompletion:(ANPostRequestCompletion)completion;
- (void)usersWithPostStarredWithCompletion:(ANUserListRequestCompletion)completion;

@property (readonly) NSUInteger numberOfReposts;
@property (readonly) BOOL youReposted;

@property (readonly) NSArray * reposters;
@property (readonly) NSArray * repostersRepresentation;

@property (readonly) ANPost * repostOf;
@property (readonly) NSDictionary * repostOfRepresentation;

- (void)repostWithCompletion:(ANPostRequestCompletion)completion;
- (void)unrepostWithCompletion:(ANPostRequestCompletion)completion;
- (void)usersWithPostRepostedWithCompletion:(ANUserListRequestCompletion)completion;

- (ANDraft*)draftForward;
- (ANDraft*)draftCopy;

- (ANDraft*)draftReply;
// The exception is usually the user who will post the draft.
- (ANDraft*)draftReplyToAllExceptUser:(ANUser*)user;
- (ANDraft*)draftReplyToAllExceptUsername:(NSString*)username;

@end
