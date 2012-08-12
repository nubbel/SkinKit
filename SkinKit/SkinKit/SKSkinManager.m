//
//  SKSkinManager.m
//  SkinKit
//
//  Created by Dominique d'Argent on 23.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "SKSkinManager.h"
#import "SKConstants.h"

@interface SKSkinManager ()

@end


@implementation SKSkinManager

+ (SKSkinManager *)sharedSkinManager {
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    
    if (self) {
        self.automaticallyApplySkinForViews = NO;
    }
    
    return self;
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
    
    // table view header/footer label
    [self applySkinToTableViewHeaderFooterLabel:nil];
    
    ////////////////////////////////////////////////////////////////////////////
    
    // set applied
    self.skin.applied = YES;
    
    // notify delegate
    if ([self.delegate respondsToSelector:@selector(skinManagerDidApplySkin:)]) {
        [self.delegate skinManagerDidApplySkin:self];
    }
}

- (void)applySkinToControls {
    UIColor *baseTintColor   = [self.skin controlBaseTintColor];
    UIColor *accentTintColor = [self.skin controlAccentTintColor];
    UIColor *thumbTintColor  = [self.skin controlThumbTintColor];
    
    // control appearances
    UISwitch *switchAppearance = [UISwitch appearance];
    UIStepper *stepperAppearance = [UIStepper appearance];
    UISegmentedControl *segmentedControlAppearance = [UISegmentedControl appearance];
    UISlider *sliderAppearance = [UISlider appearance];
    UIProgressView *progressViewAppearance = [UIProgressView appearance];
    
    // base tint color
    [switchAppearance setTintColor:baseTintColor];
    [stepperAppearance setTintColor:baseTintColor];
    [segmentedControlAppearance setTintColor:baseTintColor];
    [sliderAppearance setMaximumTrackTintColor:baseTintColor];
    [progressViewAppearance setTrackTintColor:baseTintColor];
    
    // accent tint color
    [switchAppearance setOnTintColor:accentTintColor];
    [sliderAppearance setMinimumTrackTintColor:accentTintColor];
    [progressViewAppearance setProgressTintColor:accentTintColor];
    
    // thumb tint color
    [switchAppearance setThumbTintColor:thumbTintColor];
    [sliderAppearance setThumbTintColor:thumbTintColor];
}

- (void)applySkinToTabBar:(UITabBar *)tabBarOrAppearance {
    if (!tabBarOrAppearance) {
        tabBarOrAppearance = [UITabBar appearance];
    }
    
    [tabBarOrAppearance setTintColor:[self.skin tabBarTintColor]];
    [tabBarOrAppearance setBackgroundImage:[self.skin tabBarBackgroundImage]];
    [tabBarOrAppearance setSelectionIndicatorImage:[self.skin tabBarSelectionIndicatorImage]];
    [tabBarOrAppearance setSelectedImageTintColor:[self.skin tabBarSelectedImageTintColor]];
    [tabBarOrAppearance setShadowImage:[self.skin shadowBottomImage]];
}

- (void)applySkinToNavigationBar:(UINavigationBar *)navigationBarOrAppearance {
    if (!navigationBarOrAppearance) {
        navigationBarOrAppearance = [UINavigationBar appearance];
    }
    
    [navigationBarOrAppearance setTintColor:[self.skin navigationBarTintColor]];
    [navigationBarOrAppearance setShadowImage:[self.skin shadowTopImage]];
    [navigationBarOrAppearance setTitleTextAttributes:[self.skin navigationBarTitleTextAttributes]];
    
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

        
        [barButtonItemOrAppearance setTitleTextAttributes:[self.skin barButtonItemTitleTextAttributesForState:state]
                                                 forState:state];
        
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

- (void)applySkinToTableViewHeaderFooterLabel:(UILabel *)labelOrAppearance {
    if (!labelOrAppearance) {
        labelOrAppearance = [UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil];
    }
    
    NSDictionary *textAttributes = [self.skin tableViewHeaderFooterLabelTextAttributes];
    
    UIFont *font = [textAttributes objectForKey:UITextAttributeFont];
    if (font) {
        [labelOrAppearance setFont:font];
    }
    
    UIColor *textColor = [textAttributes objectForKey:UITextAttributeTextColor];
    if (textColor) {
        [labelOrAppearance setTextColor:textColor];
    }
    
    UIColor *shadowColor = [textAttributes objectForKey:UITextAttributeTextShadowColor];
    if (shadowColor) {
        [labelOrAppearance setShadowColor:shadowColor];
    }
    
    NSValue *shadowOffset = [textAttributes objectForKey:UITextAttributeTextShadowOffset];
    if (shadowOffset) {
        [labelOrAppearance setShadowOffset:[shadowOffset CGSizeValue]];
    }

}

- (void)applySkinToGenericView:(UIView *)view {
    [self applySkinToView:view];
    
    if ([view isKindOfClass:[UIScrollView class]]) {
        [self applySkinToScrollView:(UIScrollView *)view];
    }
    
    if ([view isKindOfClass:[UITableView class]]) {
        [self applySkinToTableView:(UITableView *)view];
    }
    
    if ([view isKindOfClass:[UICollectionView class]]) {
        [self applySkinToCollectionView:(UICollectionView *)view];
    }
}

- (void)applySkinToView:(UIView *)view {
    // set background color
    UIColor *backgroundColor = [self.skin backgroundColor];
    if (backgroundColor) {
        [view setBackgroundColor:backgroundColor];
    }
}

- (void)applySkinToScrollView:(UIScrollView *)scrollView {
    // set content insets
    
    NSValue *contentInsets = [self.skin scrollViewContentInsets];
    if (contentInsets) {
        scrollView.contentInset = [contentInsets UIEdgeInsetsValue];
        scrollView.scrollIndicatorInsets = [contentInsets UIEdgeInsetsValue];
    }
}

- (void)applySkinToTableView:(UITableView *)tableView {
    // set background image if specified
    UIImage *backgroundImage = [self.skin tableViewBackgroundImage];
    if (backgroundImage) {
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        [tableView setBackgroundView:backgroundView];
    }
    else {
        // else set background color if specified
        UIColor *backgroundColor = [self.skin backgroundColor];
        if (backgroundColor) {
            [tableView setBackgroundColor:backgroundColor];
            [tableView setBackgroundView:[[UIView alloc] initWithFrame:tableView.backgroundView.frame]];
        }
    }
}

- (void)applySkinToCollectionView:(UICollectionView *)collectionView {
    // TODO: add collection view skinning
}

#pragma mark - Custom accessors
- (BOOL)shouldAutomaticallyApplySkinForViews {
    if ([self.skin respondsToSelector:@selector(shouldAutomaticallyApplySkinForViews)]) {
        return [self.skin shouldAutomaticallyApplySkinForViews];
    }
    
    return _automaticallyApplySkinForViews;
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
