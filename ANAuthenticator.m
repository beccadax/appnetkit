//
//  ADAppNetAuthenticator.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/17/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticator.h"
#import "AppNetKit.h"
#import "NSDictionary+Parameters.h"

NSString * const ANScopeStream = @"stream";
NSString * const ANScopeEmail = @"email";
NSString * const ANScopeWritePost = @"write_post";
NSString * const ANScopeFollow = @"follow";
NSString * const ANScopeMessages = @"messages";
NSString * const ANScopeExport = @"export";

@implementation ANAuthenticator

- (id)initSingleton {
    if(self = [super init]) {
        
    }
    return self;
}

- (NSURL *)URLToAuthenticateForScopes:(NSArray *)scopes {
    NSString * urlStr = [NSString stringWithFormat:@"https://alpha.app.net/oauth/authenticate?client_id=%@&response_type=token&redirect_uri=%@&scope=%@", self.clientID, self.redirectURL.absoluteString, [scopes componentsJoinedByString:@"%20"]];
    return [NSURL URLWithString:urlStr];
}

- (BOOL)isRedirectURL:(NSURL *)url {
    return [url.scheme isEqualToString:self.redirectURL.scheme] && [url.host isEqualToString:self.redirectURL.host] && [url.path isEqualToString:self.redirectURL.path];
}

- (NSDictionary*)errorCodeDictionary {
    static NSDictionary * singleton;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        singleton = @{
            @"invalid_request": @(ANOAuthInvalidRequestError),
            @"unauthorized_client": @(ANOAuthUnauthorizedClientError),
            @"access_denied": @(ANOAuthAccessDeniedError),
            @"unsupported_response_type": @(ANOAuthUnsupportedResponseTypeError),
            @"invalid_scope": @(ANOAuthInvalidScopeError),
            @"server_error": @(ANOAuthServerError),
            @"temporarily_unavailable": @(ANOAuthTemporarilyUnavailableError)
        };
    });
    
    return singleton;

}

- (ANErrorCode)errorCodeForDictionary:(NSDictionary*)dict {
    NSString * errCodeString = dict[@"error"];
    
    return [self.errorCodeDictionary[errCodeString] integerValue];
}

- (NSString*)accessTokenFromRedirectURL:(NSURL*)redirectURL error:(NSError *__autoreleasing *)error {
    NSDictionary * dict = [[NSDictionary alloc] initWithQueryString:redirectURL.fragment];
    
    if(dict[@"access_token"]) {
        return dict[@"access_token"];
    }
    
    if(error) {
        *error = [NSError errorWithDomain:ANErrorDomain code:[self errorCodeForDictionary:dict] userInfo:@{
                NSLocalizedDescriptionKey: dict[@"error_description"],
                ANExplanationURLKey: [NSURL URLWithString:dict[@"error_uri"]]
                  }];
    }
    
    return nil;
}

#pragma mark Singleton machinery

+ (ANAuthenticator *)sharedAuthenticator {
    static ANAuthenticator * singleton;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        singleton = [[super allocWithZone:nil] initSingleton];
    });
    
    return singleton;
}

- (id)init {
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    return self.sharedAuthenticator;
}

@end
