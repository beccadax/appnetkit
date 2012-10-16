//
//  ANUsersMatchingSearchQueryRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 9/29/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"

@interface ANUsersMatchingSearchQueryRequest : ANAuthenticatedRequest

@property (copy) NSString * query;

- (void)sendRequestWithCompletion:(ANUserListRequestCompletion)completion;

@end
