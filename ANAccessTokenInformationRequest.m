//
//  ANAccessTokenInformationRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
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
    [self sendRequestWithRepresentationCompletion:^(ANResponse * response, id rep, NSError *error) {
        NSArray * scopes = [rep objectForKey:@"scopes"];
        NSDictionary * userRep = [rep objectForKey:@"user"];
        
        // This isn't *quite* the same as any of the normal completions, but there are ways around that...
        [self.session completeUserRequest:^(ANResponse * response, ANUser *user, NSError *error) {
            completion(response, scopes, user, error);
        } withResponse:response representation:userRep error:error];
    }];
}

@end
