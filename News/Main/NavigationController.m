//
//  NavigationController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NavigationController.h"
#import "Base/Controller/UserViewController.h"

@interface NavigationController()

@end

@implementation NavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]){
        self.tabBarItem.title = rootViewController.tabBarItem.title;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
}

- (void)goToUserPage{

}

@end
