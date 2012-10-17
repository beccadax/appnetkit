//
//  AppNetKit.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "AppNetKit.h"

#if !__has_feature(objc_arc)
#error AppNetKit must be built with ARC enabled
#endif

NSString * const ANErrorDomain = @"ANErrorDomain";
NSString * const ANExplanationURLKey = @"ANExplanationURL";
NSString * const ANPasswordErrorTitleKey = @"error_title";
NSString * const ANPasswordErrorTextKey = @"error_text";
