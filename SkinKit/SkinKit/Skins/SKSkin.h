//
//  SKDefaultSkin.h
//  SkinKit
//
//  Created by Dominique d'Argent on 23.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//


#import "SKSkinDataSource.h"

@interface SKSkin : NSObject <SKSkinDataSource>

@property (nonatomic, strong, readonly) NSBundle *bundle;

// convenience methods
- (UIImage *)imageNamed:(NSString *)name;


@end
