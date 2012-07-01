//
//  SKSkinManager.m
//  SkinKit
//
//  Created by Dominique d'Argent on 23.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "SKSkinManager.h"

#import "SkinKit.h"

@interface SKSkinManager ()

@end


@implementation SKSkinManager

+ (id)sharedSkinManager {
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

#pragma mark - Apply skin
- (void)applySkin {
    // skip
    if (!self.skin) {
        return;
    }
    
    // notify delegate
    if ([self.delegate respondsToSelector:@selector(skinManagerWillApplySkin:)]) {
        [self.delegate skinManagerWillApplySkin:self];
    }
    
    ////////////////////////////////////////////////////////////////////////////
    
    
    // controls
    [self applySkinToControls];
    
    // tab bar
    [self applySkinToTabBar:nil];
    
    // navigation bar
    [self applySkinToNavigationBar:nil];
    
    // toolbar
    [self applySkinToToolbar:nil];
    
    // search bar
    [self applySkinToSearchBar:nil];
    
    // bar button item
    [self applySkinToBarButtonItem:nil];
    
    // toolbar button item
    [self applySkinToToolbarButtonItem:nil];
    
    ////////////////////////////////////////////////////////////////////////////
    
    // set applied
    self.skin.applied = YES;
    
    // notify delegate
    if ([self.delegate respondsToSelector:@selector(skinManagerDidApplySkin:)]) {
        [self.delegate skinManagerDidApplySkin:self];
    }
}

- (void)applySkinToControls {
    UIColor *baseTintColor = [self.skin baseTintColor];
    UIColor *accentTintColor = [self.skin accentTintColor];
    
    // control appearances
    UISwitch *switchAppearance = [UISwitch appearance];
    UIStepper *stepperAppearance = [UIStepper appearance];
    UISegmentedControl *segmentedControlAppearance = [UISegmentedControl appearance];
    UISlider *sliderAppearance = [UISlider appearance];
    UIProgressView *progressViewAppearance = [UIProgressView appearance];
    
    // base tint color
    [switchAppearance setTintColor:baseTintColor];
    [switchAppearance setThumbTintColor:baseTintColor];
    [stepperAppearance setTintColor:baseTintColor];
    [segmentedControlAppearance setTintColor:baseTintColor];
    [sliderAppearance setMaximumTrackTintColor:baseTintColor];
    [sliderAppearance setThumbTintColor:baseTintColor];
    [progressViewAppearance setTrackTintColor:baseTintColor];
    
    // accent color
    [switchAppearance setOnTintColor:accentTintColor];
    [sliderAppearance setMinimumTrackTintColor:accentTintColor];
    [progressViewAppearance setProgressTintColor:accentTintColor];
}

- (void)applySkinToTabBar:(UITabBar *)tabBarOrAppearance {
    if (!tabBarOrAppearance) {
        tabBarOrAppearance = [UITabBar appearance];
    }
    
    [tabBarOrAppearance setTintColor:[self.skin tabBarTintColor]];
    [tabBarOrAppearance setBackgroundImage:[self.skin tabBarBackgroundImage]];
    [tabBarOrAppearance setSelectionIndicatorImage:[self.skin tabBarSelectionIndicatorImage]];
    [tabBarOrAppearance setSelectedImageTintColor:[self.skin accentTintColor]];
    [tabBarOrAppearance setShadowImage:[self.skin shadowBottomImage]];
}

- (void)applySkinToNavigationBar:(UINavigationBar *)navigationBarOrAppearance {
    if (!navigationBarOrAppearance) {
        navigationBarOrAppearance = [UINavigationBar appearance];
    }
    
    [navigationBarOrAppearance setTintColor:[self.skin navigationBarTintColor]];
    [navigationBarOrAppearance setShadowImage:[self.skin shadowTopImage]];
    
    UIBarMetrics barMetrics = UIBarMetricsDefault;
    UIImage *image = [self.skin navigationBarBackgroundImageForBarMetrics:barMetrics];
    
    [navigationBarOrAppearance setBackgroundImage:image
                                    forBarMetrics:barMetrics];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        barMetrics = UIBarMetricsLandscapePhone;
        image = [self.skin navigationBarBackgroundImageForBarMetrics:barMetrics];
        
        [navigationBarOrAppearance setBackgroundImage:image
                                        forBarMetrics:barMetrics];
    }
}

