//
//  ANMutingsForUserRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANAuthenticatedRequest.h"

@interface ANMutingsForUserRequest : ANAuthenticatedRequest

- (void)sendRequestWithCompletion:(ANUserListRequestCompletion)completion;

@end
