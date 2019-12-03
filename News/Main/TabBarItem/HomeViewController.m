//
//  HomeViewController.m
//  News
//
//  Created by tplish on 2019/12/2.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"
#import "HomeView/TitleCollectionViewController.h"
#import "HomeView/ContentPageViewController.h"
#import "Masonry.h"


@interface HomeViewController()
{
    NSInteger currentIndex;
}
@property (nonatomic, strong) NSMutableArray * tabs;
@property (nonatomic, strong) NSMutableArray * contents;
@property (nonatomic, strong) TitleCollectionViewController * tabCVC;
@property (nonatomic, strong) ContentPageViewController * contentPVC;

@end

@implementation HomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationItem.title = @"Home";
    
    [self.view addSubview:self.tabCVC.view];
    [self.view addSubview:self.contentPVC.view];

    [self.tabCVC configArray:self.tabs Index:0 Block:^(NSInteger index) {
        [self.contentPVC updateIndex:index];
    }];
    [self.contentPVC configArray:self.contents Index:0 Block:^(NSInteger index) {
        [self.tabCVC updateIndex:index];
    }];
    
    [self.tabCVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    [self.contentPVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tabCVC.view.mas_bottom);
        make.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}

- (NSMutableArray *)tabs{
    if (_tabs == nil){
        _tabs = [[NSMutableArray alloc] initWithCapacity:20];
        for (int i=0; i<20; i++){
            NSString * tab = [NSString stringWithFormat:@"tab%i", i];
            [_tabs addObject:tab];
        }
    }
    return _tabs;
}

- (NSMutableArray *)contents{
    if (_contents == nil){
        _contents = [[NSMutableArray alloc] initWithCapacity: 20];
        for (int i=0; i<20; i++){
            
            double r = (arc4random() % 256);
            double g = (arc4random() % 256);
            double b = (arc4random() % 256);
            
            UIViewController * con = [[UIViewController alloc] init];
            con.view.backgroundColor = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:1];
            [_contents addObject:con];
        }
    }
    return _contents;
}

- (TitleCollectionViewController *)tabCVC{
    if (_tabCVC == nil){
        _tabCVC = [[TitleCollectionViewController alloc] init];
    }
    return _tabCVC;
}

- (ContentPageViewController *)contentPVC{
    if (_contentPVC == nil){
        _contentPVC = [[ContentPageViewController alloc] init];
    }
    return _contentPVC;
}

@end
