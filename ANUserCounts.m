//
//  ANUserCounts.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANUserCounts.h"

@implementation ANUserCounts

ANResourceSynthesizeNSUInteger(@"follows", follows, setFollows)
ANResourceSynthesizeNSUInteger(@"followed_by", followedBy, setFollowedBy)
ANResourceSynthesizeNSUInteger(@"posts", posts, setPosts)

@end
