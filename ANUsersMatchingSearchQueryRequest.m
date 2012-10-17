//
//  ANUsersMatchingSearchQueryRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 9/29/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANUsersMatchingSearchQueryRequest.h"

@implementation ANUsersMatchingSearchQueryRequest

- (NSURL *)URL {
    return [NSURL URLWithString:@"users/search" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return [NSDictionary dictionaryWithObject:self.query forKey:@"q"];
}

- (ANRequestMethod)method {
    return ANRequestMethodGet;
}

- (void)sendRequestWithCompletion:(ANUserListRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(ANResponse * response, id rep, NSError *error) {
        [self.session completeUserListRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
