//
//  ANDeleteFiltersForUserRequest.m
//  Alef
//
//  Created by Brent Royal-Gordon on 10/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANDeleteFiltersForUserRequest.h"

@implementation ANDeleteFiltersForUserRequest

- (NSURL *)URL {
    return [NSURL URLWithString:@"filters" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (ANRequestMethod)method {
    return ANRequestMethodDelete;
}

- (void)sendRequestWithCompletion:(ANFilterListRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(ANResponse *response, id rep, NSError *error) {
        [self.session completeFilterListRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
