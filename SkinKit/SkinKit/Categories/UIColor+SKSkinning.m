//
//  UIColor+SKSkinning.m
//  SkinKit
//
//  Created by Dominique d'Argent on 24.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "UIColor+SKSkinning.h"

@implementation UIColor (SKSkinning)

- (UIColor *)lighterColor {
    CGFloat hue, saturation, brightness, alpha, white;
    
    UIColor *lighterColor = self;
    
    if ([self getHue:&hue
          saturation:&saturation
          brightness:&brightness
               alpha:&alpha]) {
        lighterColor = [UIColor colorWithHue:hue
                                  saturation:saturation * 0.5
                                  brightness:brightness
                                       alpha:alpha];
    }
    else if ([self getWhite:&white alpha:&alpha]) {
        lighterColor = [UIColor colorWithWhite:white * 1.5
                                         alpha:alpha];
    }
    else if ([self isEqual:[UIColor scrollViewTexturedBackgroundColor]]) {
        lighterColor = [UIColor underPageBackgroundColor];
    }
    
    return lighterColor;
}

- (UIColor *)darkerColor {
    CGFloat hue, saturation, brightness, alpha, white;
    
    UIColor *darkerColor = self;
    
    if ([self getHue:&hue
          saturation:&saturation
          brightness:&brightness
               alpha:&alpha]) {
        darkerColor = [UIColor colorWithHue:hue
                                  saturation:saturation
                                  brightness:brightness * 0.5
                                       alpha:alpha];
    }
    else if ([self getWhite:&white alpha:&alpha]) {
        darkerColor = [UIColor colorWithWhite:white * 0.5
                                        alpha:alpha];
    }
    else if ([self isEqual:[UIColor underPageBackgroundColor]]) {
        darkerColor = [UIColor scrollViewTexturedBackgroundColor];
    }
    
    return darkerColor;
}

@end
