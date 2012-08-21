//
//  ANRequest.m
//  
//
//  Created by Brent Royal-Gordon on 8/19/12.
//
//

#import "ANRequest.h"
#import "AppNetKit.h"
#import "NSDictionary+Parameters.h"

@interface ANRequest ()

@property (readonly) NSURL * fullURL;
@property (readonly) NSData * body;

@end

@implementation ANRequest

- (id)initWithSession:(ANSession *)session {
    if((self = [super init])) {
        _session = session;
    }
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    ANMutableRequest * req = [[ANMutableRequest alloc] initWithSession:self.session];
    
    req.URL = self.URL;
    req.parameters = self.parameters;
    req.method = self.method;
    
    return req;
}

@dynamic URL, parameters, method;

- (NSString*)methodString {
    switch (self.method) {
        case ANRequestMethodGet:
            return @"GET";
            
        case ANRequestMethodPost:
            return @"POST";
            
        case ANRequestMethodDelete:
            return @"DELETE";
            
        default:
            NSAssert(NO, @"Unknown method %d", self.method);
            return nil;
    }
}

- (NSURL *)fullURL {
    if(self.method != ANRequestMethodGet) {
        return self.URL;
    }
    
    NSDictionary * params = self.parameters;
    if(params.count == 0) {
        return self.URL;
    }
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", self.URL.absoluteString, params.queryString]];
}

- (NSData *)body {
    if(self.method == ANRequestMethodGet) {
        return nil;
    }
    
    NSDictionary * params = self.parameters;
    if(params.count == 0) {
        return nil;
    }
    
    return params.formBodyData;
}

- (NSError*)errorForHTTPRequest:(NSURLRequest*)req response:(NSHTTPURLResponse*)res {
    if(res.statusCode < ANBadRequestError) {
        return nil;
    }
    
    return [NSError errorWithDomain:ANErrorDomain code:res.statusCode userInfo:nil];
}

- (NSMutableURLRequest *)URLRequest {
    NSMutableURLRequest * req = [[NSMutableURLRequest alloc] initWithURL:self.fullURL];
    req.HTTPMethod = self.methodString;
    req.HTTPBody = self.body;
    
    if(req.HTTPBody) {
        [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    
    return req;
}

- (NSString*)pathWithFormat:(NSString*)format userID:(ANResourceID)ID {
    NSString * IDString = @"me";
    if(ID != ANMeUserID) {
        IDString = [NSString stringWithFormat:@"%lld", ID];
    }
    return [NSString stringWithFormat:format, IDString];
}

- (void)sendRequestWithDataCompletion:(void (^)(NSData * body, NSError * error))completion {
    NSURLRequest * req = self.URLRequest;
    
    [ANSession beginNetworkActivity];
    
    [NSURLConnection sendAsynchronousRequest:req queue:NSOperationQueue.mainQueue completionHandler:^(NSURLResponse * response, NSData * body, NSError * error) {
        [ANSession endNetworkActivity];
        
        NSHTTPURLResponse * HTTPResponse = (id)response;
        
        if(!error) {
            error = [self errorForHTTPRequest:req response:HTTPResponse];
            if(error) {
                NSLog(@"Error page contents:\n%@", [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding]);
            }
        }
        
        if(error) {
            completion(nil, error);
            return;
        }
        
        completion(body, nil);
    }];
}

- (void)sendRequestWithRepresentationCompletion:(void (^)(id, NSError *))completion {
    [self sendRequestWithDataCompletion:^(NSData *body, NSError *error) {
        if(!body) {
            completion(nil, error);
            return;
        }
        
        NSError * jsonError;
        id json = [NSJSONSerialization JSONObjectWithData:body options:0 error:&jsonError];
        completion(json, jsonError);
    }];
}

@end

@implementation ANMutableRequest @end
