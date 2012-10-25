//
//  ANPostRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANPostRequest.h"

@implementation ANPostRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"posts/%lld", self.postID] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (ANRequestMethod)method {
    return ANRequestMethodGet;
}

+ (BOOL)requiresAccessToken {
    return NO;
}

- (void)sendRequestWithCompletion:(ANPostRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(ANResponse * response, id rep, NSError *error) {
        [self.session completePostRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
