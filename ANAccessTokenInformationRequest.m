//
//  ANAccessTokenInformationRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAccessTokenInformationRequest.h"
#import "ANUser.h"

@implementation ANAccessTokenInformationRequest

- (NSURL *)URL {
    return [NSURL URLWithString:@"token" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (ANRequestMethod)method {
    return ANRequestMethodGet;
}

- (void)sendRequestWithCompletion:(ANAccessTokenInformationRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(id rep, NSError *error) {
        if(!rep) {
            completion(nil, nil, error);
        }
        
        NSArray * scopes = rep[@"scopes"];
        ANUser * user = [[ANUser alloc] initWithRepresentation:rep[@"user"] session:self.session];
        
        completion(scopes, user, nil);
    }];
}

@end
