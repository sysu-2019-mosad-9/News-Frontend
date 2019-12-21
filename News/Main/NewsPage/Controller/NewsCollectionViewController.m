//
//  NewsCollectionViewController.m
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsCollectionViewController.h"

// 新闻页控件和数据
#import "../View/NewsCollectionViewCell.h"
#import "../Model/NewsModel.h"

// 新闻详情页
#import "NewsDetailViewController.h"

#import "Base/GlobalVariable.h"
#import "Base/NetRequest.h"

#import "MJRefresh.h"

@interface NewsCollectionViewController()
<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    NewsCollectionViewCell * _cell;
}
@property (nonatomic, strong) NSMutableArray * newsBlock;
@property (nonatomic, strong) NSMutableArray * tempBlock;
@property (nonatomic, strong) NSMutableDictionary * imgDict;
@property (nonatomic, strong) NSOperationQueue * queue;
@end

@implementation NewsCollectionViewController

- (instancetype)init{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self){
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        self.collectionView.backgroundColor = UIColor.clearColor;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[NewsCollectionViewCell class] forCellWithReuseIdentifier:@"newsCollectionViewCell"];
    };
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"mj_header");
        
        [self refreshTempBlock];
        for (int i=0; i<self.tempBlock.count; i++){
            [self.newsBlock insertObject:self.tempBlock[i] atIndex:0];
        }

        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
        
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        NSLog(@"mj_footer");
        
        [self refreshTempBlock];
        for (int i=0; i<self.tempBlock.count; i++){
            [self.newsBlock addObject:self.tempBlock[i]];
        }
        
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
}

- (NSMutableArray *)newsBlock{
    if (_newsBlock == nil){
        _newsBlock = [NSMutableArray array];
    }
    return _newsBlock;
}

- (NSMutableArray *)tempBlock{
    if (_tempBlock == nil){
        _tempBlock = [NSMutableArray array];
    }
    return _tempBlock;
}

- (void)refreshTempBlock{
    [self.tempBlock removeAllObjects];
    
    NSString * url = [BaseIP stringByAppendingFormat:@"/api/v1/news/%ld/entries", (long)self.tabID];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:2] forKey:@"count"];
    [params setObject:[NSNumber numberWithInt:1] forKey:@"img_most"];
    
    NSLog(@"%@",url);
    [[NetRequest shareInstance] SynGET:url params:params progress:^(id downloadProgress) {
    } success:^(id responseObject) {
        NSNumber * count = [responseObject objectForKey:@"count"];
        NSArray * data = [responseObject objectForKey:@"data"];
        for (int i=0; i<[count intValue]; i++){
            NewsModel * model = [[NewsModel alloc] initWithDict:data[i]];
            [self.tempBlock addObject:model];
        }
    } failues:^(id error) {
    }];
}

- (NSMutableDictionary *)imgDict{
    if (_imgDict == nil){
        _imgDict = [NSMutableDictionary dictionary];
    }
    return _imgDict;
}

- (NSOperationQueue *)queue{
    if (_queue == nil){
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (void)downloadImg:(NSString*)url{
    if ([self.imgDict objectForKey:url])return;
    
    NSString * cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    __block NSString * cacheImgPath = [cacheDir stringByAppendingFormat:@"/%@", [[url lastPathComponent] stringByDeletingPathExtension]];
    __block UIImage * cacheImg = [UIImage imageWithContentsOfFile:cacheImgPath];
    if (cacheImg != nil){
        [self.imgDict setObject:cacheImg forKey:url];
        return;
    }
    
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        NSURL * nsurl = [NSURL URLWithString:url];
        NSData * data = [NSData dataWithContentsOfURL:nsurl];
        cacheImg = [UIImage imageWithData:data];
        
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            [self.imgDict setObject:cacheImg forKey:url];
            NSFileManager * fileManager = [NSFileManager defaultManager];
            [fileManager createFileAtPath:cacheImgPath contents:nil attributes:nil];
            [UIImagePNGRepresentation(cacheImg) writeToFile:cacheImgPath atomically:YES];

            [self.collectionView reloadData];
        }];
    }];
    
    [self.queue addOperation:operation];
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.newsBlock.count;
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    _cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newsCollectionViewCell" forIndexPath:indexPath];
    
    [self downloadImg:[self.newsBlock[indexPath.row] imageLinks][0]];
    
    _cell.label.text = [self.newsBlock[indexPath.row] title];
    _cell.imageView.image = [UIImage imageNamed:@"loading"];
    UIImage * image = [self.imgDict objectForKey:[self.newsBlock[indexPath.row] imageLinks][0]];
    if (image != nil) _cell.imageView.image = image;
    
    return _cell;
}

#pragma mark UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width - 20, 200);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select");
    NewsDetailViewController * detailVC = [[NewsDetailViewController alloc] init];
    detailVC.detailUrl = [self.newsBlock[indexPath.row] detailUrl];
    detailVC.curNav = self.curNav;
    [self.curNav pushViewController:detailVC animated:YES];
}

@end