- (void)applySkinToToolbar:(UIToolbar *)toolbarOrAppearance {
    if (!toolbarOrAppearance) {
        toolbarOrAppearance = [UIToolbar appearance];
    }
    
    [toolbarOrAppearance setTintColor:[self.skin toolbarTintColor]];
    
    UIImage *image;
    UIToolbarPosition position;
    UIBarMetrics barMetrics = UIBarMetricsDefault;
    
    // toolbar position: any
    position = UIToolbarPositionAny;
    image = [self.skin toolbarBackgroundImageForToolbarPosition:position
                                                     barMetrics:barMetrics];
    [toolbarOrAppearance setBackgroundImage:image
                         forToolbarPosition:position
                                 barMetrics:barMetrics];
    
    // toolbar position: top
    position = UIToolbarPositionTop;
    image = [self.skin toolbarBackgroundImageForToolbarPosition:position
                                                     barMetrics:barMetrics];
    [toolbarOrAppearance setBackgroundImage:image
                         forToolbarPosition:position
                                 barMetrics:barMetrics];
    
    // toolbar position: bottom
    position = UIToolbarPositionBottom;
    image = [self.skin toolbarBackgroundImageForToolbarPosition:position
                                                     barMetrics:barMetrics];
    [toolbarOrAppearance setBackgroundImage:image
                         forToolbarPosition:position
                                 barMetrics:barMetrics];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        barMetrics = UIBarMetricsLandscapePhone;
        
        // toolbar position: any
        position = UIToolbarPositionAny;
        image = [self.skin toolbarBackgroundImageForToolbarPosition:position
                                                         barMetrics:barMetrics];
        [toolbarOrAppearance setBackgroundImage:image
                             forToolbarPosition:position
                                     barMetrics:barMetrics];
        
        // toolbar position: top
        position = UIToolbarPositionTop;
        image = [self.skin toolbarBackgroundImageForToolbarPosition:position
                                                         barMetrics:barMetrics];
        [toolbarOrAppearance setBackgroundImage:image
                             forToolbarPosition:position
                                     barMetrics:barMetrics];
        
        // toolbar position: bottom
        position = UIToolbarPositionBottom;
        image = [self.skin toolbarBackgroundImageForToolbarPosition:position
                                                         barMetrics:barMetrics];
        [toolbarOrAppearance setBackgroundImage:image
                             forToolbarPosition:position
                                     barMetrics:barMetrics];
    }
}

- (void)applySkinToSearchBar:(UISearchBar *)searchBarOrAppearance {
    if (!searchBarOrAppearance) {
        searchBarOrAppearance = [UISearchBar appearance];
    }
    
    [searchBarOrAppearance setTintColor:[self.skin searchBarTintColor]];
    [searchBarOrAppearance setBackgroundImage:[self.skin searchBarBackgroundImage]];
}

