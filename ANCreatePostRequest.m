//
//  ANCreatePostRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANCreatePostRequest.h"
#import "AppNetKit.h"
#import "NSDictionary+dictionaryWithObjectsForKeys.h"

@implementation ANCreatePostRequest

- (NSURL *)URL {
    return [NSURL URLWithString:@"posts" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return [self.post.representation dictionaryWithObjectsForKeys:[NSArray arrayWithObjects:@"text", @"reply_to", @"annotations", @"links", nil]];
}

- (ANRequestMethod)method {
    return ANRequestMethodPost;
}

- (void)sendRequestWithCompletion:(ANPostRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(id rep, NSError *error) {
        // XXX register .post as being the post with this ID?
        [self.session completePostRequest:completion withRepresentation:rep error:error];
    }];
}

@end
