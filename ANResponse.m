//
//  ANResponse.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/2/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANResponse.h"

@interface ANResponse ()

@property (readonly) NSUInteger minID;
@property (readonly) NSUInteger maxID;
@property (readonly) BOOL more;

@end

@implementation ANResponse

- (ANResourceID)earliestID {
    return self.minID;
}

- (ANResourceID)latestID {
    return self.maxID;
}

- (BOOL)hasMore {
    return self.more;
}

@end
