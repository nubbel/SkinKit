//
//  SKSkinning.h
//  SkinKit
//
//  Created by Dominique d'Argent on 23.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SKSkinDataSource <NSObject>

//@optional
@property (nonatomic, assign, getter = wasApplied) BOOL applied;


#pragma mark - Base colors
- (UIColor *)backgroundColor;

#pragma mark - Tint colors
- (UIColor *)baseTintColor;
- (UIColor *)accentTintColor;

#pragma mark - Shadows
- (UIImage *)shadowTopImage;
- (UIImage *)shadowBottomImage;

#pragma mark - Text attributes
- (UIColor *)titleTextColor;
- (UIColor *)titleTextShadowColor;
- (CGSize)titleTextShadowOffset;

#pragma mark -
#pragma mark - UI elements

#pragma mark - Tab bar
- (UIColor *)tabBarTintColor;
- (UIImage *)tabBarBackgroundImage;
- (UIImage *)tabBarSelectionIndicatorImage;
- (UIColor *)tabBarSelectedImageTintColor;

#pragma mark - Navigation bar
- (UIColor *)navigationBarTintColor;
- (UIImage *)navigationBarBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics;

#pragma mark - Toolbar
- (UIColor *)toolbarTintColor;
- (UIImage *)toolbarBackgroundImageForToolbarPosition:(UIToolbarPosition)toolbarPosition
                                           barMetrics:(UIBarMetrics)barMetrics;

#pragma mark - Search bar
- (UIColor *)searchBarTintColor;
- (UIImage *)searchBarBackgroundImage;

#pragma mark - Bar button item
- (UIColor *)barButtonItemTintColor;
- (UIImage *)barButtonItemBackgroundImageForState:(UIControlState)state
                                                      style:(UIBarButtonItemStyle)style
                                                 barMetrics:(UIBarMetrics)barMetrics;
- (UIImage *)backBarButtonItemBackgroundImageForState:(UIControlState)state
                                                     barMetrics:(UIBarMetrics)barMetrics;

#pragma mark - Table view
- (UIImage *)tableViewBackgroundImage;

#pragma mark - Scroll view
- (UIEdgeInsets)scrollViewContentInsets;

@optional

#pragma mark - Behaviour
- (BOOL)shouldAutomaticallyApplySkinForViews;
- (BOOL)shouldAutomaticallyApplySkinForTableViews;

@end
