//
//  ANUser.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANRepresentation.h"
#import "ANCompletions.h"
#import "AppNetKit.h"

typedef enum {
    ANUserTypeHuman,
    ANUserTypeBot,
    ANUserTypeCorporate,
    ANUserTypeFeed
} ANUserType;

NSString * ANUserTypeToString(ANUserType type);
ANUserType ANUserTypeFromString(NSString * string);

@interface ANUser : ANRepresentation

@property (readonly) uint64_t ID;
@property (copy) NSString * username;
@property (copy) NSString * name;
//@property (copy) ANUserDescription * description;

@property (copy) NSString * timezoneString;
@property (copy) NSTimeZone * timezone;

@property (copy) NSString * localeString;
@property (copy) NSLocale * locale;

//@property (copy) ANImage * avatarImage;
//@property (copy) ANImage * coverImage;

@property (copy) NSString * typeString;
@property (assign) ANUserType type;

@property (copy) NSDate * createdAt;
//@property (copy) ANUserCounts * counts;
//@property (copy) NSMutableDictionary * appData;

@property (readonly) BOOL followsYou;
@property (readonly) BOOL youFollow;
@property (readonly) BOOL youMuted;

//- (void)followWithCompletion:(ANUserRequestCompletion)completion;
//- (void)unfollowWithCompletion:(ANUserRequestCompletion)completion;
//- (void)followingsWithCompletion:(ANUserListRequestCompletion)completion;
//- (void)followersWithCompletion:(ANUserListRequestCompletion)completion;
//
//- (void)muteWithCompletion:(ANUserRequestCompletion)completion;
//- (void)unmuteWithCompletion:(ANUserRequestCompletion)completion;
//- (void)mutingsWithCompletion:(ANUserListRequestCompletion)completion;

//- (void)postsWithCompletion:(ANPostListRequestCompletion)completion;
//- (void)postsBetweenID:(ANRepresentationID)sinceID andID:(ANRepresentationID)beforeID completion:(ANPostListRequestCompletion)completion;
//
//- (void)postsMentioningUserWithCompletion:(ANPostListRequestCompletion)completion;
//- (void)postsMentioningUserBetweenID:(ANRepresentationID)sinceID andID:(ANRepresentationID)beforeID completion:(ANPostListRequestCompletion)completion;
//
//- (void)postsInStreamWithCompletion:(ANPostListRequestCompletion)completion;
//- (void)postsInStreamBetweenID:(ANRepresentationID)sinceID andID:(ANRepresentationID)beforeID completion:(ANPostListRequestCompletion)completion;

@end
