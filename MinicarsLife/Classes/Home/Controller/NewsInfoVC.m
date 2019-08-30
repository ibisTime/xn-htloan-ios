//
//  NewsInfoVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "NewsInfoVC.h"
#import "NewsModel.h"
#import "CarInfoVC.h"
@interface NewsInfoVC ()<UIWebViewDelegate>{
    UIView * view;
    UIImageView *iconImg;
    UILabel *nameLbl;
    UIButton *backBtn;
}
@property (nonatomic,strong) UIWebView * webview;
@property (nonatomic,strong) UILabel * status;
@property (nonatomic,strong) UILabel * titlelab;
@property (nonatomic,strong) UILabel * authorlab;
@property (nonatomic,strong) UILabel * timelab;
@property (nonatomic,strong) NewsModel * model;
@property (nonatomic,strong)NSArray *newstagDataAry;
@end

@implementation NewsInfoVC
-(void)getreadnum{
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630460";
    http.parameters[@"creater"]=[USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"toCode"] = self.model.code;
    http.parameters[@"toType"] = @"1";
    http.parameters[@"type"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文章";
    self.view.backgroundColor = [UIColor whiteColor];
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0, -125, SCREEN_WIDTH, 125)];
    view.backgroundColor = kWhiteColor;
    self.status = [UILabel labelWithFrame:CGRectMake(15, 21, 35, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kHexColor(@"#FF5E5E") font:Font(12) textColor:kWhiteColor];
    kViewRadius(self.status, 1);
    [view addSubview:self.status];
    
    self.titlelab = [UILabel labelWithFrame:CGRectMake(15, 23, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(18) textColor:kBlackColor];
    self.titlelab.numberOfLines = 3;
    [view addSubview:self.titlelab];
    
    self.authorlab = [UILabel labelWithFrame:CGRectMake(15, self.titlelab.yy + 20, SCREEN_WIDTH - 30 - 120, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:MainColor];
    [view addSubview:self.authorlab];
    
    self.timelab = [UILabel labelWithFrame:CGRectMake(self.authorlab.xx, self.titlelab.yy + 20, 120, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kTextColor2];
    
    [view addSubview:self.timelab];
    
    
    backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backBtn.frame = CGRectMake(0, self.timelab.yy + 10, SCREEN_WIDTH, 60);
    backBtn.hidden = YES;
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:backBtn];
 
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 1)];
    lineView.backgroundColor = kLineColor;
    [backBtn addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(15, 59, SCREEN_WIDTH - 30, 1)];
    lineView1.backgroundColor = kLineColor;
    [backBtn addSubview:lineView1];
 
    iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 40, 40)];
    iconImg.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addSubview:iconImg];
    
    nameLbl = [UILabel labelWithFrame:CGRectMake(65, 10, SCREEN_WIDTH - 30 - 65, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
    nameLbl.numberOfLines = 2;
    [backBtn addSubview:nameLbl];
    
    UIImageView *youImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 6, 24.5, 6, 11)];
    youImg.image = kImage(@"you");
    [backBtn addSubview:youImg];
    
    
    
    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight + SCREEN_HEIGHT  )];
    self.webview.scrollView.contentInset = UIEdgeInsetsMake(125, 0, 0, 0);
    self.webview.backgroundColor = kWhiteColor;
    [self.webview.scrollView addSubview:view];
    self.webview.delegate = self;
    [self.view addSubview:self.webview];
    
    //标签数据字典
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"630036";
    http.parameters[@"parentKey"] = @"car_news_tag";
    
    [http postWithSuccess:^(id responseObject) {
        //        headview.CarBrandModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        //        [self modifyFrame];
        self.newstagDataAry = responseObject[@"data"];
        
         [self getData];
    } failure:^(NSError *error) {
        
    }];
   
}





-(void)backBtnClick
{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630427";
    http.showView = self.view;
    http.parameters[@"code"] = self.model.refCarCode;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        CarInfoVC * vc = [CarInfoVC new];
        vc.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}

-(void)getData{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630456";
    http.parameters[@"code"] = self.code;
    [http postWithSuccess:^(id responseObject) {
        self.model = [NewsModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        for (int i = 0; i < _newstagDataAry.count; i ++) {
            if ([_model.tag isEqualToString:_newstagDataAry[i][@"dkey"]]) {
                self.status.text = _newstagDataAry[i][@"dvalue"];
                [self.status sizeToFit];
                self.status.frame = CGRectMake(15, 21, self.status.width + 10, 20);
            }
        }
        

        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        // 对齐方式
        style.alignment = NSTextAlignmentLeft;
        // 首行缩进
        style.firstLineHeadIndent = self.status.width + 5;
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:self.model.title attributes:@{ NSParagraphStyleAttributeName : style}];
        self.titlelab.attributedText = attrText;
        
        [self.titlelab sizeToFit];
        self.titlelab.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, self.titlelab.height);
        
        self.timelab.text = [NSString stringWithFormat:@"%@发布", [self.model.updateDatetime convertToDetailDateWithoutHour]];
        self.timelab.frame = CGRectMake(self.authorlab.xx, self.titlelab.yy + 20, 120, 20);
        
        NSString * str = [NSString stringWithFormat:@"%@", self.model.author];

        self.authorlab.text = str;
        self.authorlab.frame = CGRectMake(15, self.titlelab.yy + 20, SCREEN_WIDTH - 30  - 100, 20);
        
        
        if ([USERXX isBlankString:self.model.refCarCode] == NO) {
            backBtn.hidden = NO;
            [iconImg sd_setImageWithURL:[NSURL URLWithString:[self.model.carPic convertImageUrl]]];
            nameLbl.text = [NSString stringWithFormat:@"%@%@%@",[USERXX convertNull:self.model.refSeriesName],[USERXX convertNull:self.model.refBrandName],[USERXX convertNull:self.model.refCarName]];
            view.frame = CGRectMake(0, -(self.authorlab.yy) - 70, SCREEN_WIDTH, self.authorlab.yy + 70);
            self.webview.scrollView.contentInset = UIEdgeInsetsMake(self.authorlab.yy + 70, 0, 0, 0);
        }else
        {
            view.frame = CGRectMake(0, -(self.authorlab.yy), SCREEN_WIDTH, self.authorlab.yy);
            self.webview.scrollView.contentInset = UIEdgeInsetsMake(self.authorlab.yy, 0, 0, 0);
        }
        
        
        
        [self.webview loadHTMLString:self.model.context baseURL:nil];
        [self getreadnum];
    } failure:^(NSError *error) {
        
    }];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.webview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
    [self.webview stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#FFFFFF'"];
}

@end
