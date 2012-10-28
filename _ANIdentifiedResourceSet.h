//
//  _ANIdentifiedResourceSet.h
//  Alef
//
//  Created by Brent Royal-Gordon on 10/27/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANIdentifiedResource.h"

// This table is used by ANSession to unique identified resources without holding strong references to them.
// No user serviceable parts inside.

@interface _ANIdentifiedResourceSet : NSObject

- (void)addResource:(ANIdentifiedResource*)resource;
- (ANIdentifiedResource*)existingResource:(ANIdentifiedResource*)resource;
- (void)removeResource:(ANIdentifiedResource*)resource;

@end
