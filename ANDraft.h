//
//  ANDraft.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/23/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import <Foundation/Foundation.h>
#import "AppNetKit.h"

@class ANUser;
@class ANDraftEntitySet;

@interface ANDraft : NSObject

@property (strong) NSString * text;
@property (assign) ANResourceID replyTo;
@property (assign) BOOL machineOnly;
@property (readonly) NSMutableArray * annotations;
@property (readonly) ANDraftEntitySet * entities;

@property (copy) NSDictionary * representation;

- (void)createPostViaSession:(ANSession*)session completion:(ANPostRequestCompletion)completion;

@end
