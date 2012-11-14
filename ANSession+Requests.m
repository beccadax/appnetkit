//
//  ANSession+Requests.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
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
#import "ANStarPostRequest.h"
#import "ANUnstarPostRequest.h"
#import "ANPostsStarredByUserRequest.h"
#import "ANUsersWithPostStarredRequest.h"
#import "ANRepostPostRequest.h"
#import "ANUnrepostPostRequest.h"
#import "ANUsersWithPostRepostedRequest.h"
#import "ANUsersMatchingSearchQueryRequest.h"
#import "ANFiltersForCurrentUserRequest.h"
#import "ANFilterRequest.h"
#import "ANCreateFilterRequest.h"
#import "ANDeleteFilterRequest.h"
#import "ANDeleteFiltersForUserRequest.h"
#import "ANUpdateFilterRequest.h"
#import "ANPostsInUserUnifiedStreamRequest.h"
#import "ANUpdateStreamMarkerRequest.h"

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

- (void)usersMatchingSearchQuery:(NSString *)query completion:(ANUserListRequestCompletion)completion {
    ANUsersMatchingSearchQueryRequest * req = [[ANUsersMatchingSearchQueryRequest alloc] initWithSession:self];
    
    req.query = query;
    
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

- (void)postsInUnifiedStreamWithCompletion:(ANPostListRequestCompletion)completion {
    [self postsInUnifiedStreamBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsInUnifiedStreamBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
    ANPostsInUserUnifiedStreamRequest * req = [[ANPostsInUserUnifiedStreamRequest alloc] initWithSession:self];
    
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

- (void)starPostWithID:(ANResourceID)postID completion:(ANPostRequestCompletion)completion {
    ANStarPostRequest * req = [[ANStarPostRequest alloc] initWithSession:self];
    
    req.postID = postID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)unstarPostWithID:(ANResourceID)postID completion:(ANPostRequestCompletion)completion {
    ANUnstarPostRequest * req = [[ANUnstarPostRequest alloc] initWithSession:self];
    
    req.postID = postID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)postsStarredByUserWithID:(ANResourceID)userID betweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
    ANPostsStarredByUserRequest * req = [[ANPostsStarredByUserRequest alloc] initWithSession:self];
    
    req.userID = userID;
    req.beforeID = beforeID;
    req.sinceID = sinceID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)usersWithPostWithIDStarred:(ANResourceID)postID completion:(ANUserListRequestCompletion)completion {
    ANUsersWithPostStarredRequest * req = [[ANUsersWithPostStarredRequest alloc] initWithSession:self];
    
    req.postID = postID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)repostPostWithID:(ANResourceID)postID completion:(ANPostRequestCompletion)completion {
    ANRepostPostRequest * req = [[ANRepostPostRequest alloc] initWithSession:self];
    
    req.postID = postID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)unrepostPostWithID:(ANResourceID)postID completion:(ANPostRequestCompletion)completion {
    ANUnrepostPostRequest * req = [[ANUnrepostPostRequest alloc] initWithSession:self];
    
    req.postID = postID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)usersWithPostWithIDReposted:(ANResourceID)postID completion:(ANUserListRequestCompletion)completion {
    ANUsersWithPostRepostedRequest * req = [[ANUsersWithPostRepostedRequest alloc] initWithSession:self];
    
    req.postID = postID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)filtersWithCompletion:(ANFilterListRequestCompletion)completion {
    ANFiltersForCurrentUserRequest * req = [[ANFiltersForCurrentUserRequest alloc] initWithSession:self];
    [req sendRequestWithCompletion:completion];
}

- (void)deleteFiltersWithCompletion:(ANFilterListRequestCompletion)completion {
    ANDeleteFiltersForUserRequest * req = [[ANDeleteFiltersForUserRequest alloc] initWithSession:self];
    [req sendRequestWithCompletion:completion];
}

- (void)filterWithID:(ANResourceID)ID completion:(ANFilterRequestCompletion)completion {
    ANFilterRequest * req = [[ANFilterRequest alloc] initWithSession:self];
    
    req.filterID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)createFilterFromDraft:(ANDraftFilter*)draftFilter completion:(ANFilterRequestCompletion)completion {
    ANCreateFilterRequest * req = [[ANCreateFilterRequest alloc] initWithSession:self];
    
    req.draftFilter = draftFilter;
    
    [req sendRequestWithCompletion:completion];
}

- (void)deleteFilterWithID:(ANResourceID)ID completion:(ANFilterRequestCompletion)completion {
    ANDeleteFilterRequest * req = [[ANDeleteFilterRequest alloc] initWithSession:self];
    
    req.filterID = ID;
    
    [req sendRequestWithCompletion:completion];
}

- (void)updateFilterWithID:(ANResourceID)ID fromDraft:(ANDraftFilter*)draftFilter completion:(ANFilterRequestCompletion)completion {
    ANUpdateFilterRequest * req = [[ANUpdateFilterRequest alloc] initWithSession:self];
    
    req.filterID = ID;
    req.draftFilter = draftFilter;
    
    [req sendRequestWithCompletion:completion];
}

- (void)updateStreamMarkerWithDraft:(ANDraftStreamMarker*)draftMarker completion:(ANStreamMarkerRequestCompletion)completion {
    ANUpdateStreamMarkerRequest * req = [[ANUpdateStreamMarkerRequest alloc] initWithSession:self];
    
    req.draftMarker = draftMarker;
    
    [req sendRequestWithCompletion:completion];
}

@end
