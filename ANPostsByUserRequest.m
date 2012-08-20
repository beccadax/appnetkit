//
//  ANUserPostListRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANPostsByUserRequest.h"

@implementation ANPostsByUserRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[self pathWithFormat:@"users/%@/posts" userID:self.userID] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

@end
