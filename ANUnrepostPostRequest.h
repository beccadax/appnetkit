//
//  ANUnrepostPostRequest.h
//  Aleph
//
//  Created by Brent Royal-Gordon on 9/28/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"

@interface ANUnrepostPostRequest : ANAuthenticatedRequest

@property (assign) ANResourceID postID;

- (void)sendRequestWithCompletion:(ANPostRequestCompletion)completion;

@end
