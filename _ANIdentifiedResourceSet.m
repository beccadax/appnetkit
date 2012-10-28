//
//  _ANIdentifiedResourceSet.m
//  Alef
//
//  Created by Brent Royal-Gordon on 10/27/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "_ANIdentifiedResourceSet.h"

@interface _ANIdentifiedResourceSet ()

@property (strong,nonatomic) NSHashTable * resources;

@end

@implementation _ANIdentifiedResourceSet

- (id)init {
    if((self = [super init])) {
        _resources = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (void)addResource:(ANIdentifiedResource *)resource {
    [self.resources addObject:resource];
}

- (ANIdentifiedResource *)existingResource:(ANIdentifiedResource *)resource {
    return [self.resources member:resource];
}

- (void)removeResource:(ANIdentifiedResource *)resource {
    [self.resources removeObject:resource];
}

@end
