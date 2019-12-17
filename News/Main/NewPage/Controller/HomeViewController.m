//
//  HomeViewController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"
#import "../../Base/Controller/DownloadViewController.h"
#import "../View/TitleView.h"
#import "SearchViewController.h"
#import "Masonry.h"

@interface HomeViewController()
@property (nonatomic, strong) UIView * titleView;
@property (nonatomic, strong) UIBarButtonItem * rightBarBtnItem;
@end

@implementation HomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.titleView;
    
    self.navigationItem.rightBarButtonItem = self.rightBarBtnItem;
    
    NSLog(@"%@",NSStringFromCGRect(self.titleView.frame));

}

- (UIView *)titleView{
    if (_titleView == nil){
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToSearchPage)];
        _titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        _titleView.userInteractionEnabled = YES;
        [_titleView addGestureRecognizer:tap];
        
        UISearchBar * bar = [[UISearchBar alloc] init];
        bar.userInteractionEnabled = NO;
        [_titleView addSubview:bar];
        
        [bar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.width.height.mas_equalTo(self.titleView);
        }];
    }
    return _titleView;
}

- (UIBarButtonItem *)rightBarBtnItem{
    if (_rightBarBtnItem == nil){
        _rightBarBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_tab"] style:UIBarButtonItemStyleDone target:self action:@selector(goToDownloadPage)];
    }
    return _rightBarBtnItem;
}

- (void)goToSearchPage{
    [self.navigationController pushViewController:[[SearchViewController alloc] init] animated:YES];
}

- (void)goToDownloadPage{
    [self.navigationController pushViewController:[[DownloadViewController alloc] init] animated:YES];
}

@end
