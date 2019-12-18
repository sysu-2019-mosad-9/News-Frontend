//
//  SearchViewController.m
//  News
//
//  Created by tplish on 2019/12/16.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchViewController.h"
#import "../View/NavTitleView.h"
#import "../View/TableViewCell.h"
#import "Masonry.h"

@interface SearchViewController()
<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>
{
    TableViewCell * _cell;
}
@property (nonatomic, strong) NavTitleView * navTitleView;
@property (nonatomic, strong) UISearchController * searchController;
@property (nonatomic, strong) UITableViewController * tableViewController;
//@property (nonatomic, strong) UISearchBar * searchBar;
//@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * resultArr;
@end

@implementation SearchViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.definesPresentationContext = YES;
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.titleView = self.navTitleView;
    
    [self.view addSubview:self.tableViewController.tableView];
    [self.tableViewController.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
    }];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.searchController.searchBar resignFirstResponder];
    self.searchController.active = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}



- (NSMutableArray *)dataArr{
    if (_dataArr == nil){
        _dataArr = [NSMutableArray array];
    
        for (int i=0; i<100; i++){
            NSString * str = [NSString stringWithFormat:@"%d",i];
            [_dataArr addObject:str];
        }
        
    }
    return _dataArr;
}

- (NSMutableArray *)resultArr{
    if (_resultArr == nil){
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
}

- (NavTitleView *)navTitleView{
    if (_navTitleView == nil){
        _navTitleView = [[NavTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        [_navTitleView addSubview:self.searchController.searchBar];
        [self.searchController.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(self.navTitleView);
        }];
    }
    return _navTitleView;
}

- (UISearchController *)searchController{
    if (_searchController == nil){
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self;
        
        // 搜索时模糊背景
        _searchController.obscuresBackgroundDuringPresentation = YES;
        // 搜索时隐藏导航栏
        _searchController.hidesNavigationBarDuringPresentation = NO;
        
        _searchController.searchBar.delegate = self;
        _searchController.searchBar.showsCancelButton = YES;
        
        _searchController.searchBar.showsScopeBar = YES;
        _searchController.searchBar.scopeButtonTitles = @[@"New", @"Video", @"Photo"];
        _searchController.searchBar.translucent = YES;
    }
    return _searchController;
}

- (UITableViewController *)tableViewController{
    if (_tableViewController == nil){
        _tableViewController = [[UITableViewController alloc] init];
        
        [_tableViewController.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
        
        _tableViewController.tableView.delegate = self;
        _tableViewController.tableView.dataSource = self;
        _tableViewController.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableViewController;
}

//- (UISearchBar *)searchBar{
//    if (_searchBar == nil){
//        _searchBar = [[UISearchBar alloc] init];
//        _searchBar.placeholder = @"search";
//        _searchBar.showsCancelButton = YES;
//        [_searchBar setShowsScopeBar:YES];
//        _searchBar.delegate = self;
//
//        [_searchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"News", @"Video", @"Photo", nil]];
//    }
//    return _searchBar;
//}

//- (UITableView *)tableView{
//    if (_tableView == nil){
//        _tableView = [[UITableView alloc] init];
//
//        [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
//
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    }
//    return _tableView;
//}

#pragma mark -- UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active){
        return self.resultArr.count;
    } else {
        return self.dataArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    if (self.searchController.active){
        _cell.textLabel.text = self.resultArr[indexPath.row];
    } else {
        _cell.textLabel.text = self.dataArr[indexPath.row];
    }
    return _cell;
}

#pragma mark -- UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController{
    NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController{
    NSLog(@"didPresentSearchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController{
    NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController{
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController{
    NSLog(@"presentSearchController");
}

#pragma mark -- UISearchBarDelegate

// 点击取消按钮时
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    NSLog(@"updateSearchResultsForSearchController");
    NSString * str = self.searchController.searchBar.text;
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", str];
    if (self.resultArr != nil){
        [self.resultArr removeAllObjects];
    }
    self.resultArr = [NSMutableArray arrayWithArray:[self.dataArr filteredArrayUsingPredicate:predicate]];
    [self.tableViewController.tableView reloadData];
}
//
//- (void)encodeWithCoder:(nonnull NSCoder *)coder {
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded {
//    <#code#>
//}

@end
