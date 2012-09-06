//
//  ANSession.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANSession.h"
#import "ANSession+ANResource_Private.h"

const ANResourceID ANMeUserID = 0;
const ANResourceID ANUnspecifiedPostID = 0;

NSInteger NetworkActivityCount;

@interface ANSession ()

@property (strong,nonatomic) NSHashTable * resources;
@property (strong,nonatomic) dispatch_queue_t resourceUniquingQueue;

@end

@implementation ANSession

+ (void)beginNetworkActivity {
    NetworkActivityCount++;
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    UIApplication.sharedApplication.networkActivityIndicatorVisible = self.isUsingNetwork;
#endif
}

+ (void)endNetworkActivity {
    NetworkActivityCount--;
    NSAssert(NetworkActivityCount >= 0, @"Network activity count underflow");
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    UIApplication.sharedApplication.networkActivityIndicatorVisible = self.isUsingNetwork;
#endif
}

+ (BOOL)isUsingNetwork {
    return NetworkActivityCount > 0;
}

- (id)init {
    if((self = [super init])) {
        _resources = [NSHashTable weakObjectsHashTable];
        _resourceUniquingQueue = dispatch_queue_create("ANSession resource uniquing queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

+ (ANSession *)defaultSession {
    static ANSession * singleton;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        singleton = [[ANSession alloc] init];
    });
    
    return singleton;
}

- (NSURL *)URLForStreamAPIVersion:(ANStreamAPIVersion)version {
    switch(version) {
        case ANStreamAPIVersion0:
            return [NSURL URLWithString:@"https://alpha-api.app.net/stream/0/"];
            
        default:
            NSAssert(NO, @"Unknown API version %d", version);
            return nil;
    }
}

- (NSString *)APIEndpointHost {
    return [self URLForStreamAPIVersion:ANStreamAPIVersion0].host;
}

- (void)completeUserRequest:(ANUserRequestCompletion)completion withResponse:(ANResponse*)response representation:(NSDictionary*)rep error:(NSError*)error {
    if(rep) {
        ANUser * user = [[ANUser alloc] initWithRepresentation:rep session:self];
        completion(response, user, nil);
    }
    else {
        completion(response, nil, error);
    }
}

- (void)completeUserListRequest:(ANUserListRequestCompletion)completion withResponse:(ANResponse*)response representation:(NSArray*)rep error:(NSError*)error {
    if(rep) {
        NSMutableArray * users = [[NSMutableArray alloc] initWithCapacity:rep.count];
        for(NSDictionary * userRep in rep) {
            ANUser * user = [[ANUser alloc] initWithRepresentation:userRep session:self];
            [users addObject:user];
        }
        
        completion(response, users.copy, nil);
    }
    else {
        completion(response, nil, error);
    }
}

- (void)completePostRequest:(ANPostRequestCompletion)completion withResponse:(ANResponse*)response representation:(NSDictionary*)rep error:(NSError*)error {
    if(rep) {
        ANPost * post = [[ANPost alloc] initWithRepresentation:rep session:self];
        completion(response, post, nil);
    }
    else {
        completion(response, nil, error);
    }
}

- (void)completePostListRequest:(ANPostListRequestCompletion)completion withResponse:(ANResponse*)response representation:(NSArray*)rep error:(NSError*)error {
    if(rep) {
        NSMutableArray * posts = [[NSMutableArray alloc] initWithCapacity:rep.count];
        for(NSDictionary * postRep in rep) {
            ANPost * post = [[ANPost alloc] initWithRepresentation:postRep session:self];
            [posts addObject:post];
        }
        
        completion(response, posts.copy, nil);
    }
    else {
        completion(response, nil, error);
    }
}

- (id)uniqueResource:(ANResource *)r {
    __block ANResource * resource = r;
    
    // We do this in a queue so that only one thread can be adjusting the resource set at a time.
    dispatch_sync(self.resourceUniquingQueue, ^{
        ANResource * existingResource = [self.resources member:resource];
        
        if(existingResource) {
            [self.resources removeObject:existingResource];
            existingResource.representation = resource.representation;
            resource = existingResource;
        }
        
        [self.resources addObject:resource];
    });
    
    return resource;
}

@end
