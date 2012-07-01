//
//  DefaultTheme.m
//  SkinKitDemo
//
//  Created by Dominique d'Argent on 23.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "TintedSkin.h"

@implementation TintedSkin

- (UIColor *)accentTintColor {
    return [UIColor greenColor];
}

- (UIColor *)baseTintColor {
//    return [UIColor darkGrayColor];
//    return [UIColor lightGrayColor];
//    return [UIColor grayColor];
//    return [UIColor whiteColor];
//    return [UIColor clearColor];
//    return [UIColor blackColor];
//    return [UIColor redColor];
//    return [UIColor magentaColor];
    return [UIColor colorWithRed: 0.775f
                           green: 0.739f
                            blue: 0.623f
                           alpha: 1.000f];
}

@end
