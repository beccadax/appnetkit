//
//  ANPostsInGlobalStreamRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANPostsInGlobalStreamRequest.h"

@implementation ANPostsInGlobalStreamRequest

- (NSURL *)URL {
    return [NSURL URLWithString:@"posts/stream/global" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

+ (BOOL)requiresAccessToken {
    return NO;
}

@end
