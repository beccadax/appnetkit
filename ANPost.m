//
//  ANPost.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANPost.h"

@implementation ANPost

@dynamic createdAt;
@dynamic text;
@dynamic HTML;
@dynamic entities;
@dynamic entitiesRepresentation;
@dynamic replyTo;
@dynamic threadID;
@dynamic numberOfReplies;
@dynamic annotations;
@dynamic deleted;
@dynamic user;
@dynamic userRepresentation;
@dynamic source;
@dynamic sourceRepresentation;

- (ANDraft*)draftForward {
    ANDraft * draft = [ANDraft new];
    
    draft.text = [NSString stringWithFormat:@"» %@ %@", self.user.username.appNetUsernameString, self.text];
    
    return draft;
}

- (ANDraft*)draftCopy {
    ANDraft * draft = [ANDraft new];
    
    draft.text = self.text;
    draft.replyTo = self.replyTo;
    [draft.annotations setDictionary:self.annotations];
    
    return draft;
}

- (ANDraft*)draftReply {
    ANDraft * draft = [self.user draftMention];
    
    draft.replyTo = self.ID;
    
    return draft;
}

- (ANDraft*)draftReplyToAllExceptUser:(ANUser*)user {
    NSMutableOrderedSet * usernames = [NSMutableOrderedSet orderedSetWithObject:self.user.username.appNetUsernameString];
    for(ANEntity * mention in self.entities.mentions) {
        if(mention.userID != user.ID) {
            [usernames addObject:mention.name.appNetUsernameString];
        }
    }
    
    ANDraft * draft = [ANDraft new];
    
    draft.text = [[usernames.array componentsJoinedByString:@" "] stringByAppendingString:@" "];
    draft.replyTo = self.ID;
    
    return draft;
}

- (ANDraft*)draftReplyToAllExceptUsername:(NSString*)username {
    NSMutableOrderedSet * usernames = [NSMutableOrderedSet orderedSetWithObject:self.user.username.appNetUsernameString];
    for(ANEntity * mention in self.entities.mentions) {
        if(![mention.name isEqualToString:username]) {
            [usernames addObject:mention.name.appNetUsernameString];
        }
    }
    
    ANDraft * draft = [ANDraft new];
    
    draft.text = [[usernames.array componentsJoinedByString:@" "] stringByAppendingString:@" "];
    draft.replyTo = self.ID;
    
    return draft;
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
