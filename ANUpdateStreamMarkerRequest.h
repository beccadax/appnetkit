//
//  ANUpdateStreamMarkerRequest.h
//  Alef
//
//  Created by Brent Royal-Gordon on 11/13/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"
#import "ANStreamMarker.h"

@interface ANUpdateStreamMarkerRequest : ANAuthenticatedRequest

@property (nonatomic,strong) ANDraftStreamMarker * draftMarker;

- (void)sendRequestWithCompletion:(ANStreamMarkerRequestCompletion)completion;

@end
