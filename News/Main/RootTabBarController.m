//
//  RootTabBarController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootTabBarController.h"
#import "NavigationController.h"
#import "NewPage/Controller/HomeViewController.h"
#import "VideoPage/Controller/VideoViewController.h"
#import "PhotoPage/Controller/PhotoViewController.h"


@interface RootTabBarController()

@end

@implementation RootTabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
        
    [self addChildVC:[HomeViewController new] withTitle:@"Home" withImage:@"home_tab" withSelectedImage:@"home_tab_selected"];
    
    [self addChildVC:[VideoViewController new] withTitle:@"Video" withImage:@"video_tab" withSelectedImage:@"video_tab_selected"];
    
    [self addChildVC:[PhotoViewController new] withTitle:@"Photo" withImage:@"photo_tab" withSelectedImage:@"photo_tab_selected"];
}

#pragma mark - private method

- (void)addChildVC:(UIViewController*)childVC withTitle:(NSString*)title withImage:(NSString*)image withSelectedImage:(NSString*)selectedImage{
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    NavigationController * nav = [[NavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

@end
