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
@class ANResource;
@class ANDraft;

extern const ANResourceID ANMeUserID;
extern const ANResourceID ANUnspecifiedPostID;

typedef enum {
    ANStreamAPIVersion0
} ANStreamAPIVersion;

// NOTE: Most of the methods you'll actually want to use are implemented in the Requests category (ANSession+Requests.h).

@interface ANSession : NSObject

+ (void)beginNetworkActivity;
+ (void)endNetworkActivity;

+ (ANSession*)defaultSession;

@property (strong) NSString * accessToken;

- (NSURL*)URLForStreamAPIVersion:(ANStreamAPIVersion)version;

- (void)completeUserRequest:(ANUserRequestCompletion)completion withRepresentation:(NSDictionary*)rep error:(NSError*)error;
- (void)completeUserListRequest:(ANUserListRequestCompletion)completion withRepresentation:(NSArray*)rep error:(NSError*)error;
- (void)completePostRequest:(ANPostRequestCompletion)completion withRepresentation:(NSDictionary*)rep error:(NSError*)error;
- (void)completePostListRequest:(ANPostListRequestCompletion)completion withRepresentation:(NSArray*)rep error:(NSError*)error;

@end

#import "ANSession+Requests.h"
