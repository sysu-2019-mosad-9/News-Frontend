//
//  VideoViewController.h
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef VideoViewController_h
#define VideoViewController_h

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoCell.h"
#import "RHPlayerView.h"

@interface VideoViewController : UIViewController
@property (nonatomic) RHPlayerView * player;
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSMutableArray<RHVideoModel *> * dataSource;

@end

#endif /* VideoViewController_h */
