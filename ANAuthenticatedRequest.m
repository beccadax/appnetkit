//
//  ANRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANAuthenticatedRequest.h"
#import "AppNetKit.h"

@implementation ANAuthenticatedRequest

- (id)mutableCopyWithZone:(NSZone *)zone {
    ANMutableRequest * req = [[ANMutableRequest alloc] initWithSession:self.session];
    
    req.URL = self.URL;
    req.parameters = self.parameters;
    req.method = self.method;
    
    return req;
}

+ (BOOL)requiresAccessToken {
    return YES;
}

- (BOOL)requiresAccessToken {
    return self.class.requiresAccessToken;
}

- (NSMutableURLRequest *)URLRequest {
    NSMutableURLRequest * req = super.URLRequest;
    
    if(self.session.accessToken) {
        [req setValue:[NSString stringWithFormat:@"Bearer %@", self.session.accessToken] forHTTPHeaderField:@"Authorization"];
    }
    else {
        NSAssert(!self.requiresAccessToken, @"Session's access token has not been set");
    }
    
    return req;
}

@end

@implementation ANMutableAuthenticatedRequest

@synthesize URL, parameters, method;

@end