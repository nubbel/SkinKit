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

+ (UIImage *)screenshot {
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.screen == [UIScreen mainScreen]) {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, window.center.x, window.center.y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, window.transform);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -window.bounds.size.width  * window.layer.anchorPoint.x,
                                  -window.bounds.size.height * window.layer.anchorPoint.y);
            
            // Render the layer hierarchy to the current context
            [window.layer renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
        }
    }
    
    // Retrieve the screenshot image
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
