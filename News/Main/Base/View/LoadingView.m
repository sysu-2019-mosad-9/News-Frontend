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

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self addSubview:self.activityIndicatorView];
    }
    return self;
}

- (UIActivityIndicatorView *)activityIndicatorView{
    if (_activityIndicatorView == nil){
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        _activityIndicatorView.frame = self.frame;
        _activityIndicatorView.hidesWhenStopped = YES;
    }
    return _activityIndicatorView;
}

- (void)startLoading{
    [self.activityIndicatorView startAnimating];
}

- (void)stopLoading{
    [self.activityIndicatorView stopAnimating];
}

@end
