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

- (ANDraft*)draftForward {
    ANDraft * draft = [ANDraft new];
    
    draft.text = [NSString stringWithFormat:@"» @%@ %@", self.user.username, self.text];
    
    return draft;
}

- (ANDraft*)draftReply {
    ANDraft * draft = [self.user draftMention];
    
    draft.replyTo = self.ID;
    
    return draft;
}

- (ANDraft*)draftCopy {
    ANDraft * draft = [ANDraft new];
    
    draft.text = self.text;
    draft.replyTo = self.replyTo;
    [draft.annotations setDictionary:self.annotations];
    
    return draft;
}

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
    return (NSUInteger)self.ID ^ (NSUInteger)self.class;
}

- (BOOL)isEqual:(ANPost*)object {
    if(self.class != object.class) {
        return NO;
    }
    
    return self.ID == object.ID;
}

@end
