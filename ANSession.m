//
//  ANSession.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANSession.h"
#import "ANAccessTokenInformationRequest.h"
#import "ANCreatePostRequest.h"

const ANRepresentationID ANMeUserID = 0;
const ANRepresentationID ANUnspecifiedPostID = 0;

NSInteger NetworkActivityCount;

@implementation ANSession

+ (void)beginNetworkActivity {
    NetworkActivityCount++;
    UIApplication.sharedApplication.networkActivityIndicatorVisible = (NetworkActivityCount > 0);
}

+ (void)endNetworkActivity {
    NetworkActivityCount--;
    NSAssert(NetworkActivityCount >= 0, @"Network activity count underflow");
    UIApplication.sharedApplication.networkActivityIndicatorVisible = (NetworkActivityCount > 0);
}

+ (ANSession *)defaultSession {
    static ANSession * singleton;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        singleton = [[ANSession alloc] init];
    });
    
    return singleton;
}

- (NSURL *)URLForStreamAPIVersion:(ANStreamAPIVersion)version {
    switch(version) {
        case ANStreamAPIVersion0:
            return [NSURL URLWithString:@"https://alpha-api.app.net/stream/0/"];
            
        default:
            NSAssert(NO, @"Unknown API version %d", version);
            return nil;
    }
}

- (void)accessTokenInformationWithCompletion:(ANAccessTokenInformationRequestCompletion)completion {
    ANAccessTokenInformationRequest * req = [[ANAccessTokenInformationRequest alloc] initWithSession:self];
    
    [req sendRequestWithCompletion:completion];
}

- (void)createPost:(ANPost *)post completion:(ANPostRequestCompletion)completion {
    ANCreatePostRequest * req = [[ANCreatePostRequest alloc] initWithSession:self];
    
    req.post = post;
    
    [req sendRequestWithCompletion:completion];
}

@end
