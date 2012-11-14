//
//  ANStreamMarker.m
//  Alef
//
//  Created by Brent Royal-Gordon on 11/13/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANStreamMarker.h"
#import "ANSession+Requests.h"

const NSUInteger ANStreamMarkerUnspecifiedPercentage = 0;

@interface ANStreamMarker ()

@property (nonatomic,readonly) ANResourceID ID;

@end

@implementation ANStreamMarker

@dynamic name;
@dynamic ID;
@dynamic percentage;
@dynamic updatedAt;
@dynamic version;

- (ANResourceID)postID {
    return self.ID;
}

- (BOOL)isMarked {
    return [self.representation objectForKey:@"id"] != nil;
}

- (ANDraftStreamMarker*)draftStreamMarkerWithPostID:(ANResourceID)postID percentage:(NSUInteger)percentage {
    ANDraftStreamMarker * draft = [ANDraftStreamMarker new];
    
    draft.name = self.name;
    draft.postID = postID;
    draft.percentage = percentage;
    
    return draft;
}

- (void)updateWithPostID:(ANResourceID)postID percentage:(NSUInteger)percentage completion:(ANStreamMarkerRequestCompletion)completion {
    [[self draftStreamMarkerWithPostID:postID percentage:percentage] updateViaSession:self.session completion:completion];
}

@end

@implementation ANDraftStreamMarker

- (NSDictionary *)representation {
    NSMutableDictionary * rep = [NSMutableDictionary new];
    
    [rep setObject:self.name forKey:@"name"];
    if(self.postID) {
        [rep setObject:[ANResource.IDFormatter stringFromNumber:[NSNumber numberWithUnsignedLongLong:self.postID]] forKey:@"id"];
    }
    if(self.percentage) {
        [rep setObject:[NSString stringWithFormat:@"%d", self.percentage] forKey:@"percentage"];
    }
    
    return rep;
}

- (void)setRepresentation:(NSDictionary *)rep {
    self.name = [rep objectForKey:@"name"];
    self.postID = [[ANResource.IDFormatter numberFromString:[rep objectForKey:@"id"]] unsignedLongLongValue];
    self.percentage = [[rep objectForKey:@"percentage"] integerValue];
}

- (void)updateViaSession:(ANSession *)session completion:(ANStreamMarkerRequestCompletion)completion {
    [session updateStreamMarkerWithDraft:self completion:completion];
}

@end