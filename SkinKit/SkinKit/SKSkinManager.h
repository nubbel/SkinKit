//
//  SKSkinManager.h
//  SkinKit
//
//  Created by Dominique d'Argent on 23.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SKSkinDataSource.h"

@protocol SKSkinManagerDelegate;

@interface SKSkinManager : NSObject

// singleton
+ (SKSkinManager *)sharedSkinManager;

@property (nonatomic, weak) id <SKSkinManagerDelegate> delegate;
@property (nonatomic, strong) id <SKSkinDataSource> skin;


@property (nonatomic, assign, getter = shouldAutomaticallyApplySkinForViews) BOOL automaticallyApplySkinForViews;

- (void)applySkin;
- (void)applySkinToGenericView:(UIView *)view;
- (void)applySkinToView:(UIView *)view;
- (void)applySkinToScrollView:(UIScrollView *)scrollView;
- (void)applySkinToTableView:(UITableView *)tableView;
- (void)applySkinToCollectionView:(UICollectionView *)collectionView;

@end

@protocol SKSkinManagerDelegate <NSObject>

@optional

- (void)skinManagerWillApplySkin:(SKSkinManager *)skinManager;
- (void)skinManagerDidApplySkin:(SKSkinManager *)skinManager;

@end