//
//  CallNowView.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CallNowView.h"

@implementation CallNowView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - ((718.00/1334.00)*SCREEN_HEIGHT), SCREEN_WIDTH, (718.00/1334.00)*SCREEN_HEIGHT)];
        view.backgroundColor = kWhiteColor;
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, 16, 65, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(15) textColor:kBlackColor];
        label.text = @"询价信息";
        [view addSubview:label];
        
        UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [deleteBtn setImage:kImage(@"弹窗-关闭") forState:(UIControlStateNormal)];
        deleteBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 0, 50, 50);
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:deleteBtn];
        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 54.5, 110, 82.5)];
        [view addSubview:img];
        img.image = kImage(@"1");
        self.image = img;
        
        UILabel * title = [UILabel labelWithFrame:CGRectMake(img.xx + 15, 54, SCREEN_WIDTH - 155, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        title.text = @"奔驰SUV 600 xDriv351 基本型 小屏 织物中东";
        title.numberOfLines = 2;
        [view addSubview:title];
        self.titlelab = title;
        
        UILabel * describe = [UILabel labelWithFrame:CGRectMake(img.xx + 15, title.yy + 5, SCREEN_WIDTH - 120, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor3];
        describe.text = @"中大型SUV 白/米 车在杭州市";
        [view addSubview:describe];
        self.describdlab = describe;
        
        UILabel * time = [UILabel labelWithFrame:CGRectMake(img.xx + 15, describe.yy + 5, 74, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor3];
        time.text = @"2019-03-11";
        [view addSubview:time];
        self.timelab = time;
        
        UILabel * money = [UILabel labelWithFrame:CGRectMake(time.xx + 15, describe.yy + 5, SCREEN_WIDTH - 15 - 15 - time.xx, 22.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#028EFF")];
        money.text = @"54.9万";
        [view addSubview:money];
        self.moneylab = money;
        
        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(15, img.yy + 10, SCREEN_WIDTH - 30, 50)];
        UILabel * content = [UILabel labelWithFrame:CGRectMake(7.5, 8.5, view1.width - 15, 33) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
        content.numberOfLines = 2;
        content.text = @"底挂，2气，6速，冰箱，7座，铝踏，拖钩，中差，18铝，智能卡，主驾电座，前后雾灯，一键启动";
        view1.backgroundColor = kHexColor(@"#F5F5F5");
        [view1 addSubview:content];
        [view addSubview:view1];
        self.view = view1;
        self.contentlab = content;
        
        
        UILabel * phonelab = [UILabel labelWithFrame:CGRectMake(22.5, view1.yy + 12.5, 45, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        phonelab.text = @"手机号";
        [view addSubview:phonelab];
        
        UILabel * phone = [UILabel labelWithFrame:CGRectMake(phonelab.xx + 33.5, view1.yy + 12.5, 94, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        phone.text = @"15035948890";
        [view addSubview:phone];
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, phone.yy + 12.5, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        [view addSubview:v1];
        
        
        
        UILabel * namelab = [UILabel labelWithFrame:CGRectMake(22.5, v1.yy + 12.5, 45, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        namelab.text = @"姓名";
        [view addSubview:namelab];
        
        UILabel * name = [UILabel labelWithFrame:CGRectMake(namelab.xx + 33.5, v1.yy + 12.5, 94, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        name.text = @"王大锤";
        [view addSubview:name];
        
        UIView * v2 = [[UIView alloc]initWithFrame:CGRectMake(15, namelab.yy + 12.5, SCREEN_WIDTH - 30, 1)];
        v2.backgroundColor = kLineColor;
        [view addSubview:v2];
        
        
        UIButton * askbtn = [UIButton buttonWithTitle:@"立即询价" titleColor:kWhiteColor backgroundColor:MainColor titleFont:16 cornerRadius:2];
        askbtn.frame = CGRectMake(15, v2.yy + 14, SCREEN_WIDTH - 30, 44);
        [askbtn addTarget:self action:@selector(clickask) forControlEvents:(UIControlEventTouchUpInside)];
        
        [view addSubview:askbtn];
        
        [self addSubview:view];
    }
    return self;
}
-(void)clickask{
    if (self.delegate) {
        [self.delegate askmoney];
    }
}
-(void)deleteBtnClick
{
    [[USERXX user].cusPopView dismiss];
}
@end