- (void)applySkinToBarButtonItem:(UIBarButtonItem *)barButtonItemOrAppearance {
    if (!barButtonItemOrAppearance) {
        barButtonItemOrAppearance = [UIBarButtonItem appearance];
    }
    
    [barButtonItemOrAppearance setTintColor:[self.skin barButtonItemTintColor]];
    
    UIControlState state = UIControlStateNormal;
    UIBarButtonItemStyle style = UIBarButtonItemStyleBordered;
    UIBarMetrics barMetrics = UIBarMetricsDefault;
    UIImage *image;
    
    UIControlState states[] = {UIControlStateNormal, UIControlStateHighlighted, UIControlStateDisabled};
    NSUInteger n = sizeof(states) / sizeof(UIControlState);
    
    for (NSUInteger i = 0; i < n; i++) {
        state = states[i];

        barMetrics = UIBarMetricsDefault;
        
        style = UIBarButtonItemStyleBordered;
        image = [self.skin barButtonItemBackgroundImageForState:state
                                                          style:style
                                                     barMetrics:barMetrics];
        
        [barButtonItemOrAppearance setBackgroundImage:image
                                             forState:state
                                                style:style
                                           barMetrics:barMetrics];
        
        style = UIBarButtonItemStyleDone;
        image = [self.skin barButtonItemBackgroundImageForState:state
                                                          style:style
                                                     barMetrics:barMetrics];
        
        [barButtonItemOrAppearance setBackgroundImage:image
                                             forState:state
                                                style:style
                                           barMetrics:barMetrics];
        
        // back bar button item
        image = [self.skin backBarButtonItemBackgroundImageForState:state
                                                         barMetrics:barMetrics];
        [barButtonItemOrAppearance setBackButtonBackgroundImage:image
                                                       forState:state
                                                     barMetrics:barMetrics];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            barMetrics = UIBarMetricsLandscapePhone;
            
            style = UIBarButtonItemStyleBordered;
            image = [self.skin barButtonItemBackgroundImageForState:state
                                                              style:style
                                                         barMetrics:barMetrics];
            
            [barButtonItemOrAppearance setBackgroundImage:image
                                                 forState:state
                                                    style:style
                                               barMetrics:barMetrics];
            
            style = UIBarButtonItemStyleDone;
            image = [self.skin barButtonItemBackgroundImageForState:state
                                                              style:style
                                                         barMetrics:barMetrics];
            
            [barButtonItemOrAppearance setBackgroundImage:image
                                                 forState:state
                                                    style:style
                                               barMetrics:barMetrics];
            
            // back bar button item
            image = [self.skin backBarButtonItemBackgroundImageForState:state
                                                             barMetrics:barMetrics];
            [barButtonItemOrAppearance setBackButtonBackgroundImage:image
                                                           forState:state
                                                         barMetrics:barMetrics];
        }
    }
    
}

- (void)applySkinToToolbarButtonItem:(UIBarButtonItem *)barButtonItemOrAppearance {
    if (!barButtonItemOrAppearance) {
        barButtonItemOrAppearance = [UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil];
    }
    
    [barButtonItemOrAppearance setTintColor:[self.skin accentTintColor]];
}

