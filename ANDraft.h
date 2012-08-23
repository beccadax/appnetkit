//
//  ANDraft.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/23/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppNetKit.h"

@interface ANDraft : NSObject

@property (strong) NSString * text;
@property (assign) ANResourceID replyTo;
@property (readonly) NSMutableDictionary * annotations;
//@property (strong) NSArray * links;

@property (readonly) NSDictionary * representation;

- (void)createPostViaSession:(ANSession*)session completion:(ANPostRequestCompletion)completion;

@end
