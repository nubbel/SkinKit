//
//  UITableView+SKSkinning.m
//  SkinKit
//
//  Created by Dominique d'Argent on 24.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "UITableView+SKSkinning.h"
#import "SKSkinManager.h"

@implementation UITableView (SKSkinning)

- (void)willMoveToWindow:(UIWindow *)newWindow {
    SKSkinManager *manager = [SKSkinManager sharedSkinManager];
    
    if ([manager shouldAutomaticallyApplySkinForTableViews]) {
        [manager applySkinToTableView:self];
    }
}

@end
