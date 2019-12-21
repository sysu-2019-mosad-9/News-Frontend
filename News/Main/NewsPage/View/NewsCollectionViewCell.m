//
//  NewsCollectionViewCell.m
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsCollectionViewCell.h"
#import "Masonry.h"

@interface NewsCollectionViewCell()

@end

@implementation NewsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.imageView];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.mas_equalTo(self.contentView);
            make.height.mas_equalTo(50);
        }];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(150);
        }];
        
        self.contentView.backgroundColor = UIColor.greenColor;
    }
    return self;
}

- (UILabel *)label{
    if (_label == nil){
        _label = [[UILabel alloc] init];
        _label.font = [UIFont fontWithName:@"System" size:24];
        _label.textColor = UIColor.blackColor;
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (UIImageView *)imageView{
    if (_imageView == nil){
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = UIColor.whiteColor;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}




@end
