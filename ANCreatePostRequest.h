//
//  ANCreatePostRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"
#import "ANSession.h"

@class ANDraft;

@interface ANCreatePostRequest : ANAuthenticatedRequest

@property (strong) ANDraft * draft;

- (void)sendRequestWithCompletion:(ANPostRequestCompletion)completion;

@end
