//
//  ANUpdateStreamMarkerRequest.m
//  Alef
//
//  Created by Brent Royal-Gordon on 11/13/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANUpdateStreamMarkerRequest.h"

@implementation ANUpdateStreamMarkerRequest

- (NSURL *)URL {
    return [NSURL URLWithString:@"posts/marker" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return self.draftMarker.representation;
}

- (ANRequestMethod)method {
    return ANRequestMethodPost;
}

- (void)sendRequestWithCompletion:(ANStreamMarkerRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(ANResponse *response, id rep, NSError *error) {
        [self.session completeStreamMarkerRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
