//
//  NSObject+AssociatedObject.h
//  Alef
//
//  Created by Brent Royal-Gordon on 11/11/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AssociatedObject)

- (id)associatedObjectForKey:(void*)key;
- (void)setAssociatedObject:(id)object forKey:(void*)key;
- (void)removeAllAssociatedObjects;

@end
