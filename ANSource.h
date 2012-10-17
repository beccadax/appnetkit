//
//  ANSource.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/27/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANResource.h"

@interface ANSource : ANResource

@property (readonly) NSString * clientID;
@property (readonly) NSString * name;
@property (readonly) NSURL * link;

@end
