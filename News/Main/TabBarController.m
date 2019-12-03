//
//  TabBarController.m
//  News
//
//  Created by tplish on 2019/12/2.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TabBarController.h"
#import "TabBarItem/HomeViewController.h"
#import "TabBarItem/OtherViewController.h"

@interface TabBarController()
@property (nonatomic, strong) UINavigationController * homeNav;
@property (nonatomic, strong) UINavigationController * otherNav;
@end

@implementation TabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.viewControllers = @[self.homeNav, self.otherNav];
}

- (UINavigationController *)homeNav{
    if (_homeNav == nil){
        UIViewController * vc = [[HomeViewController alloc] init];
        _homeNav = [[UINavigationController alloc] initWithRootViewController:vc];
        _homeNav.tabBarItem.title = @"Home";
    }
    return _homeNav;
}

- (UINavigationController *)otherNav{
    if (_otherNav == nil){
        UIViewController * vc = [[OtherViewController alloc] init];
        _otherNav = [[UINavigationController alloc] initWithRootViewController:vc];
        _otherNav.tabBarItem.title = @"Other";
    }
    return _otherNav;
}

@end
