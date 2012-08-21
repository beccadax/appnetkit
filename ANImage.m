//
//  ANImage.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANImage.h"

@implementation ANImage

- (NSURL *)URL {
    return [NSURL URLWithString:[self.representation objectForKey:@"url"]];
}

- (CGSize)size {
    CGSize size;
    size.width = [[self.representation objectForKey:@"width"] doubleValue];
    size.height = [[self.representation objectForKey:@"height"] doubleValue];
    return size;
}

@end
