//
//  ANAnnotation.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/1/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANResource.h"

@class ANDraftAnnotation;

@interface ANAnnotationSet : NSObject

- (id)initWithRepresentation:(id)rep session:(ANSession *)session;

@property (readonly) ANSession * session;
@property (readonly) NSArray * representation;

@property (readonly) NSArray * annotations;
@property (readonly) NSArray * annotationTypes;

- (NSArray*)annotationsOfType:(NSString*)type;

@end

@interface ANAnnotation : ANResource

@property (readonly) NSString * type;
@property (readonly) id value;

- (ANDraftAnnotation*)draftAnnotation;

@end
