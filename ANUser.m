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
        table = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"human", [NSNumber numberWithInteger:ANUserTypeHuman],
                 @"bot", [NSNumber numberWithInteger:ANUserTypeBot],
                 @"corporate", [NSNumber numberWithInteger:ANUserTypeCorporate],
                 @"feed", [NSNumber numberWithInteger:ANUserTypeFeed],
                 nil];
    });
    
    return [table objectForKey:[NSNumber numberWithInteger:type]];
}

ANUserType ANUserTypeFromString(NSString * string) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = [NSDictionary dictionaryWithObjectsAndKeys:
                 [NSNumber numberWithInteger:ANUserTypeHuman], @"human",
                 [NSNumber numberWithInteger:ANUserTypeBot], @"bot",
                 [NSNumber numberWithInteger:ANUserTypeCorporate], @"corporate",
                 [NSNumber numberWithInteger:ANUserTypeFeed], @"feed", 
                 nil];
    });
    
    return [[table objectForKey:string] integerValue];

}

@implementation ANUser

ANResourceSynthesizeID(@"id", ID, setID)
ANResourceSynthesize(@"username", username, setUsername)
ANResourceSynthesize(@"name", name, setName)
ANResourceSynthesize(@"description", descriptionRepresentation, setDescriptionRepresentation);
ANResourceSynthesize(@"timezone", timezoneString, setTimezoneString)
ANResourceSynthesize(@"locale", localeString, setLocaleString)
ANResourceSynthesize(@"type", typeString, setTypeString)
ANResourceSynthesize(@"avatar_image", avatarImageRepresentation, setAvatarImageRepresentation)
ANResourceSynthesize(@"cover_image", coverImageRepresentation, setCoverImageRepresentation)
ANResourceSynthesizeDate(@"created_at", createdAt, setCreatedAt)
ANResourceSynthesize(@"counts", countsRepresentation, setCountsRepresentation)
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

- (ANUserDescription *)description {
    return [[ANUserDescription alloc] initWithRepresentation:self.descriptionRepresentation session:self.session];
}

- (ANImage *)avatarImage {
    return [[ANImage alloc] initWithRepresentation:self.avatarImageRepresentation session:self.session];
}

- (ANImage *)coverImage {
    return [[ANImage alloc] initWithRepresentation:self.coverImageRepresentation session:self.session];
}

- (ANUserCounts *)counts {
    return [[ANUserCounts alloc] initWithRepresentation:self.countsRepresentation session:self.session];
}

- (NSUInteger)hash {
    return (NSUInteger)self.ID ^ (NSUInteger)self.class;
}

- (BOOL)isEqual:(ANUser*)object {
    if(self.class != object.class) {
        return NO;
    }
    
    return self.ID == object.ID;
}

- (void)followWithCompletion:(ANUserRequestCompletion)completion {
    [self.session followUserWithID:self.ID completion:completion];
}

- (void)unfollowWithCompletion:(ANUserRequestCompletion)completion {
    [self.session unfollowUserWithID:self.ID completion:completion];
}

- (void)followingsWithCompletion:(ANUserListRequestCompletion)completion {
    [self.session followingsForUserWithID:self.ID completion:completion];
}

- (void)followersWithCompletion:(ANUserListRequestCompletion)completion {
    [self.session followersForUserWithID:self.ID completion:completion];
}

- (void)muteWithCompletion:(ANUserRequestCompletion)completion {
    [self.session muteUserWithID:self.ID completion:completion];
}

- (void)unmuteWithCompletion:(ANUserRequestCompletion)completion {
    [self.session unmuteUserWithID:self.ID completion:completion];
}

- (void)postsWithCompletion:(ANPostListRequestCompletion)completion {
    [self postsBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
    [self.session postsForUserWithID:self.ID betweenID:sinceID andID:beforeID completion:completion];
}

- (void)postsMentioningUserWithCompletion:(ANPostListRequestCompletion)completion {
    [self postsMentioningUserBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsMentioningUserBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
    [self.session postsMentioningUserWithID:self.ID betweenID:sinceID andID:beforeID completion:completion];
}

@end
