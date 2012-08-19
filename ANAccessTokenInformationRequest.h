//
//  ANAccessTokenInformationRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"
#import "ANSession.h"

@interface ANAccessTokenInformationRequest : ANAuthenticatedRequest

- (void)sendRequestWithCompletion:(ANAccessTokenInformationRequestCompletion)completion;

@end
