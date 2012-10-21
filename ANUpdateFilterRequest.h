//
//  ANUpdateFilterRequest.h
//  Alef
//
//  Created by Brent Royal-Gordon on 10/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"

@interface ANUpdateFilterRequest : ANAuthenticatedRequest

@property (nonatomic,assign) ANResourceID filterID;
@property (nonatomic,strong) ANDraftFilter * draftFilter;

- (void)sendRequestWithCompletion:(ANFilterRequestCompletion)completion;

@end
