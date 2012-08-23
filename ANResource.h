//
//  ANRepresentation.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISO8601DateFormatter.h"

@class ANSession;
@class ANEntitySet;

@protocol ANTextualResource <NSObject>

@property (readonly) NSString * text;
@property (readonly) NSString * HTML;
@property (readonly) ANEntitySet * entities;
@property (readonly) NSDictionary * entitiesRepresentation;

@end

@interface ANResource : NSObject

+ (ISO8601DateFormatter*)dateFormatter;
+ (NSNumberFormatter*)IDFormatter;
- (id)initWithRepresentation:(NSDictionary*)rep session:(ANSession*)session;
- (id)initWithSession:(ANSession*)session;

@property (readonly,weak) ANSession * session;
@property (readonly,strong) NSMutableDictionary * representation;

// Warning: Trying to use this setter is likely to cause AppNetKit to catch fire.
@property (strong,nonatomic) NSDictionary * originalRepresentation;

- (void)revert;

@end

#import "ANEntity.h"
