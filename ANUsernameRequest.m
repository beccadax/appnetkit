//
//  ANUsernameRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANUsernameRequest.h"

@implementation ANUsernameRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[self pathWithFormat:@"users/%@" username:self.username] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (ANRequestMethod)method {
    return ANRequestMethodGet;
}

- (void)sendRequestWithCompletion:(ANUserRequestCompletion)completion {
    NSString * username = self.username;
    
    [self sendRequestWithRepresentationCompletion:^(ANResponse * response, id rep, NSError *error) {
        if(!rep) {
            if(error.code == ANNotFoundError && [error.domain isEqualToString:ANErrorDomain]) {
                NSString * message = [NSString stringWithFormat:NSLocalizedString(@"%@ has not been registered by an App.net user.", @""), username.appNetUsernameString];
                error = [NSError errorWithDomain:ANErrorDomain code:ANNotFoundError userInfo:@{ NSLocalizedDescriptionKey: message, NSUnderlyingErrorKey: error }];
            }
        }
        [self.session completeUserRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
