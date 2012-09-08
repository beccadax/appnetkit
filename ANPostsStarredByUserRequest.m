//
//  ANPostsStarredByUserRequest.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/7/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANPostsStarredByUserRequest.h"

@implementation ANPostsStarredByUserRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[self pathWithFormat:@"users/%@/stars" userID:self.userID] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

@end
