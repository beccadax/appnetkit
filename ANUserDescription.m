//
//  ANUserDescription.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANUserDescription.h"

@implementation ANUserDescription

ANResourceSynthesize(@"text", text, setText);
ANResourceSynthesize(@"html", HTML, setHTML);
ANResourceSynthesize(@"entities", entitiesRepresentation, setEntitiesRepresentation)

- (ANEntitySet *)entities {
    return [[ANEntitySet alloc] initWithRepresentation:self.entitiesRepresentation session:self.session];
}

@end
