//
//  ANPost.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANResource.h"
#import "ANSession.h"

@interface ANPost : ANResource

@property (readonly) ANResourceID ID;

@property (readonly) ANUser * user;
@property (readonly) NSDictionary * userRepresentation;

@property (readonly) NSDate * createdAt;
@property (copy) NSString * text;
@property (readonly) NSString * HTML;

//@property (readonly) ANSource * source;

@property (assign) ANResourceID replyToID;
- (void)postRepliedToWithCompletion:(ANPostRequestCompletion)completion;
- (void)replyPostsWithCompletion:(ANPostListRequestCompletion)completion;

@property (readonly) ANResourceID threadID;
@property (readonly) NSUInteger numberOfReplies;
- (void)postAtThreadRootWithCompletion:(ANPostRequestCompletion)completion;

//@property (readonly) NSMutableDictionary * annotations;
//@property (readonly) NSArray * entities;
//@property (readonly) NSMutableArray * links;

@property (readonly,getter=isDeleted) BOOL deleted;

- (void)createWithCompletion:(ANPostRequestCompletion)completion;
- (void)deleteWithCompletion:(ANPostRequestCompletion)completion;

@end
