//
//  ANUserPostStreamRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANPostsInUserStreamRequest.h"

@implementation ANPostsInUserStreamRequest

- (id)initWithSession:(ANSession *)session {
    if((self = [super initWithSession:session])) {
        self.includeDirectedPosts = NO;
    }
    return self;
}

- (NSURL *)URL {
    return [NSURL URLWithString:@"posts/stream" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

@end