/*
 - (void)applySkin2 {
 if (!self.skin) {
 return;
 }
 
 static UIControlState controlStates[] = {UIControlStateNormal, UIControlStateHighlighted, UIControlStateDisabled, UIControlStateSelected};
 static NSUInteger numControlStates = sizeof(controlStates) / sizeof(UIControlState);
 
 static UIBarMetrics barMetrics[] = {UIBarMetricsDefault, UIBarMetricsLandscapePhone};
 static NSUInteger numBarMetrics = sizeof(barMetrics) / sizeof(UIBarMetrics);
 
 static UIBarButtonItemStyle barButtonItemStyles[] = {UIBarButtonItemStylePlain, UIBarButtonItemStyleBordered, UIBarButtonItemStyleDone};
 static NSUInteger numBarButtonItemStyles = sizeof(barButtonItemStyles) / sizeof(UIBarButtonItemStyle);
 
 static UIToolbarPosition toolbarPositions[] = {UIToolbarPositionAny, UIToolbarPositionBottom, UIToolbarPositionTop};
 static NSUInteger numToolbarPositions = sizeof(toolbarPositions) / sizeof(UIToolbarPosition);
 
 
 UIColor *baseTintColor = [self.skin baseTintColor];
 UIColor *accentTintColor = [self.skin accentTintColor];
 
 NSMutableDictionary *titleTextAttributes = [[NSMutableDictionary alloc] init];
 
 UIColor *titleTextColor = [self.skin titleTextColor];
 if (titleTextColor) {
 [titleTextAttributes setObject:titleTextColor forKey:UITextAttributeTextColor];
 }
 
 UIColor *titleTextShadowColor = [self.skin titleTextShadowColor];
 if (titleTextShadowColor) {
 [titleTextAttributes setObject:titleTextShadowColor forKey:UITextAttributeTextShadowColor];
 }
 
 
 
 CGSize titleTextShadowOffset = [self.skin titleTextShadowOffset];
 
 if (!CGSizeEqualToSize(titleTextShadowOffset, SKINKIT_CGSizeNull)) {
 [titleTextAttributes setObject:[NSValue valueWithCGSize:titleTextShadowOffset] forKey:UITextAttributeTextShadowOffset];
 }
 
 UILabel *headerLabelAppearane = [UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil];
 [headerLabelAppearane setTextColor:titleTextColor];
 [headerLabelAppearane setShadowColor:titleTextShadowColor];
 [headerLabelAppearane setShadowOffset:titleTextShadowOffset];
 
 
 // Tab bar
 UITabBar *tabBarAppearance = [UITabBar appearance];
 [tabBarAppearance setShadowImage:[self.skin shadowBottomImage]];
 [tabBarAppearance setSelectionIndicatorImage:[self.skin tabBarSelectionIndicatorImage]];
 [tabBarAppearance setBackgroundImage:[self.skin tabBarBackgroundImage]];
 
 
 // Navigation bar
 UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
 [navigationBarAppearance setShadowImage:[self.skin shadowTopImage]];
 for (NSUInteger i = 0; i < numBarMetrics; i++) {
 UIBarMetrics metrics = barMetrics[i];
 
 UIImage *image = [self.skin navigationBarBackgroundImageForBarMetrics:metrics];
 [navigationBarAppearance setBackgroundImage:image
 forBarMetrics:metrics];
 }
 
 
 // Tool bar
 UIToolbar *toolbarAppearance = [UIToolbar appearance];
 [toolbarAppearance setShadowImage:[self.skin shadowBottomImage]
 forToolbarPosition:UIToolbarPositionBottom];
 [toolbarAppearance setShadowImage:[self.skin shadowTopImage]
 forToolbarPosition:UIToolbarPositionTop];
 for (NSUInteger i = 0; i < numToolbarPositions; i++) {
 UIToolbarPosition toolbarPosition = toolbarPositions[i];
 
 for (NSUInteger j = 0; j < numBarMetrics; j++) {
 UIBarMetrics metrics = barMetrics[j];
 
 UIImage *image = [self.skin toolbarBackgroundImageForToolbarPosition:toolbarPosition
 barMetrics:metrics];
 [toolbarAppearance setBackgroundImage:image
 forToolbarPosition:toolbarPosition
 barMetrics:metrics];
 }
 }
 
 
 //    // Bar item
 //    UIBarButtonItem *barItemAppearance = [UIBarButtonItem appearance];
 //    for (NSUInteger i = 0; i < numControlStates; i++) {
 //        UIControlState state = controlStates[i];
 //
 //        // there is no selected state on bar button items!
 //        if (state == UIControlStateSelected) {
 //            continue;
 //        }
 //
 //        [barItemAppearance setTitleTextAttributes:[self.skin barItemTitleTextAttributesForState:state]
 //                                         forState:state];
 //    }
 
 
 // Bar button item
 
 // navigation bar button item
 UIBarButtonItem *navigationBarButtonAppearance = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
 
 // toolbar button item
 UIBarButtonItem *toolbarButtonAppearance = [UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil];
 [toolbarButtonAppearance setTintColor:titleTextColor];
 
 for (NSUInteger i = 0; i < numControlStates; i++) {
 UIControlState state = controlStates[i];
 
 for (NSUInteger j = 0; j < numBarMetrics; j++) {
 UIBarMetrics metrics = barMetrics[j];
 
 UIImage *image;
 
 // navigation back bar button item
 image = [self.skin navigationBackBarButtonItemBackgroundImageForState:state
 barMetrics:metrics];
 [navigationBarButtonAppearance setBackButtonBackgroundImage:image
 forState:state
 barMetrics:metrics];
 
 for (NSUInteger k = 0; k < numBarButtonItemStyles; k++) {
 UIBarButtonItemStyle style = barButtonItemStyles[k];
 
 // navigation bar button item
 image = [self.skin navigationBarButtonItemBackgroundImageForState:state
 style:style
 barMetrics:metrics];
 [navigationBarButtonAppearance setBackgroundImage:image
 forState:state
 style:style
 barMetrics:metrics];
 // toolbar button item
 image = [self.skin toolbarButtonItemBackgroundImageForState:state
 style:style
 barMetrics:metrics];
 [toolbarButtonAppearance setBackgroundImage:image
 forState:state
 style:style
 barMetrics:metrics];
 }
 
 }
 }
 
 UISearchBar *searchBarAppearance = [UISearchBar appearance];
 UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearance];
 
 
 // Controls
 UISwitch *switchAppearance = [UISwitch appearance];
 UIStepper *stepperAppearance = [UIStepper appearance];
 UISegmentedControl *segmentedControlAppearance = [UISegmentedControl appearance];
 UISlider *sliderAppearance = [UISlider appearance];
 UIProgressView *progressViewAppearance = [UIProgressView appearance];
 
 //    if (baseTintColor) {
 [tabBarAppearance setTintColor:baseTintColor];
 [navigationBarAppearance setTintColor:baseTintColor];
 [toolbarAppearance setTintColor:baseTintColor];
 [navigationBarButtonAppearance setTintColor:baseTintColor];
 [searchBarAppearance setTintColor:baseTintColor];
 
 [switchAppearance setTintColor:baseTintColor];
 [switchAppearance setThumbTintColor:baseTintColor];
 [stepperAppearance setTintColor:baseTintColor];
 [segmentedControlAppearance setTintColor:baseTintColor];
 [sliderAppearance setMaximumTrackTintColor:baseTintColor];
 [sliderAppearance setThumbTintColor:baseTintColor];
 [progressViewAppearance setTrackTintColor:baseTintColor];
 //    }
 
 //    if (accentTintColor) {
 [tabBarAppearance setSelectedImageTintColor:accentTintColor];
 
 [switchAppearance setOnTintColor:accentTintColor];
 [sliderAppearance setMinimumTrackTintColor:accentTintColor];
 [progressViewAppearance setProgressTintColor:accentTintColor];
 //    }
 
 
 //    if ([titleTextAttributes count]) {
 [navigationBarAppearance setTitleTextAttributes:titleTextAttributes];
 [barButtonItemAppearance setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
 [barButtonItemAppearance setTitleTextAttributes:titleTextAttributes forState:UIControlStateHighlighted];
 [segmentedControlAppearance setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
 //    }
 
 }
 */

