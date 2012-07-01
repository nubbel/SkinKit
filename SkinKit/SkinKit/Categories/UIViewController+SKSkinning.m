//
//  UIViewController+SKSkinning.m
//  SkinKit
//
//  Created by Dominique d'Argent on 24.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "UIViewController+SKSkinning.h"
#import "SKSkinManager.h"

@implementation UIViewController (SKSkinning)


// TODO: avoid this! Use method swizzling?
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (void)viewWillAppear:(BOOL)animated {
    SKSkinManager *manager = [SKSkinManager sharedSkinManager];
    
    if ([manager shouldAutomaticallyApplySkinForViews] && ![self.view isKindOfClass:[UITableView class]]) {
        [manager applySkinToView:self.view];
    }
}

#pragma clang diagnostic pop

@end
