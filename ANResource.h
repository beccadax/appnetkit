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
- (id)GETTER_NAME { return [self.representation objectForKey:KEY]; } \
- (void)SETTER_NAME:(id)value { [self.representation setObject:[value copy] forKey:KEY]; }

#define ANResourceSynthesizeDate(KEY, GETTER_NAME, SETTER_NAME) \
- (NSDate*)GETTER_NAME { return [ANResource.dateFormatter dateFromString:[self.representation objectForKey:KEY]]; } \
- (void)SETTER_NAME:(NSDate*)value { [self.representation setObject:[ANResource.dateFormatter stringFromDate:value] forKey:KEY]; }

#define ANResourceSynthesizeBool(KEY, GETTER_NAME, SETTER_NAME) \
- (BOOL)GETTER_NAME { return [[self.representation objectForKey:KEY] boolValue]; } \
- (void)SETTER_NAME:(BOOL)value { [self.representation setObject:[NSNumber numberWithBool:value] forKey:KEY]; }

#define ANResourceSynthesizeID(KEY, GETTER_NAME, SETTER_NAME) \
- (ANResourceID)GETTER_NAME { return [[ANResource.IDFormatter numberFromString:[self.representation objectForKey:KEY]] unsignedLongLongValue]; } \
- (void)SETTER_NAME:(ANResourceID)value { [self.representation setObject:[ANResource.IDFormatter stringFromNumber:[NSNumber numberWithUnsignedLongLong:value]] forKey:KEY]; }

#define ANResourceSynthesizeNSUInteger(KEY, GETTER_NAME, SETTER_NAME) \
- (NSUInteger)GETTER_NAME { return [[self.representation objectForKey:KEY] unsignedIntegerValue]; } \
- (void)SETTER_NAME:(NSUInteger)value { [self.representation setObject:[NSNumber numberWithUnsignedInteger:value] forKey:KEY]; }
