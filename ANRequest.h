//
//  ANRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANSession;

typedef enum {
    ANRequestMethodGet,
    ANRequestMethodPost,
    ANRequestMethodDelete
} ANRequestMethod;

@interface ANRequest : NSObject

- (id)initWithSession:(ANSession*)session;

@property (readonly,weak) ANSession * session;

@property (readonly) NSURL * URL;
@property (readonly) NSDictionary * parameters;
@property (readonly) ANRequestMethod method;

- (void)sendRequestWithRepresentationCompletion:(void (^)(id rep, NSError * error))completion;

@end
