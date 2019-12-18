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

@interface VideoViewController : UIViewController

@property (strong, nonatomic) UICollectionView * videoCollection;
@property (strong, nonatomic) NSMutableArray<AVPlayer *> * dataSource;

@end

#endif /* VideoViewController_h */
