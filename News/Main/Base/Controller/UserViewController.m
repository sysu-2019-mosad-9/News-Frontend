//
//  UserViewController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserViewController.h"

@interface UserViewController()

@end

@implementation UserViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"user";

    [self.view addSubview:label];
}

@end
