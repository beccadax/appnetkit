//
//  NSDictionary+dictionaryWithObjectsForKeys.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "NSDictionary+dictionaryWithObjectsForKeys.h"

@implementation NSDictionary (dictionaryWithObjectsForKeys)

- (NSDictionary*)dictionaryWithObjectsForKeys:(NSArray*)keys {
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    for(NSString * key in keys) {
        if([self objectForKey:key]) {
            [dict setObject:[self objectForKey:key] forKey:key];
        }
    }
    
    return dict.copy;
}

@end
