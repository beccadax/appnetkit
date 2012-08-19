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

extern const ANRepresentationID ANMeUserID;
extern const ANRepresentationID ANUnspecifiedPostID;

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

//- (void)userWithID:(ANRepresentationID)ID completion:(ANUserRequestCompletion)completion;
//
//- (void)followUserWithID:(ANRepresentationID)ID completion:(ANUserRequestCompletion)completion;
//- (void)unfollowUserWithID:(ANRepresentationID)ID completion:(ANUserRequestCompletion)completion;
//- (void)followingsForUserWithID:(ANRepresentationID)ID completion:(ANUserListRequestCompletion)completion;
//- (void)followersForUserWithID:(ANRepresentationID)ID completion:(ANUserListRequestCompletion)completion;
//
//- (void)muteUserWithID:(ANRepresentationID)ID completion:(ANUserRequestCompletion)completion;
//- (void)unmuteUserWithID:(ANRepresentationID)ID completion:(ANUserRequestCompletion)completion;
//- (void)mutingsForUserWithID:(ANRepresentationID)ID completion:(ANUserListRequestCompletion)completion;
//
//- (void)postWithID:(ANRepresentationID)ID completion:(ANPostRequestCompletion)completion;

- (void)createPost:(ANPost*)post completion:(ANPostRequestCompletion)completion;
//- (void)deletePostWithID:(ANRepresentationID)ID completion:(ANPostRequestCompletion)completion;
//
//- (void)postsForUserWithID:(ANRepresentationID)ID betweenID:(ANRepresentationID)sinceID andID:(ANRepresentationID)beforeID completion:(ANPostListRequestCompletion)completion;
//- (void)postsMentioningUserWithID:(ANRepresentationID)ID betweenID:(ANRepresentationID)sinceID andID:(ANRepresentationID)beforeID completion:(ANPostListRequestCompletion)completion;
//- (void)postsInStreamForUserWithID:(ANRepresentationID)ID betweenID:(ANRepresentationID)sinceID andID:(ANRepresentationID)beforeID completion:(ANPostListRequestCompletion)completion;
//
//- (void)postsInGlobalStreamBetweenID:(ANRepresentationID)sinceID andID:(ANRepresentationID)beforeID completion:(ANPostListRequestCompletion)completion;
//- (void)postsWithTag:(NSString*)tag betweenID:(ANRepresentationID)sinceID andID:(ANRepresentationID)beforeID completion:(ANPostListRequestCompletion)completion;
//
//- (void)postsReplyingToPostWithID:(ANRepresentationID)ID betweenID:(ANRepresentationID)sinceID andID:(ANRepresentationID)beforeID completion:(ANPostListRequestCompletion)completion;

@end
