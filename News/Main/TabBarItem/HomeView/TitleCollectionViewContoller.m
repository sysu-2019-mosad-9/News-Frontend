//
//  TitleCollectionViewContoller.m
//  News
//
//  Created by tplish on 2019/12/2.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TitleCollectionViewController.h"
#import "TitleCollectionViewCell.h"

@interface TitleCollectionViewController()
<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger currentIndex;
}
@end

@implementation TitleCollectionViewController

- (instancetype)init{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    if (self = [super initWithCollectionViewLayout:layout]){
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(100, 50);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        self.collectionView.backgroundColor = UIColor.clearColor;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:@"titleCollectionViewCell"];
    };
    return self;
}

- (void)updateIndex:(NSInteger)index{
    currentIndex = index;
    [self.collectionView reloadData];
}

- (void)configArray:(NSMutableArray<NSString *> *)tabs Index:(NSInteger)index Block:(ContentSwitchBlock)contentSwitch{
    _tabs = tabs;
    _contentSwitch = contentSwitch;
    [self updateIndex:index];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tabs.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TitleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCollectionViewCell" forIndexPath:indexPath];
    cell.label.text = self.tabs[indexPath.row];
    if (indexPath.row == currentIndex){
        cell.label.textColor = UIColor.orangeColor;
    } else {
        cell.label.textColor = UIColor.blackColor;
    }
    return cell;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self updateIndex:indexPath.row];
    self.contentSwitch(indexPath.row);
}

@end
