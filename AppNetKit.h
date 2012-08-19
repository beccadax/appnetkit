//
//  AppNetKit.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const ANErrorDomain;
extern NSString * const ANExplanationURLKey;

typedef enum {
    ANGenericError,
    ANOAuthInvalidRequestError,
    ANOAuthUnauthorizedClientError,
    ANOAuthAccessDeniedError,
    ANOAuthUnsupportedResponseTypeError,
    ANOAuthInvalidScopeError,
    ANOAuthServerError,
    ANOAuthTemporarilyUnavailableError,
    
    ANBadRequestError = 400,
    ANUnauthorizedError,
    ANPaymentRequiredError,
    ANForbiddenError,
    ANNotFoundError,
    ANMethodNotAllowedError,
    ANNotAcceptableError,
    ANProxyAuthenticationRequiredError,
    ANRequestTimeoutError,
    ANConflictError,
    ANGoneError,
    ANLengthRequiredError,
    ANPreconditionFailedError,
    ANRequestEntityTooLargeError,
    ANRequestURITooLongError,
    ANUnsupportedMediaTypeError,
    ANRequestedRangeNotSatisfiableError,
    ANExpectationFailedError,
    
    ANInternalServerError = 500,
    ANNotImplementedError,
    ANBadGatewayError,
    ANServiceUnavailableError,
    ANGatewayTimeoutError,
    ANHTTPVersionNotSupportedError
} ANErrorCode;

typedef uint64_t ANResourceID;

#import "ANCompletions.h"
#import "ANAuthenticator.h"
#import "ANSession.h"
#import "ANUser.h"
#import "ANPost.h"
