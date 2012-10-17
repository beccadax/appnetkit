//
//  NSString+AppNetExtensions.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/29/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "NSString+AppNetExtensions.h"

@implementation NSString (AppNetExtensions)

- (NSString*)appNetUsernameString {
    return [@"@" stringByAppendingString:self];
}

- (NSString*)appNetTagString {
    return [@"#" stringByAppendingString:self];
}

@end
