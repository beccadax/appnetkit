//
//  ANPost.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANPost.h"

@implementation ANPost

ANResourceSynthesizeID(@"id", ID, setID)
ANResourceSynthesizeDate(@"created_at", createdAt, setCreatedAt)
ANResourceSynthesize(@"text", text, setText);
ANResourceSynthesize(@"html", HTML, setHTML)
ANResourceSynthesize(@"entities", entitiesRepresentation, setEntitiesRepresentation)
ANResourceSynthesizeID(@"reply_to", replyToID, setReplyToID)
ANResourceSynthesizeID(@"thread_id", threadID, setThreadID)
ANResourceSynthesizeNSUInteger(@"num_replies", numberOfReplies, setNumberOfReplies)
ANResourceSynthesize(@"annotations", annotations, setAnnotations)
ANResourceSynthesizeBool(@"is_deleted", isDeleted, setDeleted)
ANResourceSynthesize(@"user", userRepresentation, setUserRepresentation)

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

- (void)createWithCompletion:(ANPostRequestCompletion)completion {
    [self.session createPost:self completion:completion];
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
