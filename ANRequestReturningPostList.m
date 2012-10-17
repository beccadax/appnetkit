//
//  ANRequestReturningPostList.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
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
        _includeDirectedPosts = YES;
        _includeDeleted = YES;
        _includeMuted = NO;
        _includeStarredBy = NO;
        _includeMachine = NO;
        _includeReposters = NO;
    }
    
    return self;
}

- (NSString*)stringForBoolean:(BOOL)boolean {
    return boolean ? @"1" : @"0";
}

- (NSDictionary *)parameters {
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    [self stringForBoolean:self.includeUser], @"include_user",
                                    [self stringForBoolean:self.includeAnnotations], @"include_annotations",
                                    [self stringForBoolean:self.includeReplies], @"include_replies",
                                    [self stringForBoolean:self.includeDirectedPosts], @"include_directed_posts",
                                    [self stringForBoolean:self.includeDeleted], @"include_deleted",
                                    [self stringForBoolean:self.includeMuted], @"include_muted",
                                    [self stringForBoolean:self.includeStarredBy], @"include_starred_by",
                                    [self stringForBoolean:self.includeMachine], @"include_machine",
                                    [self stringForBoolean:self.includeReposters], @"include_reposters",
                                    nil];
    
    if(self.count) {
        [params setObject:[NSString stringWithFormat:@"%d", self.count] forKey:@"count"];
    }
    if(self.beforeID) {
        [params setObject:[NSString stringWithFormat:@"%lld", self.beforeID] forKey:@"before_id"];
    }
    if(self.sinceID) {
        [params setObject:[NSString stringWithFormat:@"%lld", self.sinceID] forKey:@"since_id"];
    }
    
    return params.copy;
}

- (ANRequestMethod)method {
    return ANRequestMethodGet;
}

- (void)sendRequestWithCompletion:(ANPostListRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(ANResponse * response, id rep, NSError *error) {
        [self.session completePostListRequest:completion withResponse:response representation:rep error:error];
    }];
}

@end
