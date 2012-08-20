//
//  ANFollowingsForUserRequest.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"

@interface ANFollowingsForUserRequest : ANAuthenticatedRequest

@property (assign) ANResourceID userID;

- (void)sendRequestWithCompletion:(ANUserListRequestCompletion)completion;

@end
