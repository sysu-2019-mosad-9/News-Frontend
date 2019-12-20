//
//  VideoViewController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import <Foundation/Foundation.h>
#import "VideoViewController.h"
#import "AFNetworking.h"
#import "Masonry.h"


#define COLLECTION_CELL_IDENTIFIER @"reuseCell"
#define MAX_VEDIO 10


@interface VideoViewController() <RHPlayerViewDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // [self addSubViews];
    [self downloadVideoWithCount];
    // [self loadData];
    [self addSubViews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        [self.player stop];
    }
}

- (void)downloadVideoWithCount {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString * URL = @"http://localhost:8000/api/v1/video/entries?";
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"count"] = [NSString stringWithFormat:@"%d", MAX_VEDIO];
    // _dataSource = [NSMutableArray arrayWithCapacity:count];

    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    dispatch_queue_t downloadQueue = dispatch_queue_create("download.images", NULL);
    dispatch_async(downloadQueue, ^{
        
        [manager GET:URL
          parameters:params
            progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            for (int i = 0; i < MAX_VEDIO; i++) {
                RHVideoModel * model = [[RHVideoModel alloc] initWithVideoId:[NSString stringWithFormat:@"%03d", i + 1] title:responseObject[@"data"][i][@"title"] url:responseObject[@"data"][i][@"video_link"] currentTime:0];
                self.dataSource[i] = model;
            }
            NSLog(@"Download Complete! Total video = %ld", [self.dataSource count]);
            dispatch_semaphore_signal(sema);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Connect to website fail, error = %@", error);
            dispatch_semaphore_signal(sema);
        }];
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Finish, total video = %ld", [self.dataSource count]);
            [self.player setVideoModels:self.dataSource playVideoId:@""];
            [self.tableView reloadData];
        });
    });
    
//    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    NSLog(@"Finish, total video = %ld", [self.dataSource count]);
    [self.player setVideoModels:self.dataSource playVideoId:@""];
    [self.tableView reloadData];
}

- (void)loadData {

    NSArray * titleArr = @[@"视频一", @"视频二", @"视频三", @"视频四"];
    NSArray * urlArr = @[@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4", @"http://mirror.aarnet.edu.au/pub/TED-talks/911Mothers_2010W-480p.mp4", @"https://qiniu-vmovier10.vmoviercdn.com/597688f5df943.mp4",
    @"https://qiniu-vmovier10.vmoviercdn.com/597688f5df943.mp4"];

    for (int i = 0; i < titleArr.count; i++) {

        RHVideoModel * model = [[RHVideoModel alloc] initWithVideoId:[NSString stringWithFormat:@"%03d", i + 1] title:titleArr[i] url:urlArr[i] currentTime:0];
        [self.dataSource addObject:model];
        for (int i = 0; i < [self.dataSource count]; i++) {
            NSLog(@"%@", self.dataSource[i]);
        }
    }
    [self.player setVideoModels:self.dataSource playVideoId:@""];
    [self.tableView reloadData];
}

- (void)addSubViews {
    UIView * superview = self.view;
    [superview addSubview:_tableView];
    [superview addSubview:_player];
    [self setupLayout];
}

- (void)setupLayout {
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(9 * [[UIScreen mainScreen] bounds].size.width / 16));
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Hello World");
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:COLLECTION_CELL_IDENTIFIER];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < [_dataSource count]) {
        
        RHVideoModel * model = _dataSource[indexPath.row];
        cell.textLabel.text = model.title;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RHVideoModel * model = _dataSource[indexPath.row];
    [_player playVideoWithVideoId:model.videoId];
}

#pragma mark - playerViewDelegate
- (BOOL)playerViewShouldPlay {
    return YES;
}

- (void)playerView:(RHPlayerView *)playView didPlayVideo:(RHVideoModel *)videoModel index:(NSInteger)index {
}

- (void)playerView:(RHPlayerView *)playView didPlayEndVideo:(RHVideoModel *)videoModel index:(NSInteger)index {
}

- (void)playerView:(RHPlayerView *)playView didPlayVideo:(RHVideoModel *)videoModel playTime:(NSTimeInterval)playTime {
}

#pragma mark - setterAndGetter
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UITableView * tableView = [[UITableView alloc] init];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:COLLECTION_CELL_IDENTIFIER];
        tableView.tableFooterView = [[UIView alloc] init];
        _tableView = tableView;
    }
    return _tableView;
}

- (RHPlayerView *)player {
    if (!_player) {
        _player = [[RHPlayerView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 9 * [[UIScreen mainScreen] bounds].size.width / 16) currentVC:self];
        _player.delegate = self;
    }
    return _player;
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:MAX_VEDIO];
    }
    return _dataSource;
}

@end
