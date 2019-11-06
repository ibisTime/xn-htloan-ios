//
//  TelephoneView.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/5.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TelephoneView.h"

@implementation TelephoneView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 41, 300, 187)];
        backView.backgroundColor = kWhiteColor;
        kViewRadius(backView, 8);
        [self addSubview:backView];
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(150 - 41, 0, 82, 82)];
        iconImg.image = kImage(@"客服电话");
        [self addSubview:iconImg];
        
        UILabel *lbl = [UILabel labelWithFrame:CGRectMake(0, 66.5, 300, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(16) textColor:kBlackColor];
        lbl.text = @"客服电话：400-8888-666";
        [backView addSubview:lbl];
        
        UIButton *cancelBtn = [UIButton buttonWithTitle:@"取消" titleColor:kHexColor(@"#666666") backgroundColor:kHexColor(@"#F0F0F0") titleFont:16];
        cancelBtn.frame = CGRectMake(0, 137, self.width/2, 50);
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [backView addSubview:cancelBtn];
        
        UIButton *confirmBtn = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kHexColor(@"#F89C44") titleFont:16];
        confirmBtn.frame = CGRectMake(self.width/2, 137, self.width/2, 50);
        _confirmBtn = confirmBtn;
        [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [backView addSubview:confirmBtn];
        
        
    }
    return self;
}

-(void)cancelBtnClick
{
    [[USERXX user].cusPopView dismiss];
}

-(void)confirmBtnClick
{
    [[USERXX user].cusPopView dismiss];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",@"4008888666"]]];
}

@end
