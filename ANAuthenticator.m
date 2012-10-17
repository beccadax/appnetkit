//
//  ADAppNetAuthenticator.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/17/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
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
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
        self.omitsPaymentOptions = YES;
#else
        self.omitsPaymentOptions = NO;
#endif
    }
    return self;
}

- (NSString*)parametersForScopes:(NSArray *)scopes {
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    self.clientID, @"client_id",
                                    @"token", @"response_type",
                                    self.redirectURL.absoluteString, @"redirect_uri",
                                    [scopes componentsJoinedByString:@" "], @"scope",
                                    nil];
    
    if(self.omitsPaymentOptions) {
        [params setObject:@"appstore" forKey:@"adnview"];
    }
    
    return params.queryString;
}

- (NSURL *)URLToAuthenticateForScopes:(NSArray *)scopes {
    NSString * urlStr = [NSString stringWithFormat:@"https://alpha.app.net/oauth/authenticate?%@", [self parametersForScopes:scopes]];
    return [NSURL URLWithString:urlStr];
}

- (NSURL *)URLToAuthorizeForScopes:(NSArray *)scopes {
    NSString * urlStr = [NSString stringWithFormat:@"https://alpha.app.net/oauth/authorize?%@", [self parametersForScopes:scopes]];
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
        *error = [NSError errorWithDomain:ANErrorDomain code:[self errorCodeForDictionary:dict] userInfo:
                  [NSDictionary dictionaryWithObjectsAndKeys:
                   [[dict objectForKey:@"error_description"] stringByReplacingOccurrencesOfString:@"+" withString:@" "], NSLocalizedDescriptionKey,
                   [NSURL URLWithString:[dict objectForKey:@"error_uri"]], ANExplanationURLKey,
                   nil]];
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
