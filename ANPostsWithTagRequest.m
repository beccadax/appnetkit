//
//  ANPostsWithTagRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANPostsWithTagRequest.h"

@implementation ANPostsWithTagRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"posts/tag/%@", self.tag] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

+ (BOOL)requiresAccessToken {
    return NO;
}

@end
