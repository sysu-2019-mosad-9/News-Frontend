//
//  VideoViewController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoViewController.h"

#define COLLECTION_CELL_IDENTIFIER @"reuseCell"

@interface VideoViewController() <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation VideoViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    /* Set collection */
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 300);
    self.videoCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) collectionViewLayout:layout];
    [self.videoCollection registerClass:[VideoCell class] forCellWithReuseIdentifier:COLLECTION_CELL_IDENTIFIER];
    self.videoCollection.backgroundColor = UIColor.whiteColor;
    self.videoCollection.dataSource = self;
    self.videoCollection.delegate = self;
    [self.view addSubview:self.videoCollection];
}

#pragma mark - UICollectionViewDataSource
// Number of sessions, given by dataSource.length.
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    // return [self.dataSource count];
    return 5;
}

// Column of each session = 2.
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

// Set the space of collection.
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // UIEdgeInsets insets = {top, left, bottom, right};
    return UIEdgeInsetsMake(0, 0, 5, 0);
}

// Set the image of each cell.
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    VideoCell * cell = (VideoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:COLLECTION_CELL_IDENTIFIER forIndexPath:indexPath];
    // [cell setWithImage:self.dataSource[indexPath.section * 2 + indexPath.item]];
    
    return cell;
}


@end
