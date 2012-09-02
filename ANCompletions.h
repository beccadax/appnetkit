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
@class ANResponse;

typedef void (^ANAccessTokenInformationRequestCompletion)(ANResponse * response, NSArray * scopes, ANUser * user, NSError * error);
typedef void (^ANUserRequestCompletion)(ANResponse * response, ANUser * user, NSError * error);
typedef void (^ANUserListRequestCompletion)(ANResponse * response, NSArray * users, NSError * error);
typedef void (^ANPostRequestCompletion)(ANResponse * response, ANPost * post, NSError * error);
typedef void (^ANPostListRequestCompletion)(ANResponse * response, NSArray * posts, NSError * error);
