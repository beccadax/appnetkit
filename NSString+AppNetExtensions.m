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

- (NSString *)urlEncodedString
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), kCFStringEncodingUTF8);
}

- (NSString *)urlDecodedString
{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
