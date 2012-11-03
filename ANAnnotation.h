//
//  ANAnnotation.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/1/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANResource.h"

@class ANDraftAnnotation;
extern NSString * const ANAnnotationTypeGeolocation;

@interface ANAnnotationSet : NSObject

- (id)initWithRepresentation:(id)rep session:(ANSession *)session;

@property (readonly) ANSession * session;
@property (readonly) NSArray * representation;

@property (readonly) NSArray * all;
@property (readonly) NSArray * types;

- (NSArray*)annotationsOfType:(NSString*)type;

@end

@interface ANAnnotation : ANResource

@property (readonly) NSString * type;
@property (readonly) id value;

- (ANDraftAnnotation*)draftAnnotation;

@end

@interface ANDraftAnnotation : NSObject

@property (strong) NSString * type;
@property (strong) id value;

@property (copy) NSDictionary * representation;

@end

#import "ANDefines.h"

#if APPNETKIT_USE_CORE_LOCATION
#import <CoreLocation/CoreLocation.h>

@interface ANAnnotation (CLLocation)

@property (readonly) CLLocation * geolocationValue;

@end

@interface ANDraftAnnotation (CLLocation)

+ (ANDraftAnnotation*)draftAnnotationWithGeolocationValue:(CLLocation*)location;

@end

#endif
