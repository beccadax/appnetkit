//
//  NSDictionary+dictionaryWithObjectsForKeys.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "NSDictionary+dictionaryWithObjectsForKeys.h"

@implementation NSDictionary (dictionaryWithObjectsForKeys)

- (NSDictionary*)dictionaryWithObjectsForKeys:(NSArray*)keys {
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    for(NSString * key in keys) {
        if(self[key]) {
            dict[key] = self[key];
        }
    }
    
    return dict.copy;
}

@end
