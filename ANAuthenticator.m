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
        singleton = [NSDictionary dictionaryWithObjectsAndKeys:
                     [NSNumber numberWithInteger:ANOAuthInvalidRequestError], @"invalid_request",
                     [NSNumber numberWithInteger:ANOAuthUnauthorizedClientError], @"unauthorized_client",
                     [NSNumber numberWithInteger:ANOAuthAccessDeniedError], @"access_denied",
                     [NSNumber numberWithInteger:ANOAuthUnsupportedResponseTypeError], @"unsupported_response_type",
                     [NSNumber numberWithInteger:ANOAuthInvalidScopeError], @"invalid_scope",
                     [NSNumber numberWithInteger:ANOAuthServerError], @"server_error",
                     [NSNumber numberWithInteger:ANOAuthTemporarilyUnavailableError], @"temporarily_unavailable",                     
                     nil];
    });
    
    return singleton;

}

- (ANErrorCode)errorCodeForDictionary:(NSDictionary*)dict {
    NSString * errCodeString = [dict objectForKey:@"error"];
    
    return [[self.errorCodeDictionary objectForKey:errCodeString] integerValue];
}

- (NSString*)accessTokenFromRedirectURL:(NSURL*)redirectURL error:(NSError *__autoreleasing *)error {
    NSDictionary * dict = [[NSDictionary alloc] initWithQueryString:redirectURL.fragment];
    
    if([dict objectForKey:@"access_token"]) {
        return [dict objectForKey:@"access_token"];
    }
    
    if(error) {
        *error = [NSError errorWithDomain:ANErrorDomain code:[self errorCodeForDictionary:dict] userInfo:@{
                NSLocalizedDescriptionKey: [dict objectForKey:@"error_description"],
                ANExplanationURLKey: [NSURL URLWithString:[dict objectForKey:@"error_uri"]]
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
