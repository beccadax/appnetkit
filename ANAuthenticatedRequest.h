//
//  ANRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import <Foundation/Foundation.h>

#import "ANRequest.h"

@interface ANAuthenticatedRequest : ANRequest <NSMutableCopying>

+ (BOOL)requiresAccessToken;

@property (readonly,assign) BOOL requiresAccessToken;

@end

@interface ANMutableAuthenticatedRequest : ANRequest

@property (readwrite,strong) NSURL * URL;
@property (readwrite,strong) NSDictionary * parameters;
@property (readwrite,assign) ANRequestMethod method;

@end
