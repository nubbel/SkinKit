//
//  SkinKit.h
//  SkinKit
//
//  Created by Dominique d'Argent on 23.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - SkinKit

#define SKINKIT_VERSION @"0.0.1"
#define SKINKIT_AUTHOR  @"Dominique d'Argent"
#define SKINKIT_BUNDLE_EXTENSION @"bundle"

#define SKINKIT_CGSizeNull CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)

@interface SkinKit : NSObject

+ (NSString *)version;
+ (NSString *)author;

@end

#pragma mark - Framwork imports
#import "SKSkinManager.h"

// skins
#import "SKSkinDataSource.h"
#import "SKSkin.h"
#import "SKDefaultSkin.h"

// categories
#import "UIImage+SKSkinning.h"
#import "UIColor+SKSkinning.h"
#import "UIViewController+SKSkinning.h"