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

#pragma mark - Custom accessor

- (NSMutableDictionary *)cache {
    // lazy initialize
    if (!_cache) {
        _cache = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    
    return _cache;
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
    
    // 1. from bundle
    UIColor *color = [super baseTintColor];
    if (color) {
        return color;
    }
    
    // 2. derive from navigation bar image
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
    
    return nil;
}

// calculates from baseTintColor
- (UIColor *)backgroundColor {
    static NSString *cacheKey = @"backgroundColor";
    
    // 1. from specified pattern image
    UIImage *patternImage = [self imageNamed:[self backgroundPatternImageName]];
    if (patternImage) {
        return [UIColor colorWithPatternImage:patternImage];
    }
    
    // 2. from bundle
    UIColor *color = [super backgroundColor];
    if (color) {
        return color;
    }
    
    // 3. lighter than base tint color
    id cached = self.cache[cacheKey];
    if (!cached) {
        
        // calculate lighter color
        cached = [[self baseTintColor] lighterColor];
    }
    
    if (cached) {
        self.cache[cacheKey] = cached;
        
        return cached;
    }
    
    return nil;
}

- (UIColor *)tabBarTintColor {
    UIColor *color = [super tabBarTintColor];
    if (color) {
        return color;
    }
    
    return [[self baseTintColor] darkerColor];
}

- (UIColor *)tabBarSelectedImageTintColor {
    UIColor *color = [super tabBarSelectedImageTintColor];
    if (color) {
        return color;
    }
    
    return [self accentTintColor];
}

- (UIColor *)navigationBarTintColor {
    UIColor *color = [super navigationBarTintColor];
    if (color) {
        return color;
    }
    
    return [self baseTintColor];
}

- (UIColor *)toolbarTintColor {
    UIColor *color = [super toolbarTintColor];
    if (color) {
        return color;
    }
    
    return [self baseTintColor];
}

- (UIColor *)searchBarTintColor {
    UIColor *color = [super searchBarTintColor];
    if (color) {
        return color;
    }
    
    return [self baseTintColor];
}

- (UIColor *)barButtonItemTintColor {
    UIColor *color = [super barButtonItemTintColor];
    if (color) {
        return color;
    }
    
    return [self baseTintColor];
}

- (UIColor *)controlBaseTintColor {
    UIColor *color = [super controlBaseTintColor];
    if (color) {
        return color;
    }
    
    return [self baseTintColor];
}

- (UIColor *)controlAccentTintColor {
    UIColor *color = [super controlAccentTintColor];
    if (color) {
        return color;
    }
    
    return [self accentTintColor];
}

- (UIColor *)controlThumbTintColor {
    UIColor *color = [super controlThumbTintColor];
    if (color) {
        return color;
    }
    
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
