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

ANRepresentationSynthesizeID(@"id", ID, setID)
ANRepresentationSynthesizeString(@"username", username, setUsername)
ANRepresentationSynthesizeString(@"name", name, setName)
ANRepresentationSynthesizeString(@"timezone", timezoneString, setTimezoneString)
ANRepresentationSynthesizeString(@"locale", localeString, setLocaleString)
ANRepresentationSynthesizeString(@"type", typeString, setTypeString)
ANRepresentationSynthesizeDate(@"created_at", createdAt, setCreatedAt)
ANRepresentationSynthesizeBool(@"follows_you", followsYou, setFollowsYou)
ANRepresentationSynthesizeBool(@"you_follow", youFollow, setYouFollow)
ANRepresentationSynthesizeBool(@"you_muted", youMuted, setYouMuted)

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
//- (void)postsBetweenID:(ANRepresentationID)sinceID andID:(ANRepresentationID)beforeID completion:(ANPostListRequestCompletion)completion {
//    [self.session postsForUserWithID:self.ID betweenID:sinceID andID:beforeID completion:completion];
//}
//
//- (void)postsMentioningUserWithCompletion:(ANPostListRequestCompletion)completion {
//    [self postsMentioningUserBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
//}
//
//- (void)postsMentioningUserBetweenID:(ANRepresentationID)sinceID andID:(ANRepresentationID)beforeID completion:(ANPostListRequestCompletion)completion {
//    [self.session postsMentioningUserWithID:self.ID betweenID:sinceID andID:beforeID completion:completion];
//}
//
//- (void)postsInStreamWithCompletion:(ANPostListRequestCompletion)completion {
//    [self postsInStreamBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
//}
//
//- (void)postsInStreamBetweenID:(ANRepresentationID)sinceID andID:(ANRepresentationID)beforeID completion:(ANPostListRequestCompletion)completion {
//    [self.session postsInStreamForUserWithID:self.ID betweenID:sinceID andID:beforeID completion:completion];
//}

@end
