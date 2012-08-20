//
//  ANPostsInGlobalStreamRequest.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANPostsInGlobalStreamRequest.h"

@implementation ANPostsInGlobalStreamRequest

- (NSURL *)URL {
    return [NSURL URLWithString:@"posts/stream/global" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

@end
