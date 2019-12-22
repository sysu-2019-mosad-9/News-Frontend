//
//  NewsDetailViewController.m
//  News
//
//  Created by tplish on 2019/12/18.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsDetailViewController.h"
#import <WebKit/WebKit.h>

#import "../Model/NewsDetailModel.h"

#import "Base/GlobalVariable.h"
#import "Base/NetRequest.h"

#import "Masonry.h"

@interface NewsDetailViewController()
@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) NSString * html;
@property (nonatomic, strong) NSArray * data;
@end

@implementation NewsDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UINavigationController * nav = [UINavigationController new];
    
    self.navigationItem.titleView = nav.navigationItem.titleView;
    self.navigationItem.title = @"News";
    
    [self.view addSubview:self.webView];
    
    [self.webView loadHTMLString:self.html baseURL:nil];
}

- (WKWebView *)webView{
    if (_webView == nil){
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _webView;
}

- (NSString *)html{
    if (_html == nil){
        _html = @"";
        _html = [_html stringByAppendingString:@"<!DOCTYPE html>"];
        _html = [_html stringByAppendingString:@"<html>"];
        _html = [_html stringByAppendingString:@"<head>"];
        _html = [_html stringByAppendingString:@"<meta charset='UTF-8' />"];
        _html = [_html stringByAppendingString:@"<meta name='viewport'content='width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no' />"];
        _html = [_html stringByAppendingString:@"</head>"];
        _html = [_html stringByAppendingString:@"<body>"];
        _html = [_html stringByAppendingFormat:@"<h1>%@</h1><hr>", self.title];
        
        for (int i=0; i<self.data.count; i++){
            NewsDetailModel * model = [[NewsDetailModel alloc] initWithDict:self.data[i]];
            if ([model.type  isEqual: @"typography"]){
                _html = [_html stringByAppendingFormat:@"<p>%@</p>", model.content];
            } else if ([model.type isEqual:@"image"]){
                _html = [_html stringByAppendingFormat:@"<img style='width:auto;height:auto; max-width:100%%' src='%@'>", model.content];
            }
        }
        _html = [_html stringByAppendingString:@"</body>\n"];
        _html = [_html stringByAppendingString:@"</html>\n"];
    }
    return _html;
}

- (NSArray *)data{
    if (_data == nil){
        _data = [NSArray array];
        [[NetRequest shareInstance] SynGET:[PublicIP stringByAppendingFormat:@":8000%@", self.detailUrl] params:nil progress:^(id downloadProgress) {
        } success:^(id responseObject) {
            NSLog(@"%@", responseObject);
//            NSNumber * count = [responseObject objectForKey:@"count"];
            self->_data = [responseObject objectForKey:@"data"];
        } failues:^(id error) {
        }];
    }
    return _data;
}

@end
