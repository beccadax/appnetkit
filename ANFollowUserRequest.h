//
//  ANFollowUserRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANAuthenticatedRequest.h"
#import "AppNetKit.h"

@interface ANFollowUserRequest : ANAuthenticatedRequest

@property (assign) ANResourceID userID;

- (void)sendRequestWithCompletion:(ANUserRequestCompletion)completion;

@end
