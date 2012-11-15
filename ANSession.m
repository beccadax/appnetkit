//
//  ANSession.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANSession.h"
#import "ANSession+ANResource_Private.h"
#import "_ANIdentifiedResourceSet.h"

const ANResourceID ANMeUserID = 0;
const ANResourceID ANUnspecifiedPostID = 0;

NSInteger NetworkActivityCount;

@interface ANSession ()

@property (strong,nonatomic) _ANIdentifiedResourceSet * resourceSet;
@property (nonatomic) dispatch_queue_t resourceUniquingQueue;

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
        _resourceSet = [_ANIdentifiedResourceSet new];
        _resourceUniquingQueue = dispatch_queue_create("ANSession resource uniquing queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

+ (ANSession *)defaultDefaultSession {
    static ANSession * singleton;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        singleton = [[ANSession alloc] init];
    });
    
    return singleton;
}

static ANSession * DefaultSession = nil;

+ (ANSession*)defaultSession {
    return DefaultSession ?: [self defaultDefaultSession];
}

+ (void)setDefaultSession:(ANSession*)defaultSession {
    DefaultSession = defaultSession;
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
        
        // We touch these internal resources to make sure they're updated immediately (triggering an ANResourceDidUpdateNotification).
        [post repostOf];
        [post user];
        
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
            
            // We touch these internal resources to make sure they're updated immediately (triggering an ANResourceDidUpdateNotification).
            [post repostOf];
            [post user];
            
            [posts addObject:post];
        }
        
        completion(response, posts.copy, nil);
    }
    else {
        completion(response, nil, error);
    }
}

- (void)completeFilterRequest:(ANFilterRequestCompletion)completion withResponse:(ANResponse*)response representation:(NSDictionary*)rep error:(NSError*)error {
    if(rep) {
        ANFilter * filter = [[ANFilter alloc] initWithRepresentation:rep session:self];
        completion(response, filter, nil);
    }
    else {
        completion(response, nil, error);
    }
}

- (void)completeFilterListRequest:(ANFilterListRequestCompletion)completion withResponse:(ANResponse*)response representation:(NSArray*)rep error:(NSError*)error {
    if(rep) {
        NSMutableArray * filters = [[NSMutableArray alloc] initWithCapacity:rep.count];
        for(NSDictionary * filterRep in rep) {
            ANFilter * filter = [[ANFilter alloc] initWithRepresentation:filterRep session:self];
            [filters addObject:filter];
        }
        
        completion(response, filters.copy, nil);
    }
    else {
        completion(response, nil, error);
    }
}

- (void)completeStreamMarkerRequest:(ANStreamMarkerRequestCompletion)completion withResponse:(ANResponse *)response representation:(NSDictionary *)rep error:(NSError *)error {
    if(rep) {
        ANStreamMarker * marker = [[ANStreamMarker alloc] initWithRepresentation:rep session:self];
        completion(response, marker, nil);
    }
    else {
        completion(response, nil, error);
    }
}

- (id)uniqueResource:(ANIdentifiedResource *)r {
    __block ANIdentifiedResource * resource = r;
    
    // We do this in a queue so that only one thread can be adjusting the resource set at a time.
    dispatch_sync(self.resourceUniquingQueue, ^{
        ANIdentifiedResource * existingResource = [self.resourceSet existingResource:resource];
        
        if(existingResource) {
            [self.resourceSet removeResource:existingResource];
            existingResource.representation = resource.representation;
            resource = existingResource;
        }
        
        [self.resourceSet addResource:resource];
    });
    
    return resource;
}

@end
