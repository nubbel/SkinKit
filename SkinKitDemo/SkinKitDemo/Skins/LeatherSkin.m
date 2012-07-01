//
//  LeatherSkin.m
//  SkinKitDemo
//
//  Created by Dominique d'Argent on 26.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "LeatherSkin.h"

#define NAVIGATION_BAR_EDGE_INSETS UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)
#define TAB_BAR_EDGE_INSETS UIEdgeInsetsMake(0.0, 26.0, 0.0, 26.0)

@implementation LeatherSkin

//- (NSString *)backgroundPatternImageName {
//    return [[super backgroundPatternImageName] stringByAppendingString:@"Dark"];
//}

- (UIImage *)tabBarBackgroundImage {
    return [[super tabBarBackgroundImage]
            resizableImageWithCapInsets:TAB_BAR_EDGE_INSETS];
}

- (UIImage *)navigationBarBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics {
    return [[super navigationBarBackgroundImageForBarMetrics:barMetrics]
            resizableImageWithCapInsets:NAVIGATION_BAR_EDGE_INSETS];
}

- (UIImage *)shadowTopImage {
    return [[super shadowTopImage]
            resizableImageWithCapInsets:NAVIGATION_BAR_EDGE_INSETS];
}

- (UIImage *)shadowBottomImage {
    return [[super shadowBottomImage]
            resizableImageWithCapInsets:TAB_BAR_EDGE_INSETS];
}

- (UIImage *)barButtonItemBackgroundImageForState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics {
    return [[super barButtonItemBackgroundImageForState:state
                                                 style:style
                                             barMetrics:barMetrics]
            resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
}

- (UIImage *)backBarButtonItemBackgroundImageForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics {
    return [[super backBarButtonItemBackgroundImageForState:state
                                                 barMetrics:barMetrics]
            resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 13.0, 0.0, 5.0)];
}

- (UIEdgeInsets)scrollViewContentInsets {
    return UIEdgeInsetsMake(10.0, 0.0, 10.0, 0.0);
}

@end
