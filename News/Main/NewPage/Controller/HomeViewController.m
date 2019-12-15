//
//  HomeViewController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"

@interface HomeViewController()

@end

@implementation HomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"home";

    [self.view addSubview:label];
}

@end
