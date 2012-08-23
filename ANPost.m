//
//  ANPost.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANPost.h"

@implementation ANPost

@dynamic ID;
@dynamic createdAt;
@dynamic text;
@dynamic HTML;
@dynamic entitiesRepresentation;
@dynamic replyTo;
@dynamic threadID;
@dynamic numberOfReplies;
@dynamic annotations;
@dynamic deleted;
@dynamic userRepresentation;

- (ANEntitySet *)entities {
    return [[ANEntitySet alloc] initWithRepresentation:self.entitiesRepresentation session:self.session];
}

- (ANUser *)user {
    return [[ANUser alloc] initWithRepresentation:self.userRepresentation session:self.session];
}

- (void)postRepliedToWithCompletion:(ANPostRequestCompletion)completion {
    [self.session postWithID:self.ID completion:completion];
}

- (void)replyPostsWithCompletion:(ANPostListRequestCompletion)completion {
    [self.session postsReplyingToPostWithID:self.ID betweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postAtThreadRootWithCompletion:(ANPostRequestCompletion)completion {
    [self.session postWithID:self.ID completion:completion];
}

- (void)deleteWithCompletion:(ANPostRequestCompletion)completion {
    [self.session deletePostWithID:self.ID completion:completion];
}

- (NSUInteger)hash {
    if(self.ID == ANUnspecifiedPostID) {
        return (NSUInteger)self;
    }
    
    return (NSUInteger)self.ID ^ (NSUInteger)self.class;
}

- (BOOL)isEqual:(ANPost*)object {
    if(self.class != object.class) {
        return NO;
    }
    
    if(self.ID == ANUnspecifiedPostID || object.ID == ANUnspecifiedPostID) {
        return self == object;
    }
    
    return self.ID == object.ID;
}

@end
