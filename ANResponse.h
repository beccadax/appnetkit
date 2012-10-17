//
//  ANResponse.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/2/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import <Foundation/Foundation.h>
#import "ANResource.h"
#import "ANDefines.h"

@interface ANResponse : ANResource

@property (nonatomic,readonly) NSUInteger statusCode;

@property (nonatomic,readonly) ANResourceID earliestID;
@property (nonatomic,readonly) ANResourceID latestID;
@property (nonatomic,readonly) BOOL hasMore;

@end
