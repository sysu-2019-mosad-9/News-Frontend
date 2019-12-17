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
@property (nonatomic, strong) UIViewController * rootVC;
@end

@implementation NavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]){
        _rootVC = rootViewController;
        _rootVC.edgesForExtendedLayout = UIRectEdgeNone;
        _rootVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_tab"] style:UIBarButtonItemStyleDone target:self action:@selector(goToUserPage)];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    

}

- (void)goToUserPage{
    [_rootVC.navigationController pushViewController:[UserViewController shareInstance] animated:YES];
}

@end
