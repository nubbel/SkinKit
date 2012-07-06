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

@property (nonatomic, assign, getter = wasApplied) BOOL applied;


@required

#pragma mark - Base colors
- (UIColor *)backgroundColor;

#pragma mark - Tint colors
- (UIColor *)baseTintColor;
- (UIColor *)accentTintColor;

#pragma mark - Shadows
- (UIImage *)shadowTopImage;
- (UIImage *)shadowBottomImage;

#pragma mark - Text attributes
- (NSDictionary *)navigationBarTitleTextAttributes;
- (NSDictionary *)barButtonItemTitleTextAttributesForState:(UIControlState)state;
- (NSDictionary *)tableViewHeaderFooterLabelTextAttributes;

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
- (NSValue *)scrollViewContentInsets; // NSValue wrapping a UIEdgeInsets struct

#pragma mark - Controls
- (UIColor *)controlBaseTintColor;
- (UIColor *)controlAccentTintColor;
- (UIColor *)controlThumbTintColor;

@optional

#pragma mark -
#pragma mark - Behaviour
- (BOOL)shouldAutomaticallyApplySkinForViews;
- (BOOL)shouldAutomaticallyApplySkinForTableViews;

@end
