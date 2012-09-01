//
//  ANIdentifiedResource.m
//  
//
//  Created by Brent Royal-Gordon on 8/31/12.
//
//

#import "ANIdentifiedResource.h"

@implementation ANIdentifiedResource

@dynamic ID;

- (NSUInteger)hash {
    return (NSUInteger)self.ID ^ (NSUInteger)self.class;
}

- (BOOL)isEqual:(ANIdentifiedResource*)object {
    if(self.class != object.class) {
        return NO;
    }
    
    return self.ID == object.ID;
}

@end
