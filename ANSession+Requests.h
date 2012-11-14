//
//  ANSession+Requests.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANSession.h"

@interface ANSession (Requests)

- (void)accessTokenInformationWithCompletion:(ANAccessTokenInformationRequestCompletion)completion;

- (void)userWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion;
- (void)userWithUsername:(NSString*)username completion:(ANUserRequestCompletion)completion;
- (void)usersMatchingSearchQuery:(NSString*)query completion:(ANUserListRequestCompletion)completion;

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

- (void)postsInUnifiedStreamWithCompletion:(ANPostListRequestCompletion)completion;
- (void)postsInUnifiedStreamBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion;

- (void)postsInGlobalStreamWithCompletion:(ANPostListRequestCompletion)completion;
- (void)postsInGlobalStreamBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion;

- (void)postsWithTag:(NSString*)tag completion:(ANPostListRequestCompletion)completion;
- (void)postsWithTag:(NSString*)tag betweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion;

- (void)postsReplyingToPostWithID:(ANResourceID)ID betweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion;

- (void)starPostWithID:(ANResourceID)postID completion:(ANPostRequestCompletion)completion;
- (void)unstarPostWithID:(ANResourceID)postID completion:(ANPostRequestCompletion)completion;

- (void)postsStarredByUserWithID:(ANResourceID)userID betweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion;
- (void)usersWithPostWithIDStarred:(ANResourceID)postID completion:(ANUserListRequestCompletion)completion;

- (void)repostPostWithID:(ANResourceID)postID completion:(ANPostRequestCompletion)completion;
- (void)unrepostPostWithID:(ANResourceID)postID completion:(ANPostRequestCompletion)completion;

- (void)usersWithPostWithIDReposted:(ANResourceID)postID completion:(ANUserListRequestCompletion)completion;

- (void)filtersWithCompletion:(ANFilterListRequestCompletion)completion;
- (void)deleteFiltersWithCompletion:(ANFilterListRequestCompletion)completion;

- (void)filterWithID:(ANResourceID)ID completion:(ANFilterRequestCompletion)completion;
- (void)createFilterFromDraft:(ANDraftFilter*)draftFilter completion:(ANFilterRequestCompletion)completion;
- (void)deleteFilterWithID:(ANResourceID)ID completion:(ANFilterRequestCompletion)completion;
- (void)updateFilterWithID:(ANResourceID)ID fromDraft:(ANDraftFilter*)draftFilter completion:(ANFilterRequestCompletion)completion;

- (void)updateStreamMarkerWithDraft:(ANDraftStreamMarker*)draftMarker completion:(ANStreamMarkerRequestCompletion)completion;

@end
