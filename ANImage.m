//
//  ANImage.m
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANImage.h"
#import "ANRequest.h"

@interface ANImage ()

@property (strong) NSMutableDictionary * imageAtSize;

@end

@implementation ANImage

- (id)initWithRepresentation:(NSDictionary *)rep session:(ANSession *)session {
    if((self = [super initWithRepresentation:rep session:session])) {
        _imageAtSize = [NSMutableDictionary new];
    }
    return self;
}

- (NSURL *)URL {
    return [NSURL URLWithString:[self.representation objectForKey:@"url"]];
}

- (CGSize)nativeSize {
    CGSize size;
    size.width = [[self.representation objectForKey:@"width"] doubleValue];
    size.height = [[self.representation objectForKey:@"height"] doubleValue];
    return size;
}

- (void)imageWithCompletion:(ANImageCompletion)completion {
    return [self imageAtSize:CGSizeZero completion:completion];
}

- (void)imageAtWidth:(CGFloat)width completion:(ANImageCompletion)completion {
    return [self imageAtSize:CGSizeMake(width, 0) completion:completion];
}

- (void)imageAtHeight:(CGFloat)height completion:(ANImageCompletion)completion {
    return [self imageAtSize:CGSizeMake(0, height) completion:completion];
}

- (void)imageAtSize:(CGSize)size completion:(ANImageCompletion)completion {
    ANFrameworkImage * image = [self.imageAtSize objectForKey:[NSValue valueWithCGSize:size]];
    if(image) {
        completion(image, nil);
        return;
    }
    
    NSMutableDictionary * params = [NSMutableDictionary new];
    
    if(size.width) {
        [params setObject:[NSNumber numberWithDouble:size.width] forKey:@"w"];
    }
    if(size.height) {
        [params setObject:[NSNumber numberWithDouble:size.height] forKey:@"h"];
    }
    
    ANMutableRequest * req = [[ANMutableRequest alloc] initWithSession:self.session];
    
    req.URL = self.URL;
    req.parameters = params;
    req.method = ANRequestMethodGet;
    
    [req sendRequestWithDataCompletion:^(NSData *body, NSError *error) {
        if(!body) {
            completion(nil, error);
            return;
        }
        
        ANFrameworkImage * image = [[ANFrameworkImage alloc] initWithData:body];
        if(image) {
            error = nil;
        }
        else {
            error = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileReadCorruptFileError userInfo:[NSDictionary dictionaryWithObject:req.URLRequest.URL forKey:NSURLErrorFailingURLErrorKey]];
        }
        
        completion(image, error);
    }];
}

@end
