//
//  ANDraft.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/23/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import <Foundation/Foundation.h>
#import "AppNetKit.h"

@interface ANDraft : NSObject

@property (strong) NSString * text;
@property (assign) ANResourceID replyTo;
@property (assign) BOOL machineOnly;
@property (readonly) NSMutableArray * annotations;
//@property (strong) NSArray * links;

@property (copy) NSDictionary * representation;

- (void)createPostViaSession:(ANSession*)session completion:(ANPostRequestCompletion)completion;

@end

@interface ANDraftAnnotation : NSObject

@property (strong) NSString * type;
@property (strong) id value;

@property (copy) NSDictionary * representation;

@end

#import "ANDefines.h"
#if APPNETKIT_USE_CORE_LOCATION
#import <CoreLocation/CoreLocation.h>

@interface ANDraftAnnotation (CLLocation)

+ (ANDraftAnnotation*)draftAnnotationWithGeolocationValue:(CLLocation*)location;

@end

#endif