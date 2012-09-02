//
//  ANResponse.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/2/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANResponse.h"

@interface ANResponse ()

@property (nonatomic,readonly) NSUInteger code;
@property (nonatomic,readonly) NSUInteger minID;
@property (nonatomic,readonly) NSUInteger maxID;
@property (nonatomic,readonly) BOOL more;

@end

@implementation ANResponse

@dynamic code;
@dynamic minID;
@dynamic maxID;
@dynamic more;

- (NSUInteger)statusCode {
    return self.code;
}

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
