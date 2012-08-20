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
        NSArray * scopes = rep[@"scopes"];
        NSDictionary * userRep = rep[@"user"];
        
        // This isn't *quite* the same as any of the normal completions, but there are ways around that...
        [self.session completeUserRequest:^(ANUser *user, NSError *error) {
            completion(scopes, user, error);
        } withRepresentation:userRep error:error];
    }];
}

@end
