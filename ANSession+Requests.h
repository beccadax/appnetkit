//
//  ANSession+Requests.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANSession.h"

@interface ANSession (Requests)

- (void)accessTokenInformationWithCompletion:(ANAccessTokenInformationRequestCompletion)completion;

- (void)userWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion;
- (void)userWithUsername:(NSString*)username completion:(ANUserRequestCompletion)completion;

- (void)followUserWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion;
- (void)unfollowUserWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion;
- (void)followingsForUserWithID:(ANResourceID)ID completion:(ANUserListRequestCompletion)completion;
- (void)followersForUserWithID:(ANResourceID)ID completion:(ANUserListRequestCompletion)completion;

- (void)muteUserWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion;
- (void)unmuteUserWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion;
- (void)mutingsWithCompletion:(ANUserListRequestCompletion)completion;

- (void)postWithID:(ANResourceID)ID completion:(ANPostRequestCompletion)completion;

- (void)createPostFromDraft:(ANDraft*)draft completion:(ANPostRequestCompletion)completion;
- (void)deletePostWithID:(ANResourceID)ID completion:(ANPostRequestCompletion)completion;

- (void)postsForUserWithID:(ANResourceID)ID betweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion;
- (void)postsMentioningUserWithID:(ANResourceID)ID betweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion;

- (void)postsInStreamWithCompletion:(ANPostListRequestCompletion)completion;
- (void)postsInStreamBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion;

- (void)postsInGlobalStreamWithCompletion:(ANPostListRequestCompletion)completion;
- (void)postsInGlobalStreamBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion;

- (void)postsWithTag:(NSString*)tag completion:(ANPostListRequestCompletion)completion;
- (void)postsWithTag:(NSString*)tag betweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion;

- (void)postsReplyingToPostWithID:(ANResourceID)ID betweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion;

- (void)starPostWithID:(ANResourceID)postID completion:(ANPostRequestCompletion)completion;
- (void)unstarPostWithID:(ANResourceID)postID completion:(ANPostRequestCompletion)completion;

- (void)postsStarredByUserWithID:(ANResourceID)userID completion:(ANPostListRequestCompletion)completion;
- (void)postsStarredByUserWithID:(ANResourceID)userID betweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion;

- (void)usersWithPostWithIDStarred:(ANResourceID)postID completion:(ANUserListRequestCompletion)completion;

@end
