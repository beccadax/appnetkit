//
//  ANPostsInUserUnifiedStreamRequest.m
//  Alef
//
//  Created by Brent Royal-Gordon on 10/25/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANPostsInUserUnifiedStreamRequest.h"

@implementation ANPostsInUserUnifiedStreamRequest

- (NSURL *)URL {
    return [super.URL URLByAppendingPathComponent:@"unified"];
}

@end
