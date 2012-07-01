//
//  ViewController.m
//  SkinKitDemo
//
//  Created by Dominique d'Argent on 26.06.12.
//  Copyright (c) 2012 Dominique d'Argent. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

@synthesize imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = self.backgroundImage;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[SKSkinManager sharedSkinManager] applySkinToView:self.view];
}

// New Autorotation support.
- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

//// Returns interface orientation masks.
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationMaskPortrait;
//}

@end
