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
ANResourceSynthesizeDate(@"createdAt", createdAt, setCreatedAt)
ANResourceSynthesize(@"text", text, setText);
ANResourceSynthesize(@"html", HTML, setHTML)
ANResourceSynthesizeID(@"reply_to", replyToID, setReplyToID)
ANResourceSynthesizeID(@"thread_id", threadID, setThreadID)
ANResourceSynthesizeNSUInteger(@"num_replies", numberOfReplies, setNumberOfReplies)
ANResourceSynthesizeBool(@"is_deleted", isDeleted, setDeleted)

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

@end
