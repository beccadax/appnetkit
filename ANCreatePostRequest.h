//
//  ANCreatePostRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"
#import "ANSession.h"

@class ANPost;

@interface ANCreatePostRequest : ANAuthenticatedRequest

@property (strong) ANPost * post;

- (void)sendRequestWithCompletion:(ANPostRequestCompletion)completion;

@end
