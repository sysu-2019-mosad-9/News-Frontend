//
//  DownloadViewController.m
//  News
//
//  Created by tplish on 2019/12/16.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadViewController.h"

@interface DownloadViewController()

@end

@implementation DownloadViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"download";

    [self.view addSubview:label];
}

@end
