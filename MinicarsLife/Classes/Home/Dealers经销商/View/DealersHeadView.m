//
//  DealersHeadView.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/8/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "DealersHeadView.h"

@implementation DealersHeadView
{
    UIImageView *backImg;
    UILabel *nameLbl;
    UILabel *addressLbl;
    UILabel *optionsLbl;
    UILabel *dynamicLbl;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120 - 64 + kNavigationBarHeight)];
        [self addSubview:backImg];
        
//        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120 - 64 + kNavigationBarHeight)];
//        backView.backgroundColor = kHexColor(@"#000000");
//        backView.alpha = 0.5;
//        [self addSubview:backView];
        
        
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120 - 64 + kNavigationBarHeight);
        gl.startPoint = CGPointMake(0.5, 0);
        gl.endPoint = CGPointMake(0.5, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5].CGColor];
        gl.locations = @[@(0), @(1.0f)];
//        [self addSubview:gl];
//        [backImg addSubview:gl];
        [self.layer addSublayer:gl];
        
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(15, kStatusBarHeight + 9, SCREEN_WIDTH - 30 - 50, 25) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(18) textColor:kWhiteColor];
        [self addSubview:nameLbl];
        
        
        UIImageView *addressImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, nameLbl.yy + 10, 11, 13)];
        addressImg.image = kImage(@"形状结合");
        [self addSubview:addressImg];
        
        addressLbl = [UILabel labelWithFrame:CGRectMake(addressImg.xx + 2, nameLbl.yy  + 8, SCREEN_WIDTH - nameLbl.yy - 25, 17) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
        [self addSubview:addressLbl];
        
        UIView *heatView = [[UIView alloc]initWithFrame:CGRectMake(15, addressLbl.yy + 10, 102, 21)];
        heatView.backgroundColor = kHexColor(@"#000000");
        heatView.alpha = 0.5;
        kViewRadius(heatView, 10.5);
        [self addSubview:heatView];
        
        UILabel *heatLbl = [UILabel labelWithFrame:CGRectMake(25, addressLbl.yy + 13, 23, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(11) textColor:kWhiteColor];
        heatLbl.text = @"热度";
        [self addSubview:heatLbl];
        
        
        for (int i = 0; i < 5; i ++) {
            UIImageView *heatImg = [[UIImageView alloc]initWithFrame:CGRectMake(heatLbl.xx + 5 + i % 5 * 12, addressLbl.yy + 15, 9, 11)];
            heatImg.image = kImage(@"Fill 1");
            [self addSubview:heatImg];
        }
        
        UIView *optionsView = [[UIView alloc]initWithFrame:CGRectMake(heatView.xx + 10, addressLbl.yy + 10, 68, 21)];
        optionsView.backgroundColor = kHexColor(@"#000000");
        optionsView.alpha = 0.5;
        kViewRadius(optionsView, 10.5);
        [self addSubview:optionsView];
        
        optionsLbl = [UILabel labelWithFrame:CGRectMake(heatView.xx + 10, addressLbl.yy + 10, 68, 21) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(11) textColor:kWhiteColor];
        optionsLbl.text = @"车源 0";
        [self addSubview:optionsLbl];
        
        UIView *dynamicView = [[UIView alloc]initWithFrame:CGRectMake(optionsView.xx + 10, addressLbl.yy + 10, 68, 21)];
        dynamicView.backgroundColor = kHexColor(@"#000000");
        dynamicView.alpha = 0.5;
        kViewRadius(dynamicView, 10.5);
        [self addSubview:dynamicView];
        
        dynamicLbl = [UILabel labelWithFrame:CGRectMake(optionsView.xx + 10, addressLbl.yy + 10, 68, 21) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(11) textColor:kWhiteColor];
        dynamicLbl.text = @"动态 0";
        [self addSubview:dynamicLbl];
        
    }
    return self;
}

-(void)setCarsTotalCount:(NSInteger)carsTotalCount
{
    optionsLbl.text = [NSString stringWithFormat:@"车源 %ld",carsTotalCount];
}

-(void)setDealersModel:(CarModel *)dealersModel
{
    [backImg sd_setImageWithURL:[NSURL URLWithString:[dealersModel.shopBackGround convertImageUrl]]];
    nameLbl.text = dealersModel.fullName;
    addressLbl.text = dealersModel.address;
    
    
    TLNetworking * http2 = [[TLNetworking alloc]init];
//    http2.showView = self.view;
    
    http2.code = @"630455";
    http2.parameters[@"carDealerCode"] = dealersModel.code;
    http2.parameters[@"status"] = @"1";
    http2.parameters[@"start"] = @"1";
    http2.parameters[@"limit"] = @"1";
    [http2 postWithSuccess:^(id responseObject) {
        
        self.newsTotalCount = [responseObject[@"data"][@"totalCount"] integerValue];
        dynamicLbl.text = [NSString stringWithFormat:@"动态 %ld",self.newsTotalCount];
//        self.CarModelsCars = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        self.tableView.CarModelsCars = self.CarModelsCars;
//        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
