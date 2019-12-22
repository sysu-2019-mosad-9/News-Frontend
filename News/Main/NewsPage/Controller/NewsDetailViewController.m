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
@property (nonatomic, strong) NewsDetailModel * model;
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
        WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc] init];
        
        WKPreferences * preferences = [[WKPreferences alloc] init];
        
        preferences.javaScriptCanOpenWindowsAutomatically = true;
        
        NSString * jsPic = @"var objs = document.getElementsByTagName('img');for(var i=0;i++){var img = objs[i];img.style.maxWidth = '100%';img.style.height='auto';}";

        WKUserScript * usPic = [[WKUserScript alloc] initWithSource:jsPic injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        
//        NSString * jsWord = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
//        WKUserScript * usWord = [[WKUserScript alloc] initWithSource:jsWord injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        
        WKUserContentController * controller = [[WKUserContentController alloc] init];
        [controller addUserScript:usPic];
//        [controller addUserScript:usWord];
        configuration.userContentController = controller;
        configuration.preferences = preferences;
        
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) configuration:configuration];
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
        
        
        _html = [_html stringByAppendingFormat:@"<h1>%@</h1><hr>", self.model.title];
        _html = [_html stringByAppendingString:self.model.body];
        
//        _html = [_html stringByAppendingFormat:@"<h1>%@</h1><hr>", self.title];
        
//        for (int i=0; i<self.data.count; i++){
//            NewsDetailModel * model = [[NewsDetailModel alloc] initWithDict:self.data[i]];
//            if ([model.type  isEqual: @"typography"]){
//                _html = [_html stringByAppendingFormat:@"<p>%@</p>", model.content];
//            } else if ([model.type isEqual:@"image"]){
//                _html = [_html stringByAppendingFormat:@"<img style='width:auto;height:auto; max-width:100%%' src='%@'>", model.content];
//            }
//        }
        _html = [_html stringByAppendingString:@"</body>\n"];
        _html = [_html stringByAppendingString:@"</html>\n"];
    }
    return _html;
}

- (NewsDetailModel *)model{
    if (_model == nil){
        [[NetRequest shareInstance] SynGET:[BaseIP stringByAppendingFormat:@":8000%@", self.detailUrl] params:nil progress:^(id downloadProgress) {
        } success:^(id responseObject) {
            NSLog(@"%@", responseObject);
            self->_model = [[NewsDetailModel alloc] initWithDict:responseObject];
        } failues:^(id error) {
        }];
    }
    return _model;
}

@end
