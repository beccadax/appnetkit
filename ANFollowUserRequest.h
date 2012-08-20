//
//  ANFollowUserRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"
#import "AppNetKit.h"

@interface ANFollowUserRequest : ANAuthenticatedRequest

@property (assign) ANResourceID userID;

- (void)sendRequestWithCompletion:(ANUserRequestCompletion)completion;

@end
