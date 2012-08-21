//
//  ANImage.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 8/21/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANResource.h"

//typedef void (^ANImageCompletion)(UIImage * image, NSError * error);

@interface ANImage : ANResource

@property (readonly) NSURL * URL;
@property (readonly) CGSize nativeSize;

//- (void)imageWithCompletion:(ANImageCompletion)completion;
//- (void)imageAtWidth:(CGFloat)width completion:(ANImageCompletion)completion;
//- (void)imageAtHeight:(CGFloat)height completion:(ANImageCompletion)completion;
//- (void)imageAtSize:(CGSize)size completion:(ANImageCompletion)completion;

@end
