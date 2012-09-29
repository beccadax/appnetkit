//
//  ANSource.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/27/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANResource.h"

@interface ANSource : ANResource

@property (readonly) NSString * clientID;
@property (readonly) NSString * name;
@property (readonly) NSURL * link;

@end
