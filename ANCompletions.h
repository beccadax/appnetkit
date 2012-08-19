//
//  ANCompletions.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANUser;
@class ANPost;

typedef void (^ANAccessTokenInformationRequestCompletion)(NSArray * scopes, ANUser * user, NSError * error);
typedef void (^ANUserRequestCompletion)(ANUser * user, NSError * error);
typedef void (^ANUserListRequestCompletion)(NSArray * users, NSError * error);
typedef void (^ANPostRequestCompletion)(ANPost * post, NSError * error);
typedef void (^ANPostListRequestCompletion)(NSArray * posts, NSError * error);
