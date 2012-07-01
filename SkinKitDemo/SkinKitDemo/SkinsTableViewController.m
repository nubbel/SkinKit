//
//  SkinsTableViewController.m
//  SkinKitDemo
//
//  Created by Dominique d'Argent on 24.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "SkinsTableViewController.h"
#import "ViewController.h"
#import "TintedSkin.h"
#import "MetalSkin.h"
#import "LeatherSkin.h"

@interface SkinsTableViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *skins;

@end

@implementation SkinsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.skins = @[
    NSStringFromClass([SKDefaultSkin class]),
    NSStringFromClass([TintedSkin class]),
    NSStringFromClass([MetalSkin class]),
    NSStringFromClass([LeatherSkin class]) ];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.contentOffset = CGPointMake(0.0, self.searchDisplayController.searchBar.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.skins count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    id skin = self.skins[indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = skin;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *skinName = self.skins[indexPath.row];
    id <SKSkinDataSource> skin = [[NSClassFromString(skinName) alloc] init];
    
    
    // save user defaults
    [[NSUserDefaults standardUserDefaults] setObject:skinName forKey:@"skin"];
    
    ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SwitchSkinViewController"];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    viewController.backgroundImage = [UIImage screenshot];
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    
    [self presentViewController:viewController
                       animated:NO
                     completion:^{
                         SKSkinManager *skinManager = [SKSkinManager sharedSkinManager];
                         skinManager.skin = skin;
                         
                         [skinManager applySkin];
                         
                         double delayInSeconds = 1.0;
                         dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                         dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                             [[UIApplication sharedApplication] setStatusBarHidden:NO
                                                                     withAnimation:UIStatusBarAnimationFade];
                             
                             [self dismissViewControllerAnimated:YES
                                                      completion:nil];
                         });
                     }];
}

- (IBAction)reset:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                    message:@"Are you sure you want to reset the user interface?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        self.view.window.rootViewController = [self.storyboard instantiateInitialViewController];
    }
}

@end
