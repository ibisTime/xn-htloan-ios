//
//  NewsInfoVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "NewsInfoVC.h"
#import "NewsModel.h"
@interface NewsInfoVC ()
@property (nonatomic,strong) UIWebView * webview;
@property (nonatomic,strong) UILabel * status;
@property (nonatomic,strong) UILabel * titlelab;
@property (nonatomic,strong) UILabel * authorlab;
@property (nonatomic,strong) UILabel * timelab;
@property (nonatomic,strong) NewsModel * model;
@end

@implementation NewsInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文章";
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, -125, SCREEN_WIDTH, 125)];
    view.backgroundColor = kWhiteColor;
    self.status = [UILabel labelWithFrame:CGRectMake(15, 23, 35, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kHexColor(@"#FF5E5E ") font:Font(12) textColor:kWhiteColor];
    self.status.text = @"原创";
    kViewRadius(self.status, 1);
    [view addSubview:self.status];
    
    self.titlelab = [UILabel labelWithFrame:CGRectMake(15, 23, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(18) textColor:kBlackColor];
    self.timelab.text = @"       奔驰SUV 600 xDriv351 基本型 小屏 织物中东";
    self.titlelab.numberOfLines = 3;
    [view addSubview:self.titlelab];
    
    self.authorlab = [UILabel labelWithFrame:CGRectMake(15, view.height - 35, SCREEN_WIDTH - 30  - 100, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:MainColor];
    self.authorlab.text = @"作者：微车生活";
    [view addSubview:self.authorlab];
    
    self.timelab = [UILabel labelWithFrame:CGRectMake(self.authorlab.xx, view.height - 35, 100, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
    self.timelab.text = @"2019-01-11发布";
    [view addSubview:self.timelab];
    
    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarHeight + 200)];
    self.webview.scrollView.contentInset = UIEdgeInsetsMake(125, 0, 0, 0);
    [self.webview.scrollView addSubview:view];
    [self.view addSubview:self.webview];
    [self getData];
}
-(void)getData{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630456";
    http.parameters[@"code"] = self.code;
    [http postWithSuccess:^(id responseObject) {
        self.model = [NewsModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.titlelab.text = [NSString stringWithFormat:@"         %@", self.model.title];
//        self.authorlab.text = [NSString stringWithFormat:@"作者：%@", self.model.author];
        [self.titlelab sizeToFit];
        self.titlelab.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, self.titlelab.height);
        self.timelab.text = [NSString stringWithFormat:@"%@发布", [self.model.updateDatetime convertToDetailDateWithoutHour]];
        
        NSString * str = [NSString stringWithFormat:@"作者:%@", self.model.author];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:kTextColor
                        range:NSMakeRange(0, 3)];
        
     
        self.authorlab.attributedText = attrStr;
        
        [self.webview loadHTMLString:self.model.context baseURL:nil];
    } failure:^(NSError *error) {
        
    }];
}

@end
