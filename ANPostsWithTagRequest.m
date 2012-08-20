//
//  ANPostsWithTagRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANPostsWithTagRequest.h"

@implementation ANPostsWithTagRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"posts/tag/%@", self.tag] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

@end
