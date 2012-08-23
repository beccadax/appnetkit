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

- (id)initWithRepresentation:(NSDictionary*)rep session:(ANSession*)session;

@property (readonly,weak,nonatomic) ANSession * session;
@property (readonly,strong,nonatomic) NSDictionary * representation;

+ (ISO8601DateFormatter*)dateFormatter;
+ (NSNumberFormatter*)IDFormatter;

@end

#import "ANEntity.h"
