//
//  SKDefaultSkin.m
//  SkinKit
//
//  Created by Dominique d'Argent on 24.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "SKDefaultSkin.h"
#import "UIImage+SKSkinning.h"
#import "UIColor+SKSkinning.h"

@interface SKDefaultSkin ()

@property (nonatomic, strong) NSMutableDictionary *cache;

@end

@implementation SKDefaultSkin

- (id)init {
    self = [super init];
    
    if (self) {
        self.cache = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    
    return self;
}

#pragma mark - Default image names
- (NSString *)tabBarBackgroundImageName {
    return @"tabBarBackground";
}

- (NSString *)tabBarSelectionIndicatorImageName {
    return @"tabBarSelectionIndicator";
}

- (NSString *)navigationBarBackgroundImageName {
    return @"navigationBarBackground";
}

- (NSString *)toolbarBackgroundImageName {
    return @"toolbarBackground";
}

- (NSString *)searchBarBackgroundImageName {
    return @"searchBarBackground";
}

- (NSString *)barButtonItemBackgroundImageName {
    return @"barButtonItemBackground";
}

- (NSString *)backBarButtonItemBackgroundImageName {
    // default: "backBarButtonItemBackground"
    return @"backBarButtonItemBackground";
//    return [@"back" stringByAppendingString:[[self barButtonItemBackgroundImageName] capitalizedString]];
}

- (NSString *)tableViewBackgroundImageName {
    return @"tableViewBackground";
}

- (NSString *)shadowTopImageName {
    return @"shadowTop";
}

- (NSString *)shadowBottomImageName {
    return @"shadowBottom";
}

- (NSString *)backgroundPatternImageName {
    return @"backgroundPattern";
}


#pragma mark - Default colors
// calculates from navigation bar background image
- (UIColor *)baseTintColor {
    static NSString *cacheKey = @"baseTintColor";
    
    id cached = self.cache[cacheKey];
    if (!cached) {
        UIImage *navigationBarImage = [self navigationBarBackgroundImageForBarMetrics:UIBarMetricsDefault];
        
        if (navigationBarImage) {
            // calculate average color
            cached = [navigationBarImage averageColor];
        }
    }
    
    if (cached) {
        self.cache[cacheKey] = cached;
        
        return cached;
    }
    
    return [super baseTintColor];
}

// calculates from baseTintColor
- (UIColor *)backgroundColor {
    static NSString *cacheKey = @"backgroundColor";
    
    UIImage *patternImage = [self imageNamed:[self backgroundPatternImageName]];
    if (patternImage) {
        return [UIColor colorWithPatternImage:patternImage];
    }
    
    id cached = self.cache[cacheKey];
    if (!cached) {
        
        // calculate lighter color
        cached = [[self baseTintColor] lighterColor];
    }
    
    if (cached) {
        self.cache[cacheKey] = cached;
        
        return cached;
    }
    
    return [super backgroundColor];
}

- (UIColor *)tabBarTintColor {
    return [[self baseTintColor] darkerColor];
}

- (UIColor *)tabBarSelectedImageTintColor {
    return [self accentTintColor];
}

- (UIColor *)navigationBarTintColor {
    return [self baseTintColor];
}

- (UIColor *)toolbarTintColor {
    return [self baseTintColor];
}

- (UIColor *)searchBarTintColor {
    return [self baseTintColor];
}

- (UIColor *)barButtonItemTintColor {
    return [self baseTintColor];
}

- (UIColor *)controlBaseTintColor {
    return [self baseTintColor];
}

- (UIColor *)controlAccentTintColor {
    return [self accentTintColor];
}

- (UIColor *)controlThumbTintColor {
    return [self controlBaseTintColor];
}

#pragma mark - Default images

// Shadows
- (UIImage *)shadowTopImage {
    return [self imageNamed:[self shadowTopImageName]];
}

- (UIImage *)shadowBottomImage {
    return [self imageNamed:[self shadowBottomImageName]];
}

// Tab bar
- (UIImage *)tabBarBackgroundImage {
    return [self imageNamed:[self tabBarBackgroundImageName]];
}

- (UIImage *)tabBarSelectionIndicatorImage {
    return [self imageNamed:[self tabBarSelectionIndicatorImageName]];
}

// Navigation bar
- (UIImage *)navigationBarBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics {
    NSMutableString *imageName = [[self navigationBarBackgroundImageName] mutableCopy];
    
    NSString *barMetricsString = [self stringFromBarMetrics:barMetrics];
    [imageName appendString:barMetricsString];
    
    return [self imageNamed:imageName];
}

// Toolbar
- (UIImage *)toolbarBackgroundImageForToolbarPosition:(UIToolbarPosition)toolbarPosition barMetrics:(UIBarMetrics)barMetrics {
    NSMutableString *imageName = [[self toolbarBackgroundImageName] mutableCopy];
    
    NSString *positionString = [self stringFromToolbarPosition:toolbarPosition];
    [imageName appendString:positionString];
    
    NSString *barMetricsString = [self stringFromBarMetrics:barMetrics];
    [imageName appendString:barMetricsString];
    
    return [self imageNamed:imageName];
}

// Search bar
- (UIImage *)searchBarBackgroundImage {
    return [self imageNamed:[self searchBarBackgroundImageName]];
}

// Bar button item
- (UIImage *)barButtonItemBackgroundImageForState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics {
    NSMutableString *imageName = [[self barButtonItemBackgroundImageName] mutableCopy];
    
    NSString *styleString = [self stringFromBarButtonItemStyle:style];
    [imageName appendString:styleString];
    
    if (state == UIControlStateNormal || state == UIControlStateHighlighted || state == UIControlStateDisabled) {
        NSString *stateString = [self stringFromControlState:state];
        [imageName appendString:stateString];
    }
    
    NSString *barMetricsString = [self stringFromBarMetrics:barMetrics];
    [imageName appendString:barMetricsString];
    
    return [self imageNamed:imageName];
}

- (UIImage *)backBarButtonItemBackgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics {
    NSMutableString *imageName = [[self backBarButtonItemBackgroundImageName] mutableCopy];
    
    NSString *stateString = [self stringFromControlState:state];
    [imageName appendString:stateString];
    
    NSString *barMetricsString = [self stringFromBarMetrics:barMetrics];
    [imageName appendString:barMetricsString];
    
    return [self imageNamed:imageName];
}

// Table view
- (UIImage *)tableViewBackgroundImage {
    return [self imageNamed:[self tableViewBackgroundImageName]];
}

@end
