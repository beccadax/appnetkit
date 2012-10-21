//
//  ANUpdateFilterRequest.m
//  Alef
//
//  Created by Brent Royal-Gordon on 10/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANUpdateFilterRequest.h"

@implementation ANUpdateFilterRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"filters/%lld", self.filterID] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return self.draftFilter.representation;
}

- (ANRequestMethod)method {
    return ANRequestMethodPut;
}

- (void)sendRequestWithCompletion:(ANFilterRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(ANResponse *response, id rep, NSError *error) {
        [self.session completeFilterRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
