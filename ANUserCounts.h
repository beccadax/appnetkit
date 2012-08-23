//
//  ANUserCounts.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANResource.h"

@interface ANUserCounts : ANResource

@property (readonly) NSUInteger follows;
@property (readonly) NSUInteger followedBy;
@property (readonly) NSUInteger posts;

@end
