//
//  UIView+SKSkinning.m
//  SkinKit
//
//  Created by Dominique d'Argent on 24.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "UIView+SKSkinning.h"
#import "SKSkinManager.h"

@implementation UIView (SKSkinning)

- (void)willMoveToWindow:(UIWindow *)newWindow {
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        [[SKSkinManager sharedSkinManager] applySkinToView:self];
    }
}

@end
