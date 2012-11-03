//
//  ANAnnotation.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/1/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANAnnotation.h"
#import "ANDraft.h"

NSString * const ANAnnotationTypeGeolocation = @"net.app.core.geolocation";

@implementation ANAnnotationSet {
    NSArray * _all;
    NSDictionary * _annotationsByType;
}

- (id)initWithRepresentation:(id)rep session:(ANSession *)session {
    NSParameterAssert(session);
    if((self = [super init])) {
        _representation = rep;
        _session = session;
    }
    
    return self;
}

- (NSArray *)all {
    if(!_all) {
        [self buildAnnotations];
    }
    
    return _all;
}

- (NSArray *)types {
    if(!_annotationsByType) {
        [self buildAnnotations];
    }
    
    return [_annotationsByType allKeys];
}

- (NSArray *)annotationsOfType:(NSString *)type {
    if(!_annotationsByType) {
        [self buildAnnotations];
    }
    
    return [_annotationsByType objectForKey:type];
}

- (void)buildAnnotations {
    NSMutableArray * annotations = [NSMutableArray new];
    NSMutableDictionary * byType = [NSMutableDictionary new];
    
    for(NSDictionary * rep in self.representation) {
        ANAnnotation * annotation = [[ANAnnotation alloc] initWithRepresentation:rep session:self.session];
        [annotations addObject:annotation];
        
        if(![byType objectForKey:annotation.type]) {
            [byType setObject:[NSMutableArray new] forKey:annotation.type];
        }
        
        [[byType objectForKey:annotation.type] addObject:annotation];
    }
    
    _all = annotations.copy;
    _annotationsByType = byType.copy;
}

@end

@implementation ANAnnotation

@dynamic type;
@dynamic value;

- (ANDraftAnnotation *)draftAnnotation {
    ANDraftAnnotation * draft = [ANDraftAnnotation new];
    draft.type = self.type;
    draft.value = self.value;
    return draft;
}

@end

@implementation ANDraftAnnotation

- (NSDictionary *)representation {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            self.type, @"type",
            self.value, @"value",
            nil];
}

- (void)setRepresentation:(NSDictionary *)dict {
    self.type = [dict objectForKey:@"type"];
    self.value = [dict objectForKey:@"value"];
}

@end

#if APPNETKIT_USE_CORE_LOCATION
@implementation ANAnnotation (CLLocation)

- (CLLocationCoordinate2D)geolocationCoordinateValue {
    double lat = [[self.value objectForKey:@"latitude"] doubleValue];
    double lng = [[self.value objectForKey:@"longitude"] doubleValue];
    
    return CLLocationCoordinate2DMake(lat, lng);
}

- (CLLocationDistance)geolocationAltitudeValue {
    NSNumber * alt = [self.value objectForKey:@"altitude"];
    if(!alt) {
        return 0;
    }
    
    return alt.doubleValue;
}

- (CLLocationAccuracy)geolocationHorizontalAccuracyValue {
    NSNumber * horiz = [self.value objectForKey:@"horizontal_accuracy"];
    
    if(!horiz) {
        return 0;
    }
    
    return horiz.doubleValue;
}

- (CLLocationAccuracy)geolocationVerticalAccuracyValue {
    if(![self.value objectForKey:@"altitude"]) {
        // Return a negative to indicate the corresponding field is invalid.
        return -1;
    }
    
    NSNumber * vert = [self.value objectForKey:@"vertical_accuracy"];
    
    if(!vert) {
        return 0;
    }
    
    return vert.doubleValue;
}

- (CLLocation *)geolocationValue {
    if(![self.type isEqualToString:ANAnnotationTypeGeolocation]) {
        return nil;
    }
    
    return [[CLLocation alloc] initWithCoordinate:[self geolocationCoordinateValue] altitude:[self geolocationAltitudeValue] horizontalAccuracy:[self geolocationHorizontalAccuracyValue] verticalAccuracy:[self geolocationVerticalAccuracyValue] timestamp:nil];
}

@end

@implementation ANDraftAnnotation (CLLocation)

+ (ANDraftAnnotation *)draftAnnotationWithGeolocationValue:(CLLocation *)location {
    NSMutableDictionary * dict = [NSMutableDictionary new];
    [dict setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"latitude"];
    [dict setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:@"longitude"];
    
    if(location.verticalAccuracy >= 0) {
        [dict setObject:[NSNumber numberWithDouble:location.altitude] forKey:@"altitude"];
    }
    if(location.verticalAccuracy > 0) {
        [dict setObject:[NSNumber numberWithDouble:location.verticalAccuracy] forKey:@"vertical_accuracy"];
    }
    if(location.horizontalAccuracy > 0) {
        [dict setObject:[NSNumber numberWithDouble:location.horizontalAccuracy] forKey:@"horizontal_accuracy"];
    }
    
    ANDraftAnnotation * annotation = [ANDraftAnnotation new];
    annotation.type = ANAnnotationTypeGeolocation;
    annotation.value = dict.copy;
    return annotation;
}

@end

#endif
