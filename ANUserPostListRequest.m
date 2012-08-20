//
//  ANUserPostListRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANUserPostListRequest.h"

@implementation ANUserPostListRequest

- (NSURL *)URL {
    NSString * path = @"users/me/posts";
    if(self.userID != ANMeUserID) {
        path = [NSString stringWithFormat:@"users/%lld/posts", self.userID];
    }
    
    return [NSURL URLWithString:path relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

@end
