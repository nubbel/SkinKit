//
//  MetalSkin.m
//  SkinKitDemo
//
//  Created by Dominique d'Argent on 24.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "MetalSkin.h"

@implementation MetalSkin


//- (UIColor *)accentTintColor {
//    return [UIColor purpleColor];
//}

- (UIColor *)backgroundColor {
    return [UIColor underPageBackgroundColor];
}

- (UIImage *)navigationBarBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics {
    return [[super navigationBarBackgroundImageForBarMetrics:barMetrics] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 8.0, 0.0, 8.0)];
}

- (UIImage *)tableViewBackgroundImage {
    return nil;
}

@end
