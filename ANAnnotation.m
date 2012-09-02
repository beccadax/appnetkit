//
//  ANAnnotation.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/1/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAnnotation.h"
#import <objc/runtime.h>

@implementation ANAnnotationSet {
    NSArray * _annotations;
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

- (NSArray *)annotations {
    if(!_annotations) {
        [self buildAnnotations];
    }
    
    return _annotations;
}

- (NSArray *)annotationTypes {
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
    
    _annotations = annotations.copy;
    _annotationsByType = byType.copy;
}

@end

@implementation ANAnnotation

@dynamic type;
@dynamic value;

@end
