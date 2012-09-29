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
@dynamic numberOfStars;
@dynamic youStarred;
@dynamic starredByRepresentation;
@dynamic numberOfReposts;
@dynamic youReposted;
@dynamic reposters;
@dynamic repostersRepresentation;
@dynamic repostOf;
@dynamic repostOfRepresentation;

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
    
    return draft;
}

- (ANDraft*)draftCopy {
    ANDraft * draft = [ANDraft new];
    
    draft.text = self.text;
    draft.replyTo = self.replyTo;
    [draft.annotations setArray:[self.annotations.all valueForKey:@"draftAnnotation"]];
    
    return draft;
}

- (ANDraft*)draftReply {
    ANDraft * draft = [self.user draftMention];
    
    draft.replyTo = self.originalID;
    
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
    draft.replyTo = self.originalID;
    
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
    draft.replyTo = self.originalID;
    
    return draft;
}

- (void)postRepliedToWithCompletion:(ANPostRequestCompletion)completion {
    [self.session postWithID:self.originalID completion:completion];
}

- (void)replyPostsWithCompletion:(ANPostListRequestCompletion)completion {
    [self.session postsReplyingToPostWithID:self.originalID betweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postAtThreadRootWithCompletion:(ANPostRequestCompletion)completion {
    [self.session postWithID:self.originalID completion:completion];
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
    return [NSSet setWithObjects:@"ID", @"repostOf.ID", nil];
}

- (ANResourceID)originalID {
    if(self.repostOf) {
        return self.repostOf.ID;
    }
    return self.ID;
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
