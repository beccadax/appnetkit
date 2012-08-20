//
//  ANRequestReturningPostList.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANRequestReturningPostList.h"

@implementation ANRequestReturningPostList

- (id)initWithSession:(ANSession *)session {
    if((self = [super initWithSession:session])) {
        _sinceID = ANUnspecifiedPostID;
        _beforeID = ANUnspecifiedPostID;
        _count = 0;
        _includeUser = YES;
        _includeAnnotations = YES;
        _includeReplies = YES;
    }
    
    return self;
}

- (NSString*)stringForBoolean:(BOOL)boolean {
    return boolean ? @"True" : @"False";
}

- (NSDictionary *)parameters {
    NSMutableDictionary * params = @{
        @"include_user": [self stringForBoolean:self.includeUser],
        @"include_annotations": [self stringForBoolean:self.includeAnnotations],
        @"include_replies": [self stringForBoolean:self.includeReplies]
    }.mutableCopy;
    
    if(self.count) {
        params[@"count"] = [NSString stringWithFormat:@"%d", self.count];
    }
    if(self.beforeID) {
        params[@"before_id"] = [NSString stringWithFormat:@"%lld", self.beforeID];
    }
    if(self.sinceID) {
        params[@"since_id"] = [NSString stringWithFormat:@"%lld", self.sinceID];
    }
    
    return params.copy;
}

- (ANRequestMethod)method {
    return ANRequestMethodGet;
}

- (void)sendRequestWithCompletion:(ANPostListRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(id rep, NSError *error) {
        [self.session completePostListRequest:completion withRepresentation:rep error:error];
    }];
}

@end
