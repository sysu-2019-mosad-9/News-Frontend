//
//  VideoViewController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoViewController.h"

@interface VideoViewController()

@end

@implementation VideoViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"video";

    [self.view addSubview:label];
}

@end
