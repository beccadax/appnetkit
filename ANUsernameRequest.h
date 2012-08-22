//
//  ANUsernameRequest.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"
#import "AppNetKit.h"

@interface ANUsernameRequest : ANAuthenticatedRequest

@property (assign) NSString * username;

- (void)sendRequestWithCompletion:(ANUserRequestCompletion)completion;

@end
