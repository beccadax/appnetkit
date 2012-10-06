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
#import "ANRequest.h"

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

- (void)accessTokenWithPasswordGrantSecret:(NSString *)passwordGrantSecret username:(NSString *)username password:(NSString *)password scopes:(NSString *)scopes completion:(void (^)(NSString *accessToken, id rep, NSError * error))completion
{
    ANSession *anSession = [ANSession defaultSession];
    ANMutableRequest *authRequest = [[ANMutableRequest alloc] initWithSession:anSession];
    authRequest.URL = [NSURL URLWithString:@"https://alpha.app.net/oauth/access_token"];
    authRequest.method = ANRequestMethodPost;
    authRequest.parameterEncoding = ANRequestParameterEncodingURL;
    authRequest.parameters = @{@"client_id": self.clientID, @"password_grant_secret": passwordGrantSecret, @"grant_type": @"password", @"username": username, @"password": password, @"scope": scopes};

    [authRequest sendRequestWithRepresentationCompletion:^(ANResponse *response, id rep, NSError *error) {
        if (error)
        {
            NSDictionary *errorResults = [error.userInfo objectForKey:@"json"];

            if ([errorResults isKindOfClass:NSDictionary.class])
            {
                NSString *errorMessage = [errorResults objectForKey:@"error"];
                NSString *errorText = [errorResults objectForKey:@"error_text"];
                NSString *errorTitle = [errorResults objectForKey:@"error_title"];

                NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
                [userInfo setObject:errorMessage forKey:NSLocalizedDescriptionKey];
                [userInfo setObject:error forKey:NSUnderlyingErrorKey];
                if (errorText) [userInfo setObject:errorText forKey:@"error_text"];
                if (errorTitle) [userInfo setObject:errorText forKey:@"error_title"];

                error = [NSError errorWithDomain:ANErrorDomain code:0 userInfo:userInfo];
            }

            if (completion) {
                completion(nil, nil, error);
            }
            return;
        }

        NSString *accessToken = nil;

        if([rep isKindOfClass:NSDictionary.class]) {
            accessToken = [(NSDictionary *)rep objectForKey:@"access_token"];
        }

        if (completion) {
            completion(accessToken, rep, nil);
        }
    }];
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
