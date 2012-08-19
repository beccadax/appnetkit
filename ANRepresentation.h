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

@interface ANRepresentation : NSObject

+ (ISO8601DateFormatter*)dateFormatter;
- (id)initWithRepresentation:(NSDictionary*)rep session:(ANSession*)session;
- (id)initWithSession:(ANSession*)session;

@property (readonly,weak) ANSession * session;
@property (readonly,strong) NSMutableDictionary * representation;
@property (readonly,strong) NSDictionary * originalRepresentation;

- (void)revert;

@end

#define ANRepresentationSynthesizeString(KEY, GETTER_NAME, SETTER_NAME) \
- (NSString*)GETTER_NAME { return self.representation[KEY]; } \
- (void)SETTER_NAME:(NSString*)value { self.representation[KEY] = value.copy; }

#define ANRepresentationSynthesizeDate(KEY, GETTER_NAME, SETTER_NAME) \
- (NSDate*)GETTER_NAME { return [ANRepresentation.dateFormatter dateFromString:self.representation[KEY]]; } \
- (void)SETTER_NAME:(NSDate*)value { self.representation[KEY] = [ANRepresentation.dateFormatter stringFromDate:value]; }

#define ANRepresentationSynthesizeBool(KEY, GETTER_NAME, SETTER_NAME) \
- (BOOL)GETTER_NAME { return [self.representation[KEY] boolValue]; } \
- (void)SETTER_NAME:(BOOL)value { self.representation[KEY] = @(value); }

#define ANRepresentationSynthesizeID(KEY, GETTER_NAME, SETTER_NAME) \
- (ANRepresentationID)GETTER_NAME { return [self.representation[KEY] unsignedLongLongValue]; } \
- (void)SETTER_NAME:(ANRepresentationID)value { self.representation[KEY] = @(value); }

#define ANRepresentationSynthesizeNSUInteger(KEY, GETTER_NAME, SETTER_NAME) \
- (NSUInteger)GETTER_NAME { return [self.representation[KEY] unsignedIntegerValue]; } \
- (void)SETTER_NAME:(NSUInteger)value { self.representation[KEY] = @(value); }
