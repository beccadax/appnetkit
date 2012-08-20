//
//  ANUserPostStreamRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANUserPostStreamRequest.h"

@implementation ANUserPostStreamRequest

- (NSURL *)URL {
    return [NSURL URLWithString:@"posts/stream" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

@end
