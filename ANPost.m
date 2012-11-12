//
//  ANPost.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANPost.h"
#import "NSObject+AssociatedObject.h"

@implementation ANPost

@dynamic createdAt;
@dynamic canonicalURL;
@dynamic text;
@dynamic HTML;
@dynamic entities;
@dynamic entitiesRepresentation;
@dynamic replyTo;
@dynamic threadID;
@dynamic numberOfReplies;
@dynamic annotationRepresentations;
@dynamic deleted;
@dynamic user;
@dynamic userRepresentation;
@dynamic source;
@dynamic sourceRepresentation;
@dynamic machineOnly;
@dynamic numberOfStars;
@dynamic youStarred;
@dynamic starredByRepresentation;
@dynamic numberOfReposts;
@dynamic youReposted;
@dynamic reposters;
@dynamic repostersRepresentation;
@dynamic repostOf;
@dynamic repostOfRepresentation;

- (ANAnnotationSet *)annotations {
    // We use an associated object here so that setRepresentation: will clear it.
    ANAnnotationSet * annotations = [self associatedObjectForKey:_cmd];
    if(!annotations) {
        annotations = [[ANAnnotationSet alloc] initWithRepresentation:self.annotationRepresentations session:self.session];
        [self setAssociatedObject:annotations forKey:_cmd];
    }
    return annotations;
}

- (NSArray *)starredBy {
    if(self.starredByRepresentation == nil) {
        return nil;
    }
    
    NSMutableArray * array = [NSMutableArray new];
    
    for(NSDictionary * rep in self.starredByRepresentation) {
        [array addObject:[[ANUser alloc] initWithRepresentation:rep session:self.session]];
    }
    
    return array;
}

- (ANDraft*)draftForward {
    ANDraft * draft = [ANDraft new];
    
    draft.text = [NSString stringWithFormat:@"» %@ %@", self.user.username.appNetUsernameString, self.text];
    [draft.entities.links addObjectsFromArray:[self.entities.links valueForKey:@"draftEntity"]];
    
    return draft;
}

- (ANDraft*)draftCopy {
    ANDraft * draft = [ANDraft new];
    
    draft.text = self.text;
    draft.replyTo = self.replyTo;
    [draft.annotations setArray:[self.annotations.all valueForKey:@"draftAnnotation"]];
    
    draft.machineOnly = self.machineOnly;
    
    if(self.machineOnly) {
        [draft.entities.mentions addObjectsFromArray:[self.entities.mentions valueForKey:@"draftEntity"]];
    }
    else {
        [draft.entities.links addObjectsFromArray:[self.entities.links valueForKey:@"draftEntity"]];
    }
    
    return draft;
}

- (NSMutableOrderedSet*)mentionsForDirectReply {
    NSMutableOrderedSet * mentions = self.repostOf ? [self.repostOf mentionsForDirectReply] : [NSMutableOrderedSet new];
    
    [mentions addObject:self.user.username.appNetUsernameString];
    
    return mentions;
}

- (ANDraft*)draftReply {
    ANDraft * draft = [ANDraft new];
    
    draft.text = [[self.mentionsForDirectReply.array componentsJoinedByString:@" "] stringByAppendingString:@" "];
    draft.replyTo = self.originalID;
    
    return draft;
}

- (ANDraft*)draftReplyToAllExcept:(BOOL (^)(ANEntity * mention))rejectionBlock {
    ANDraft * draft = [self draftReply];
    
    NSMutableOrderedSet * usernames = self.mentionsForDirectReply;
    for(ANEntity * mention in self.entities.mentions) {
        if(!rejectionBlock(mention)) {
            [usernames addObject:mention.name.appNetUsernameString];
        }
    }
    
    draft.text = [[usernames.array componentsJoinedByString:@" "] stringByAppendingString:@" "];
    
    return draft;
}

- (ANDraft*)draftReplyToAllExceptUser:(ANUser*)user {
    return [self draftReplyToAllExcept:^BOOL(ANEntity *mention) {
        return mention.userID == user.ID;
    }];
}

- (ANDraft*)draftReplyToAllExceptUsername:(NSString*)username {
    return [self draftReplyToAllExcept:^BOOL(ANEntity *mention) {
        return [mention.name isEqualToString:username];
    }];
}

- (void)postRepliedToWithCompletion:(ANPostRequestCompletion)completion {
    [self.session postWithID:self.originalPost.replyTo completion:completion];
}

- (void)replyPostsWithCompletion:(ANPostListRequestCompletion)completion {
    [self.session postsReplyingToPostWithID:self.originalID betweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postAtThreadRootWithCompletion:(ANPostRequestCompletion)completion {
    [self.session postWithID:self.originalPost.threadID completion:completion];
}

- (void)deleteWithCompletion:(ANPostRequestCompletion)completion {
    [self.session deletePostWithID:self.ID completion:completion];
}

- (void)starWithCompletion:(ANPostRequestCompletion)completion {
    [self.session starPostWithID:self.originalID completion:completion];
}

- (void)unstarWithCompletion:(ANPostRequestCompletion)completion {
    [self.session unstarPostWithID:self.originalID completion:completion];
}

- (void)usersWithPostStarredWithCompletion:(ANUserListRequestCompletion)completion {
    [self.session usersWithPostWithIDStarred:self.originalID completion:completion];
}

+ (NSSet *)keyPathsForValuesAffectingOriginalID {
    return [NSSet setWithObject:@"originalPost.ID"];
}

- (ANResourceID)originalID {
    return self.originalPost.ID;
}

+ (NSSet *)keyPathsForValuesAffectingOriginalPost {
    return [NSSet setWithObject:@"repostOf"];
}

- (ANPost *)originalPost {
    if(self.repostOf) {
        return self.repostOf;
    }
    return self;
}

- (void)repostWithCompletion:(ANPostRequestCompletion)completion {
    [self.session repostPostWithID:self.originalID completion:completion];
}

- (void)unrepostWithCompletion:(ANPostRequestCompletion)completion {
    [self.session unrepostPostWithID:self.originalID completion:completion];
}

- (void)usersWithPostRepostedWithCompletion:(ANUserListRequestCompletion)completion {
    [self.session usersWithPostWithIDReposted:self.originalID completion:completion];
}

@end
