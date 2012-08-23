//
//  ANSession+Requests.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANSession+Requests.h"
#import "ANAccessTokenInformationRequest.h"
#import "ANCreatePostRequest.h"
#import "ANDeletePostRequest.h"
#import "ANPostsByUserRequest.h"
#import "ANPostsReplyingToPostRequest.h"
#import "ANPostsInUserStreamRequest.h"
#import "ANPostsMentioningUserRequest.h"
#import "ANPostsInGlobalStreamRequest.h"
#import "ANPostsWithTagRequest.h"
#import "ANPostRequest.h"
#import "ANUserRequest.h"
#import "ANFollowUserRequest.h"
#import "ANUnfollowUserRequest.h"
#import "ANFollowingsForUserRequest.h"
#import "ANFollowersForUserRequest.h"
#import "ANMutingsForUserRequest.h"
#import "ANMuteUserRequest.h"
#import "ANUnmuteUserRequest.h"
#import "ANUsernameRequest.h"

@implementation ANSession (Requests)

- (void)accessTokenInformationWithCompletion:(ANAccessTokenInformationRequestCompletion)completion {
    ANAccessTokenInformationRequest * req = [[ANAccessTokenInformationRequest alloc] initWithSession:self];
    
    [req sendRequestWithCompletion:completion];
}

- (void)userWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion {
    ANUserRequest * req = [[ANUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)userWithUsername:(NSString *)username completion:(ANUserRequestCompletion)completion {
    ANUsernameRequest * req = [[ANUsernameRequest alloc] initWithSession:self];
    
    req.username = username;
    
    [req sendRequestWithCompletion:completion];
}

- (void)followUserWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion {
    ANFollowUserRequest * req = [[ANFollowUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)unfollowUserWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion {
    ANUnfollowUserRequest * req = [[ANUnfollowUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)followingsForUserWithID:(ANResourceID)ID completion:(ANUserListRequestCompletion)completion {
    ANFollowingsForUserRequest * req = [[ANFollowingsForUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)followersForUserWithID:(ANResourceID)ID completion:(ANUserListRequestCompletion)completion {
    ANFollowersForUserRequest * req = [[ANFollowersForUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)muteUserWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion {
    ANMuteUserRequest * req = [[ANMuteUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)unmuteUserWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion {
    ANUnmuteUserRequest * req = [[ANUnmuteUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    
    [req sendRequestWithCompletion:completion];
}


- (void)mutingsWithCompletion:(ANUserListRequestCompletion)completion {
    ANMutingsForUserRequest * req = [[ANMutingsForUserRequest alloc] initWithSession:self];
    [req sendRequestWithCompletion:completion];
}

- (void)postWithID:(ANResourceID)ID completion:(ANPostRequestCompletion)completion {
    ANPostRequest * req = [[ANPostRequest alloc] initWithSession:self];
    
    req.postID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)createPostFromDraft:(ANDraft *)draft completion:(ANPostRequestCompletion)completion {
    ANCreatePostRequest * req = [[ANCreatePostRequest alloc] initWithSession:self];
    
    req.draft = draft;
    
    [req sendRequestWithCompletion:completion];
}

- (void)deletePostWithID:(ANResourceID)ID completion:(ANPostRequestCompletion)completion {
    NSParameterAssert(ID != ANUnspecifiedPostID);
    
    ANDeletePostRequest * req = [[ANDeletePostRequest alloc] initWithSession:self];
    
    req.postID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsForUserWithID:(ANResourceID)ID betweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
    ANPostsByUserRequest * req = [[ANPostsByUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    req.sinceID = sinceID;
    req.beforeID = beforeID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsReplyingToPostWithID:(ANResourceID)ID betweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
    ANPostsReplyingToPostRequest * req = [[ANPostsReplyingToPostRequest alloc] initWithSession:self];
    
    req.postID = ID;
    req.sinceID = sinceID;
    req.beforeID = beforeID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsInStreamWithCompletion:(ANPostListRequestCompletion)completion {
    [self postsInStreamBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsInStreamBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
    ANPostsInUserStreamRequest * req = [[ANPostsInUserStreamRequest alloc] initWithSession:self];
    
    req.sinceID = sinceID;
    req.beforeID = beforeID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsMentioningUserWithID:(ANResourceID)ID betweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
    ANPostsMentioningUserRequest * req = [[ANPostsMentioningUserRequest alloc] initWithSession:self];
    
    req.userID = ID;
    req.sinceID = sinceID;
    req.beforeID = beforeID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsInGlobalStreamWithCompletion:(ANPostListRequestCompletion)completion {
    [self postsInGlobalStreamBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsInGlobalStreamBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
    ANPostsInGlobalStreamRequest * req = [[ANPostsInGlobalStreamRequest alloc] initWithSession:self];
    
    req.sinceID = sinceID;
    req.beforeID = beforeID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsWithTag:(NSString *)tag completion:(ANPostListRequestCompletion)completion {
    [self postsWithTag:tag betweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsWithTag:(NSString *)tag betweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
    ANPostsWithTagRequest * req = [[ANPostsWithTagRequest alloc] initWithSession:self];
    
    req.tag = tag;
    req.sinceID = sinceID;
    req.beforeID = beforeID;
    
    [req sendRequestWithCompletion:completion];
}

@end
