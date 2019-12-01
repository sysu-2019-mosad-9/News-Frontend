//
//  NavigationController.m
//  News
//
//  Created by tplish on 2019/11/27.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NavigationController.h"

@interface NavigationController()

@end

@implementation NavigationController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIViewController * vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = UIColor.grayColor;
    [self addChildViewController:vc];
}

@end
