//
//  UIColor+SKSkinning.h
//  SkinKit
//
//  Created by Dominique d'Argent on 24.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SKSkinning)

+ (UIColor *)colorWithDictionary:(NSDictionary *)dictionary;
+ (UIColor *)colorWithRGBString:(NSString *)rgb;
+ (UIColor *)colorWithHSBString:(NSString *)hsb;
+ (UIColor *)colorWithHexString:(NSString *)hex;
+ (UIColor *)colorWithName:(NSString *)name;

- (UIColor *)lighterColor;
- (UIColor *)darkerColor;

@end
