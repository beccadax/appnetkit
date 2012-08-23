//
//  ANDraft.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/23/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANDraft.h"

@implementation ANDraft

- (id)init {
    if((self = [super init])) {
        _annotations = [NSMutableDictionary new];
    }
    return self;
}

- (NSDictionary *)representation {
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    [dict setObject:self.text forKey:@"text"];
    if(self.replyTo) {
        [dict setObject:[NSString stringWithFormat:@"%llu", self.replyTo] forKey:@"reply_to"];
    }
    if(self.annotations.count) {
        [dict setObject:self.annotations forKey:@"annotations"];
    }
    
    return dict.copy;
}

@end
