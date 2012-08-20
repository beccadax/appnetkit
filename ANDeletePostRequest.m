//
//  ANDeletePostRequest.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANDeletePostRequest.h"

@implementation ANDeletePostRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"posts/%lld", self.postID] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (ANRequestMethod)method {
    return ANRequestMethodDelete;
}

- (void)sendRequestWithCompletion:(ANPostRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(id rep, NSError *error) {
        if(!rep) {
            completion(nil, error);
        }
        else {
            ANPost * post = [[ANPost alloc] initWithRepresentation:rep session:self.session];
            completion(post, nil);
        }
    }];
}

@end
