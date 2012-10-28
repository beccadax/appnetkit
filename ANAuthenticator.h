//
//  ADAppNetAuthenticator.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/17/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import <Foundation/Foundation.h>
#import "AppNetKit.h"

// Use an array of these constants to specify the scopes you want to request.
extern NSString * const ANScopeStream;
extern NSString * const ANScopeEmail;
extern NSString * const ANScopeWritePost;
extern NSString * const ANScopeFollow;
extern NSString * const ANScopeMessages;
extern NSString * const ANScopeExport;

@interface ANAuthenticator : NSObject

+ (ANAuthenticator*)sharedAuthenticator;

@property (strong,nonatomic) NSString * clientID;

#pragma mark OAuth authentication flow

// 
// OAuth browser-based authentication. Use these methods if you want to show an App.net-controlled web page with username and password fields.
// 
// Basic usage:
// 
// 1. Set the clientID and redirectURL.
// 
// 2. Call -URLToAuthenticateForScopes: or URLToAuthorizeForScopes: to get an HTTP URL.
// 
// 3. Show that URL in a web view or in the user's default browser.
// 
// 4. If you're using a web view, register as the web view's delegate and test each URL they navigate to with -isRedirectURL:. If you're using the user's browser, make sure the redirectURL has a URL scheme that will open your app, and test URLs your app is opened with with -isRedirectURL:.
// 
// 5. Once you've determined you have a redirect URL on your hands, extract the access token and error message from it with -accessTokenFromRedirectURL:error:.
// 

@property (strong,nonatomic) NSURL * redirectURL;
@property (assign,nonatomic) BOOL omitsPaymentOptions;

- (NSURL*)URLToAuthenticateForScopes:(NSArray*)scopes;  // Briefly shows a blank screen if the user has already logged in
- (NSURL*)URLToAuthorizeForScopes:(NSArray *)scopes;    // Always shows a permission screen, even if the user has already logged in

- (BOOL)isRedirectURL:(NSURL*)url;
- (NSString*)accessTokenFromRedirectURL:(NSURL*)redirectURL error:(NSError**)error;

#pragma mark Password authentication flow

// 
// Password authentication. Use these methods if you want to display your own login user interface.
// 
// Usage:
// 
// 1. Set the passwordGrantSecret to the one the App.net guys gave you. This is not listed anywhere online; you have to email the staff and ask them to generate one for you. Also set the clientID to the one listed online.
//
// 2. Show a UI with username and password fields, information about which scopes your app will be requesting, and a login button.
// 
// 3. When the user hits the login button, call -accessTokenForScopes:withUsername:password:completion:, and show some sort of progress indicator on screen.
// 
// 4. The completion handler will be called with either an accessToken for the account or an error.
//
// Quick example:
/*
    ANAuthenticator.sharedAuthenticator.clientID = myClientID;
    ANAuthenticator.sharedAuthenticator.passwordGrantSecret = mySecret;
    
    [progressIndicator startAnimating];
    
    [ANAuthenticator.sharedAuthenticator accessTokenForScopes:@[ ANScopeStream, ANScopeWritePost ] withUsername:usernameField.text password:passwordField.text completion:^(NSString * accessToken, id rep, NSError * error) {
        [progressIndicator stopAnimating];
        
        if(!accessToken) {
            [self showErrorToUser:error];
            return;
        }
        
        MyAccount * newAccount = [MyAccount new];
        newAccount.token = accessToken;
        [newAccount save];
        
        [self showTheAppForAccount:newAccount];
    }];
*/ 
// App.net has certain requirements for your app if you use password auth. Make sure you follow them! See this page for details: <https://github.com/appdotnet/api-spec/blob/master/password_auth.md>
// 

@property (strong,nonatomic) NSString * passwordGrantSecret;

- (void)accessTokenForScopes:(NSArray *)scopes withUsername:(NSString *)username password:(NSString *)password completion:(void (^)(NSString *accessToken, id rep, NSError * error))completion;

@end
