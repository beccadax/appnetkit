//
//  ANCreatePostRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANRequest.h"
#import "ANSession.h"

@class ANPost;

@interface ANCreatePostRequest : ANRequest

@property (strong) ANPost * post;

- (void)sendRequestWithCompletion:(ANPostRequestCompletion)completion;

@end
