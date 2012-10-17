//
//  ANImage.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANResource.h"

// ANFrameworkImage is the same as NSImage on the Mac or UIImage on the iPhone.
// (It just so happens that ANImage only needs to call -initWithData: which is present in both.)
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
@compatibility_alias ANFrameworkImage UIImage;
#else
@compatibility_alias ANFrameworkImage NSImage;
#endif

typedef void (^ANImageCompletion)(ANFrameworkImage * image, NSError * error);

@interface ANImage : ANResource

@property (readonly) NSURL * URL;
@property (readonly) CGSize nativeSize;

- (void)imageWithCompletion:(ANImageCompletion)completion;
- (void)imageAtWidth:(CGFloat)width completion:(ANImageCompletion)completion;
- (void)imageAtHeight:(CGFloat)height completion:(ANImageCompletion)completion;
- (void)imageAtSize:(CGSize)size completion:(ANImageCompletion)completion;

@end
