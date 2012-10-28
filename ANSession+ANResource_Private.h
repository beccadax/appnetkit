//
//  ANSession_ANResource_Private.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/23/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

// This header declares private details of ANSession and ANResource that they use to manage each other.
// No user serviceable parts inside.

#import "ANSession.h"

@interface ANSession ()

- (id)uniqueResource:(ANIdentifiedResource*)resource;

@end

@interface ANResource ()

@property (readwrite,strong,nonatomic) NSDictionary * representation;

@end
