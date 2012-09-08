//
//  ANStarPostRequest.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/7/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"

@interface ANStarPostRequest : ANAuthenticatedRequest

@property (assign) ANResourceID postID;

- (void)sendRequestWithCompletion:(ANPostRequestCompletion)completion;

@end
