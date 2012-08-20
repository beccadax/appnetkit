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

@interface ANResource : NSObject

+ (ISO8601DateFormatter*)dateFormatter;
+ (NSNumberFormatter*)IDFormatter;
- (id)initWithRepresentation:(NSDictionary*)rep session:(ANSession*)session;
- (id)initWithSession:(ANSession*)session;

@property (readonly,weak) ANSession * session;
@property (readonly,strong) NSMutableDictionary * representation;

// Warning: Trying to use this setter is likely to cause AppNetKit to catch fire.
@property (strong) NSDictionary * originalRepresentation;

- (void)revert;

@end

#define ANResourceSynthesize(KEY, GETTER_NAME, SETTER_NAME) \
- (id)GETTER_NAME { return self.representation[KEY]; } \
- (void)SETTER_NAME:(id)value { self.representation[KEY] = [value copy]; }

#define ANResourceSynthesizeDate(KEY, GETTER_NAME, SETTER_NAME) \
- (NSDate*)GETTER_NAME { return [ANResource.dateFormatter dateFromString:self.representation[KEY]]; } \
- (void)SETTER_NAME:(NSDate*)value { self.representation[KEY] = [ANResource.dateFormatter stringFromDate:value]; }

#define ANResourceSynthesizeBool(KEY, GETTER_NAME, SETTER_NAME) \
- (BOOL)GETTER_NAME { return [self.representation[KEY] boolValue]; } \
- (void)SETTER_NAME:(BOOL)value { self.representation[KEY] = @(value); }

#define ANResourceSynthesizeID(KEY, GETTER_NAME, SETTER_NAME) \
- (ANResourceID)GETTER_NAME { return [[ANResource.IDFormatter numberFromString:self.representation[KEY]] unsignedLongLongValue]; } \
- (void)SETTER_NAME:(ANResourceID)value { self.representation[KEY] = [ANResource.IDFormatter stringFromNumber:@(value)]; }

#define ANResourceSynthesizeNSUInteger(KEY, GETTER_NAME, SETTER_NAME) \
- (NSUInteger)GETTER_NAME { return [self.representation[KEY] unsignedIntegerValue]; } \
- (void)SETTER_NAME:(NSUInteger)value { self.representation[KEY] = @(value); }
