//
//  ANUserDescription.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANUserDescription.h"

@implementation ANUserDescription

@dynamic text;
@dynamic HTML;
@dynamic entitiesRepresentation;

- (ANEntitySet *)entities {
    return [[ANEntitySet alloc] initWithRepresentation:self.entitiesRepresentation session:self.session];
}

@end
