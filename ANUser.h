//
//  ANUser.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANResource.h"
#import "ANCompletions.h"
#import "AppNetKit.h"
#import "ANUserDescription.h"
#import "ANImage.h"
#import "ANUserCounts.h"

typedef enum {
    ANUserTypeHuman,
    ANUserTypeBot,
    ANUserTypeCorporate,
    ANUserTypeFeed
} ANUserType;

NSString * ANUserTypeToString(ANUserType type);
ANUserType ANUserTypeFromString(NSString * string);

@interface ANUser : ANResource

@property (readonly) ANResourceID ID;
@property (readonly) NSString * username;
@property (readonly) NSString * name;
@property (readonly) ANUserDescription * description;
@property (readonly) NSDictionary * descriptionRepresentation;

@property (readonly) NSString * timezoneString;
@property (readonly) NSTimeZone * timezone;

@property (readonly) NSString * localeString;
@property (readonly) NSLocale * locale;

@property (readonly) ANImage * avatarImage;
@property (readonly) NSDictionary * avatarImageRepresentation;
@property (readonly) ANImage * coverImage;
@property (readonly) NSDictionary * coverImageRepresentation;

@property (readonly) NSString * typeString;
@property (assign) ANUserType type;

@property (readonly) NSDate * createdAt;
@property (readonly) ANUserCounts * counts;
@property (readonly) NSDictionary * countsRepresentation;
//@property (copy) NSDictionary * appData;

@property (readonly) BOOL followsYou;
@property (readonly) BOOL youFollow;
@property (readonly) BOOL youMuted;

- (void)reloadWithCompletion:(ANUserRequestCompletion)completion;

- (void)followWithCompletion:(ANUserRequestCompletion)completion;
- (void)unfollowWithCompletion:(ANUserRequestCompletion)completion;
- (void)followingsWithCompletion:(ANUserListRequestCompletion)completion;
- (void)followersWithCompletion:(ANUserListRequestCompletion)completion;

- (void)muteWithCompletion:(ANUserRequestCompletion)completion;
- (void)unmuteWithCompletion:(ANUserRequestCompletion)completion;

- (void)postsWithCompletion:(ANPostListRequestCompletion)completion;
- (void)postsBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion;

- (void)postsMentioningUserWithCompletion:(ANPostListRequestCompletion)completion;
- (void)postsMentioningUserBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion;

@end
