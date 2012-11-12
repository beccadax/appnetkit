//
//  ANIdentifiedResource.m
//  
//
//  Created by Brent Royal-Gordon on 8/31/12.
//
//

#import "ANIdentifiedResource.h"
#import "ANSession.h"
#import "ANSession+ANResource_Private.h"

@implementation ANIdentifiedResource

@dynamic ID;

- (id)initWithRepresentation:(NSDictionary *)rep session:(ANSession *)session {
    if((self = [super initWithRepresentation:rep session:session])) {
        self = [session uniqueResource:self];
    }
    return self;
}

- (NSUInteger)hash {
    return (NSUInteger)self.ID ^ (NSUInteger)self.class;
}

- (BOOL)isEqual:(ANIdentifiedResource*)object {
    if(self.class != object.class) {
        return NO;
    }
    
    return self.ID == object.ID;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p #%lld>", self.class, self, self.ID];
}

@end
