//
//  ANSession.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import <Foundation/Foundation.h>
#import "AppNetKit.h"

@class ANUser;
@class ANPost;
@class ANFilter;
@class ANResource;
@class ANDraft;
@class ANDraftFilter;
@class ANDraftStreamMarker;

extern const ANResourceID ANMeUserID;
extern const ANResourceID ANUnspecifiedPostID;

typedef enum {
    ANStreamAPIVersion0
} ANStreamAPIVersion;

// NOTE: Most of the methods you'll actually want to use are implemented in the Requests category (ANSession+Requests.h).

@interface ANSession : NSObject

+ (void)beginNetworkActivity;
+ (void)endNetworkActivity;
+ (BOOL)isUsingNetwork;

+ (ANSession*)defaultSession;
+ (void)setDefaultSession:(ANSession*)defaultSession;

@property (strong) NSString * accessToken;

- (NSURL*)URLForStreamAPIVersion:(ANStreamAPIVersion)version;
@property (readonly,nonatomic) NSString * APIEndpointHost;

- (void)completeUserRequest:(ANUserRequestCompletion)completion withResponse:(ANResponse*)response representation:(NSDictionary*)rep error:(NSError*)error;
- (void)completeUserListRequest:(ANUserListRequestCompletion)completion withResponse:(ANResponse*)response representation:(NSArray*)rep error:(NSError*)error;
- (void)completePostRequest:(ANPostRequestCompletion)completion withResponse:(ANResponse*)response representation:(NSDictionary*)rep error:(NSError*)error;
- (void)completePostListRequest:(ANPostListRequestCompletion)completion withResponse:(ANResponse*)response representation:(NSArray*)rep error:(NSError*)error;
- (void)completeFilterRequest:(ANFilterRequestCompletion)completion withResponse:(ANResponse*)response representation:(NSDictionary*)rep error:(NSError*)error;
- (void)completeFilterListRequest:(ANFilterListRequestCompletion)completion withResponse:(ANResponse *)response representation:(NSDictionary *)rep error:(NSError *)error;
- (void)completeStreamMarkerRequest:(ANStreamMarkerRequestCompletion)completion withResponse:(ANResponse *)response representation:(NSDictionary *)rep error:(NSError *)error;

@end

#import "ANSession+Requests.h"
