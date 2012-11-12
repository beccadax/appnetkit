//
//  NSObject+AssociatedObject.m
//  Alef
//
//  Created by Brent Royal-Gordon on 11/11/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "NSObject+AssociatedObject.h"
#import <objc/runtime.h>

@implementation NSObject (AssociatedObject)

- (id)associatedObjectForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)setAssociatedObject:(id)object forKey:(void *)key {
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)removeAllAssociatedObjects {
    objc_removeAssociatedObjects(self);
}

@end
