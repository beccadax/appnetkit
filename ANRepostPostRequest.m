//
//  ANRepostPostRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 9/28/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANRepostPostRequest.h"

@implementation ANRepostPostRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"posts/%lld/repost", self.postID] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (ANRequestMethod)method {
    return ANRequestMethodPost;
}

- (void)sendRequestWithCompletion:(ANPostRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(ANResponse * response, id rep, NSError *error) {
        [self.session completePostRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
