//
//  ANUsersWithPostRepostedRequest.h
//  Aleph
//
//  Created by Brent Royal-Gordon on 9/29/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"

@interface ANUsersWithPostRepostedRequest : ANAuthenticatedRequest

@property (assign) ANResourceID postID;

- (void)sendRequestWithCompletion:(ANUserListRequestCompletion)completion;

@end
