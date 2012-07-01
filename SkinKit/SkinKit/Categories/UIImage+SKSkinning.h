//
//  UIImage+SKSkinning.h
//  SkinKit
//
//  Created by Dominique d'Argent on 24.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SKSkinning)

+ (UIImage *)screenshot;

- (UIColor *)averageColor;
- (UIImage *)tintedImageUsingColor:(UIColor *)tintColor;
@end
