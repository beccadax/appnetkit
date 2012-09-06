//
//  ADAppNetAuthenticator.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/17/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppNetKit.h"

extern NSString * const ANScopeStream;
extern NSString * const ANScopeEmail;
extern NSString * const ANScopeWritePost;
extern NSString * const ANScopeFollow;
extern NSString * const ANScopeMessages;
extern NSString * const ANScopeExport;

@interface ANAuthenticator : NSObject

+ (ANAuthenticator*)sharedAuthenticator;

@property (strong,nonatomic) NSString * clientID;
@property (strong,nonatomic) NSURL * redirectURL;
@property (assign,nonatomic) BOOL omitsPaymentOptions;

- (NSURL*)URLToAuthenticateForScopes:(NSArray*)scopes;  // Briefly shows a blank screen if the user has already logged in
- (NSURL*)URLToAuthorizeForScopes:(NSArray *)scopes;    // Always shows a permission screen, even if the user has already logged in

- (BOOL)isRedirectURL:(NSURL*)url;
- (NSString*)accessTokenFromRedirectURL:(NSURL*)redirectURL error:(NSError**)error;

@end
