//
//  TableViewController.m
//  SkinKitDemo
//
//  Created by Dominique d'Argent on 26.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[SKSkinManager sharedSkinManager] applySkinToTableView:self.tableView];
}

@end
