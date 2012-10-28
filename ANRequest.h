//
//  ANRequest.h
//  
//
//  Created by Brent Royal-Gordon on 8/19/12.
//
//

#import <Foundation/Foundation.h>
#import "AppNetKit.h"

@class ANSession;

typedef enum {
    ANRequestMethodGet,
    ANRequestMethodPost,
    ANRequestMethodDelete,
    ANRequestMethodPut
} ANRequestMethod;

typedef enum {
    ANRequestParameterEncodingJSON,
    ANRequestParameterEncodingURL
} ANRequestParameterEncoding;

@interface ANRequest : NSObject <NSMutableCopying>

- (id)initWithSession:(ANSession*)session;

@property (weak) ANSession * session;

@property (readonly) NSURL * URL;
@property (readonly) NSDictionary * parameters;
@property (readonly) ANRequestMethod method;
@property (readonly) ANRequestParameterEncoding parameterEncoding;

@property (readonly) NSMutableURLRequest * URLRequest;

- (NSString*)pathWithFormat:(NSString*)format userID:(ANResourceID)ID;
- (NSString*)pathWithFormat:(NSString*)format username:(NSString*)username;

- (void)sendRequestWithDataCompletion:(void (^)(NSData * body, NSError * error))completion;
- (void)sendRequestWithRepresentationCompletion:(void (^)(ANResponse * response, id rep, NSError * error))completion;

@end

// ANMutableRequest (and ANMutableAuthenticatedRequest) allow you to change the URL, parameters, and method.
// This is more a means of doing completely custom requests than customizing an existing request.
@interface ANMutableRequest : ANRequest

@property (readwrite,strong) NSURL * URL;
@property (readwrite,strong) NSDictionary * parameters;
@property (readwrite,assign) ANRequestMethod method;
@property (readwrite,assign) ANRequestParameterEncoding parameterEncoding;

@end
