//
//  PhotoViewController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoViewController.h"

@interface PhotoViewController() <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation PhotoViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"photo";

    [self.view addSubview:label];
}

@end
