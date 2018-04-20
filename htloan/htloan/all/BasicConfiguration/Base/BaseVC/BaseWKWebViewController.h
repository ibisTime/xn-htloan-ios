//
//  BaseWKWebViewController.h
//  ArtInteract
//
//  Created by JIANHUI on 16/9/26.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface BaseWKWebViewController : BaseViewController

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic , assign) CGRect webViewFrame;

@property (nonatomic, copy) NSString *titleName;

- (void)wkWebViewRequestWithURL:(NSString *)url;

@end
