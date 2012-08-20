//
//  ANRepresentation.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANResource.h"
#import "ISO8601DateFormatter.h"
#import "ANSession.h"

@implementation ANResource

+ (ISO8601DateFormatter *)dateFormatter {
    static ISO8601DateFormatter * singleton;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        singleton = [ISO8601DateFormatter new];
    });
    
    return singleton;
}

+ (NSNumberFormatter *)IDFormatter {
    static NSNumberFormatter * singleton;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        singleton = [NSNumberFormatter new];
    });
    
    return singleton;

}

- (id)initWithSession:(ANSession *)session {
    return [self initWithRepresentation:nil session:session];
}

- (id)initWithRepresentation:(NSDictionary *)rep session:(ANSession *)session {
    if((self = [super init])) {
        _session = session;
        _originalRepresentation = rep.copy ?: @{};
        [self revert];
        
        self = [session uniqueResource:self];
    }
    return self;
}

- (NSUInteger)hash {
    return (NSUInteger)self.originalRepresentation.hash ^ (NSUInteger)self.class;
}

- (BOOL)isEqual:(ANResource*)object {
    if(self.class != object.class) {
        return NO;
    }
    
    return [self.originalRepresentation isEqual:object.originalRepresentation];
}

- (void)revert {
    _representation = _originalRepresentation.mutableCopy;
}

@end
