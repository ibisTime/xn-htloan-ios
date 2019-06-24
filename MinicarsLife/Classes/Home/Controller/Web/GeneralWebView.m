//
//  GeneralWebView.m
//  Coin
//
//  Created by 郑勤宝 on 2018/12/6.
//  Copyright © 2018 chengdai. All rights reserved.
//

#import "GeneralWebView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WYWebProgressLayer.h"
#import "UIView+Frame.h"
#import "WLWebProgressLayer.h"
#import "NSURLRequest+NSURLRequestSSLY.h"
//@implementation NSURLRequest (NSURLRequestWithIgnoreSSL)

@interface GeneralWebView ()<UIWebViewDelegate,NSURLConnectionDelegate>
{
    WYWebProgressLayer *_progressLayer; // 网页加载进度条
    UILabel *nameLable;
    
}

@property (nonatomic,strong) JSContext *jsContext;
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation GeneralWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, -kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backView.backgroundColor = kWhiteColor;
    [self.view addSubview:backView];
    
    nameLable = [[UILabel alloc]initWithFrame:CGRectMake(54, kStatusBarHeight, kScreenWidth - 108, 44)];
//    nameLable.text = [LangSwitcher switchLang:@"攻略" key:nil];
    nameLable.textAlignment = NSTextAlignmentCenter;
    nameLable.font = Font(16);
    nameLable.textColor = kWhiteColor;
    nameLable.text = self.name;
    self.navigationItem.titleView = nameLable;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 2)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_URL]]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemRefresh) target:self action:@selector(rightBtnClick)];
    

}




#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    _progressLayer = [WYWebProgressLayer layerWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
    
    [self.view.layer addSublayer:_progressLayer];
    [_progressLayer startLoad];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressLayer finishedLoad];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_progressLayer finishedLoad];
//    nameLable.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}


-(void)rightBtnClick
{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_URL]]];
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_URL]]]];
}

@end
