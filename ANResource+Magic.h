//
//  ANResource+Magic.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/22/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANResource.h"

@interface ANResource (Magic)

+ (BOOL)resolveInstanceMethod:(SEL)sel;
+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key;

@end
