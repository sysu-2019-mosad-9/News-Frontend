//
//  LoadingView.m
//  News
//
//  Created by tplish on 2019/12/20.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadingView.h"
#import "Masonry.h"

@interface LoadingView()

@property (nonatomic, strong) UIActivityIndicatorView * activityIndicatorView;

@property (nonatomic, strong) UILabel * tip;

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.userInteractionEnabled = YES;
        
        [self activityIndicatorView];
        
        [self tip];
    }
    return self;
}

- (UIActivityIndicatorView *)activityIndicatorView{
    if (_activityIndicatorView == nil){
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        _activityIndicatorView.hidesWhenStopped = YES;
        _activityIndicatorView.userInteractionEnabled = YES;
        [self addSubview:_activityIndicatorView];
        [_activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
    }
    return _activityIndicatorView;
}

- (UILabel *)tip{
    if (_tip == nil){
        _tip = [[UILabel alloc] init];
        _tip.text = @"点击重试";
        _tip.textColor = UIColor.blackColor;
        _tip.hidden = YES;
        [self addSubview:_tip];
        [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.activityIndicatorView).mas_offset(200);
            make.width.mas_equalTo(100);
            make.height.mas_offset(50);
        }];
    }
    return _tip;
}

- (BOOL)isAnimating{
    return self.activityIndicatorView.isAnimating;
}

- (void)startLoading{
    [self.activityIndicatorView startAnimating];
    self.tip.hidden = YES;
}

- (void)stopLoading{
    [self.activityIndicatorView stopAnimating];
    self.tip.hidden = NO;
}


@end
