//
//  ANEntity.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/22/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANResource.h"
#import "AppNetKit.h"

typedef enum {
    ANEntityTypeMention,
    ANEntityTypeTag,
    ANEntityTypeLink
} ANEntityType;

@interface ANEntitySet : ANResource

@property (readonly) NSArray * all;

@property (readonly) NSArray * mentions;
@property (readonly) NSArray * mentionRepresentations;

@property (readonly) NSArray * tags;
@property (readonly) NSArray * tagRepresentations;

@property (readonly) NSArray * links;
@property (readonly) NSArray * linkRepresentations;

@end

@interface ANEntity : ANResource

@property (readonly) ANEntityType entityType;
@property (readonly) NSRange range;

@property (readonly) NSString * name;
@property (readonly) ANResourceID userID;

@property (readonly) NSURL * URL;
@property (readonly) NSString * text;

@end

