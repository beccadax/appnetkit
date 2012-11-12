//
//  ANImage.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANImage.h"
#import "ANRequest.h"

@interface ANImage ()

@property (strong) NSMutableDictionary * imageAtSize;

@end

static CGFloat ImageScale = 0.0;

@implementation ANImage

+ (CGFloat)imageScale {
    if(ImageScale != 0.0) {
        return ImageScale;
    }
    
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    return UIScreen.mainScreen.scale;
#else
#pragma warning ANImage defaults to using 2.0 scale on the Mac--is there a better option?
    return 2.0;
#endif
}

+ (void)setImageScale:(CGFloat)scale {
    ImageScale = scale;
}

- (id)initWithRepresentation:(NSDictionary *)rep session:(ANSession *)session {
    if((self = [super initWithRepresentation:rep session:session])) {
        _imageAtSize = [NSMutableDictionary new];
    }
    return self;
}

@dynamic URL;

- (CGSize)nativeSize {
    CGSize size;
    size.width = [[self.representation objectForKey:@"width"] doubleValue] / self.class.imageScale;
    size.height = [[self.representation objectForKey:@"height"] doubleValue] / self.class.imageScale;
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
    CGFloat scale = self.class.imageScale;
    
    size.width *= scale;
    size.height *= scale;
    
    id image = [self.imageAtSize objectForKey:[NSValue valueWithCGSize:size]];
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
        
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
        UIImage * image = [[UIImage alloc] initWithData:body scale:scale];
#else
        NSImage * image = [[NSImage alloc] initWithData:body];
        
        NSSize size = image.size;
        size.width /= scale;
        size.height /= scale;
        image.size = size;
#endif
        
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