- (void)applySkinToView:(UIView *)view {
    if (![self.skin wasApplied]) {
        return;
    }
    
    UIColor *backgroundColor = [self.skin backgroundColor];
    
    if (backgroundColor) {
        [view setBackgroundColor:backgroundColor];
    }
}

- (void)applySkinToTableView:(UITableView *)tableView {
    if (![self.skin wasApplied]) {
        return;
    }
    
    UIImage *backgroundImage = [self.skin tableViewBackgroundImage];
    
    if (backgroundImage) {
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        [tableView setBackgroundView:backgroundView];
    }
    else {
        UIColor *backgroundColor = [self.skin backgroundColor];
        
        if (backgroundColor) {
            [tableView setBackgroundColor:backgroundColor];
            [tableView setBackgroundView:[[UIView alloc] initWithFrame:tableView.backgroundView.frame]];
        }
    }
    
    // content insets
    tableView.contentInset = [self.skin scrollViewContentInsets];
    tableView.scrollIndicatorInsets = [self.skin scrollViewContentInsets];
}

#pragma mark - Custom accessors
- (BOOL)shouldAutomaticallyApplySkinForViews {
    if ([self.skin respondsToSelector:@selector(shouldAutomaticallyApplySkinForViews)]) {
        return [self.skin shouldAutomaticallyApplySkinForViews];
    }
    
    return _automaticallyApplySkinForViews;
}

- (BOOL)shouldAutomaticallyApplySkinForTableViews {
    if ([self.skin respondsToSelector:@selector(shouldAutomaticallyApplySkinForTableViews)]) {
        return [self.skin shouldAutomaticallyApplySkinForTableViews];
    }
    
    return _automaticallyApplySkinForTableViews;
}

#pragma mark - Private methods
//- (void)reload {
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//
//    UIStoryboard *storyboard = window.rootViewController.storyboard;
//    if (storyboard) {
//        // warn user that unsaved changes will be discarded
//        window.rootViewController = [storyboard instantiateInitialViewController];
//    }
//
//}

@end
