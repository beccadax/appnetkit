//
//  ANUserPostListRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANRequestReturningPostList.h"
#import "AppNetKit.h"

@interface ANPostsByUserRequest : ANRequestReturningPostList

@property (assign) ANResourceID userID;

@end
