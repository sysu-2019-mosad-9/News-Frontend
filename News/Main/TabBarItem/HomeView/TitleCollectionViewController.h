//
//  TitleCollectionViewController.h
//  News
//
//  Created by tplish on 2019/12/2.
//  Copyright © 2019 Team09. All rights reserved.
//

#ifndef TitleCollectionViewController_h
#define TitleCollectionViewController_h

#import <UIKit/UIKit.h>

typedef void(^ContentSwitchBlock)(NSInteger index);

@interface TitleCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSArray<NSString *> * tabs;
@property (nonatomic, strong) ContentSwitchBlock contentSwitch;
- (void)updateIndex:(NSInteger)index;
- (void) configArray:(NSMutableArray<NSString *> *)tabs Index:(NSInteger)index Block:(ContentSwitchBlock)contentSwitch;

@end

#endif /* TitleCollectionViewController_h */
