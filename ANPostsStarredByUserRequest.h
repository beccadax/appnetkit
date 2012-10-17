//
//  ANPostsStarredByUserRequest.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/7/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANRequestReturningPostList.h"

@interface ANPostsStarredByUserRequest : ANRequestReturningPostList

@property (assign) ANResourceID userID;

@end
