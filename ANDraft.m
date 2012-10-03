//
//  ANDraft.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/23/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANDraft.h"
#import "ANResource.h"

@implementation ANDraft

- (id)init {
    if((self = [super init])) {
        _annotations = [NSMutableArray new];
    }
    return self;
}

- (NSDictionary *)representation {
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    if(self.machineOnly) {
        [dict setObject:@"1" forKey:@"machine_only"];
    }
    else {
        [dict setObject:self.text forKey:@"text"];
    }
    
    if(self.replyTo) {
        [dict setObject:[NSString stringWithFormat:@"%llu", self.replyTo] forKey:@"reply_to"];
    }
    if(self.annotations.count) {
        [dict setObject:[self.annotations valueForKey:@"representation"] forKey:@"annotations"];
    }
    
    return dict.copy;
}

- (void)setRepresentation:(NSDictionary *)dict {
    self.text = [dict objectForKey:@"text"];
    
    self.replyTo = ANUnspecifiedPostID;
    if([dict objectForKey:@"reply_to"]) {
        self.replyTo = [ANResource.IDFormatter numberFromString:[dict objectForKey:@"reply_to"]].unsignedLongLongValue;
    }
    
    [_annotations removeAllObjects];
    if([dict objectForKey:@"annotations"]) {
        for(NSDictionary * annotationRep in [dict objectForKey:@"annotations"]) {
            ANDraftAnnotation * annotation = [ANDraftAnnotation new];
            annotation.representation = annotationRep;
            [_annotations addObject:	annotation];
        }
    }
}

- (void)createPostViaSession:(ANSession*)session completion:(ANPostRequestCompletion)completion {
    [session createPostFromDraft:self completion:completion];
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
