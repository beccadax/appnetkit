//
//  ANUnrepostPostRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 9/28/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANAuthenticatedRequest.h"

@interface ANUnrepostPostRequest : ANAuthenticatedRequest

@property (assign) ANResourceID postID;

- (void)sendRequestWithCompletion:(ANPostRequestCompletion)completion;

@end
