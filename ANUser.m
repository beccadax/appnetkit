//
//  ANUser.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANUser.h"
#import "AppNetKit.h"

NSString * ANUserTypeToString(ANUserType type) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = @{
            @(ANUserTypeHuman): @"human",
            @(ANUserTypeBot): @"bot",
            @(ANUserTypeCorporate): @"corporate",
            @(ANUserTypeFeed): @"feed"
        };
    });
    
    return table[@(type)];
}

ANUserType ANUserTypeFromString(NSString * string) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = @{
            @"human": @(ANUserTypeHuman),
            @"bot": @(ANUserTypeBot),
            @"corporate": @(ANUserTypeCorporate),
            @"feed": @(ANUserTypeFeed)
        };
    });
    
    return [table[string] integerValue];

}

@implementation ANUser

ANResourceSynthesizeID(@"id", ID, setID)
ANResourceSynthesizeString(@"username", username, setUsername)
ANResourceSynthesizeString(@"name", name, setName)
ANResourceSynthesizeString(@"timezone", timezoneString, setTimezoneString)
ANResourceSynthesizeString(@"locale", localeString, setLocaleString)
ANResourceSynthesizeString(@"type", typeString, setTypeString)
ANResourceSynthesizeDate(@"created_at", createdAt, setCreatedAt)
ANResourceSynthesizeBool(@"follows_you", followsYou, setFollowsYou)
ANResourceSynthesizeBool(@"you_follow", youFollow, setYouFollow)
ANResourceSynthesizeBool(@"you_muted", youMuted, setYouMuted)

- (NSTimeZone *)timezone {
    return [NSTimeZone timeZoneWithName:self.timezoneString];
}

- (void)setTimezone:(NSTimeZone *)timezone {
    self.timezoneString = timezone.name;
}

- (NSLocale *)locale {
    return [[NSLocale alloc] initWithLocaleIdentifier:self.localeString];
}

- (void)setLocale:(NSLocale *)locale {
    self.localeString = locale.localeIdentifier;
}

- (ANUserType)type {
    return ANUserTypeFromString(self.typeString);
}

- (void)setType:(ANUserType)type {
    self.typeString = ANUserTypeToString(type);
}



//- (void)postsWithCompletion:(ANPostListRequestCompletion)completion {
//    [self postsBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
//}
//
//- (void)postsBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
//    [self.session postsForUserWithID:self.ID betweenID:sinceID andID:beforeID completion:completion];
//}
//
//- (void)postsMentioningUserWithCompletion:(ANPostListRequestCompletion)completion {
//    [self postsMentioningUserBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
//}
//
//- (void)postsMentioningUserBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
//    [self.session postsMentioningUserWithID:self.ID betweenID:sinceID andID:beforeID completion:completion];
//}
//
//- (void)postsInStreamWithCompletion:(ANPostListRequestCompletion)completion {
//    [self postsInStreamBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
//}
//
//- (void)postsInStreamBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
//    [self.session postsInStreamForUserWithID:self.ID betweenID:sinceID andID:beforeID completion:completion];
//}

@end
