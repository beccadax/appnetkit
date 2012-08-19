//
//  ANAccessTokenInformationRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANRequest.h"
#import "ANSession.h"

@interface ANAccessTokenInformationRequest : ANRequest

- (void)sendRequestWithCompletion:(ANAccessTokenInformationRequestCompletion)completion;

@end
