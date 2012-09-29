//
//  ANRequestReturningPostList.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"
#import "AppNetKit.h"

@interface ANRequestReturningPostList : ANAuthenticatedRequest

@property (assign) ANResourceID sinceID;
@property (assign) ANResourceID beforeID;
@property (assign) NSUInteger count;

@property (assign) BOOL includeUser;
@property (assign) BOOL includeAnnotations;
@property (assign) BOOL includeReplies;
@property (assign) BOOL includeDirectedPosts;
@property (assign) BOOL includeMuted;
@property (assign) BOOL includeDeleted;
@property (assign) BOOL includeStarredBy;
@property (assign) BOOL includeReposters;

- (void)sendRequestWithCompletion:(ANPostListRequestCompletion)completion;

@end
