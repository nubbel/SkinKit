//
//  NSObject+SKSkinning.m
//  SkinKit
//
//  Created by Dominique d'Argent on 25.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "NSObject+SKSkinning.h"

#import <objc/runtime.h>

@implementation NSObject (SKSkinning)

+ (BOOL)swizzleClassMethodWithSelector:(SEL)selector prefix:(NSString *)prefix {
    SEL swizzledSelector = [self prefixedSelectorWithSelector:selector prefix:prefix];
    
    Method m1 = class_getClassMethod(self, selector);
    Method m2 = class_getClassMethod(self, swizzledSelector);
    
    return [self swizzleMethod:m1 andMethod:m2];
}

+ (BOOL)swizzleInstanceMethodWithSelector:(SEL)selector prefix:(NSString *)prefix {
    SEL swizzledSelector = [self prefixedSelectorWithSelector:selector prefix:prefix];
    
    Method m1 = class_getInstanceMethod(self, selector);
    Method m2 = class_getInstanceMethod(self, swizzledSelector);
    
    return [self swizzleMethod:m1 andMethod:m2];
}

#pragma mark - Private methods
+ (BOOL)swizzleMethod:(Method)m1 andMethod:(Method)m2 {
    if (m1 && m2) {
        method_exchangeImplementations(m1, m2);
        
        return YES;
    }
    
    return NO;
}


+ (SEL)prefixedSelectorWithSelector:(SEL)selector prefix:(NSString *)prefix {
    // needed for autoreleased strings
    @autoreleasepool {
        return NSSelectorFromString([prefix stringByAppendingString:NSStringFromSelector(selector)]);
    }
}

@end
