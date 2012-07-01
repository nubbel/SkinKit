//
//  NSObject+SKSkinning.h
//  SkinKit
//
//  Created by Dominique d'Argent on 25.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SKINKIT_SWIZZLE_PREFIX @"_SKSkinning_"

@interface NSObject (SKSkinning)

+ (BOOL)swizzleClassMethodWithSelector:(SEL)selector prefix:(NSString *)prefix;
+ (BOOL)swizzleInstanceMethodWithSelector:(SEL)selector prefix:(NSString *)prefix;

@end
