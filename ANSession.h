//
//  ANSession.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppNetKit.h"

@class ANUser;
@class ANPost;

extern const ANResourceID ANMeUserID;
extern const ANResourceID ANUnspecifiedPostID;

typedef enum {
    ANStreamAPIVersion0
} ANStreamAPIVersion;

@interface ANSession : NSObject

+ (void)beginNetworkActivity;
+ (void)endNetworkActivity;

+ (ANSession*)defaultSession;

@property (strong) NSString * accessToken;

- (NSURL*)URLForStreamAPIVersion:(ANStreamAPIVersion)version;

- (void)accessTokenInformationWithCompletion:(ANAccessTokenInformationRequestCompletion)completion;

- (void)userWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion;

- (void)followUserWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion;
- (void)unfollowUserWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion;
- (void)followingsForUserWithID:(ANResourceID)ID completion:(ANUserListRequestCompletion)completion;
- (void)followersForUserWithID:(ANResourceID)ID completion:(ANUserListRequestCompletion)completion;

//- (void)muteUserWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion;
//- (void)unmuteUserWithID:(ANResourceID)ID completion:(ANUserRequestCompletion)completion;
//- (void)mutingsForUserWithID:(ANResourceID)ID completion:(ANUserListRequestCompletion)completion;

- (void)postWithID:(ANResourceID)ID completion:(ANPostRequestCompletion)completion;

- (void)createPost:(ANPost*)post completion:(ANPostRequestCompletion)completion;
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

@end
