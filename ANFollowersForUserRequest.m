//
//  ANFollowersForUserRequest.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANFollowersForUserRequest.h"

@implementation ANFollowersForUserRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[self pathWithFormat:@"users/%@/followers" userID:self.userID] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (ANRequestMethod)method {
    return ANRequestMethodGet;
}

- (void)sendRequestWithCompletion:(ANUserListRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(id rep, NSError *error) {
        if(rep) {
            NSMutableArray * users = [NSMutableArray new];
            for(NSDictionary * userRep in rep) {
                [users addObject:[[ANUser alloc] initWithRepresentation:userRep session:self.session]];
            }
            completion(users, nil);
        }
        else {
            completion(nil, error);
        }
    }];
}

@end
