//
//  UIImage+SKSkinning.m
//  SkinKit
//
//  Created by Dominique d'Argent on 24.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "UIImage+SKSkinning.h"

@implementation UIImage (SKSkinning)

//+ (UIImage *)snapshotImageOfView:(UIView *)view {
//    UIGraphicsBeginImageContext(view.bounds.size);
//    
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    
//    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return snapshot;
//}

+ (CGAffineTransform)transformForOrientation:(UIInterfaceOrientation)orientation {
    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
            return CGAffineTransformMakeRotation(-M_PI_2);
            
        case UIInterfaceOrientationLandscapeRight:
            return CGAffineTransformMakeRotation(M_PI_2);
            
        case UIInterfaceOrientationPortraitUpsideDown:
            return CGAffineTransformMakeRotation(M_PI);
            
        case UIInterfaceOrientationPortrait:
        default:
            return CGAffineTransformMakeRotation(0.0);
    }
}

+ (UIImage *)screenshot {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if (![window.screen isEqual:[UIScreen mainScreen]]) {
        return nil;
    }
    
    // FIXME: support all interface orientations
    CGSize size = window.bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [window.layer renderInContext:context];
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return screenshot;
}

- (UIColor *)averageColor {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4,
                                                 colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);  
    
    if(rgba[3] > 0.0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}

- (UIImage *)tintedImageUsingColor:(UIColor *)tintColor {
    UIGraphicsBeginImageContext(self.size);
    
    CGRect drawRect = CGRectMake(0, 0, self.size.width, self.size.height);
    [self drawInRect:drawRect];
    
    [tintColor set];
    UIRectFillUsingBlendMode(drawRect, kCGBlendModeSourceAtop);
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
