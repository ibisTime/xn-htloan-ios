//
//  AskSuccessView.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/18.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "AskSuccessView.h"

@implementation AskSuccessView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - ((718.00/1334.00)*SCREEN_HEIGHT), SCREEN_WIDTH, (718.00/1334.00)*SCREEN_HEIGHT)];
        view.backgroundColor= kWhiteColor;
        
        UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [deleteBtn setImage:kImage(@"弹窗-关闭") forState:(UIControlStateNormal)];
        deleteBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 0, 50, 50);
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:deleteBtn];
        
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 65)/2, 83, 65, 65)];
        image.image = kImage(@"询价成功");
        [view addSubview:image];
        
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, image.yy + 17.5, SCREEN_WIDTH - 30, 25) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(18) textColor:kHexColor(@"#F56B6B")];
        label.text = @"询价成功";
        [view addSubview:label];
        
        UILabel * label1 = [UILabel labelWithFrame:CGRectMake(15, label.yy + 5, SCREEN_WIDTH - 30, 25) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kTextColor3];
        label1.text = @"经营商将及时给您回电";
        [view addSubview:label1];
        
        UIButton * askbtn = [UIButton buttonWithTitle:@"返回首页" titleColor:kWhiteColor backgroundColor:MainColor titleFont:16 cornerRadius:2];
        askbtn.frame = CGRectMake(15, label1.yy + 86, SCREEN_WIDTH - 30, 44);
        [askbtn addTarget:self action:@selector(clickask) forControlEvents:(UIControlEventTouchUpInside)];
        
        [view addSubview:askbtn];
        [self addSubview:view];
    }
    return self;
}
-(void)clickask{
    if (self.delegate) {
        [self.delegate BackToHomeClick];
    }
}
-(void)deleteBtnClick
{
    [[USERXX user].cusPopView dismiss];
}
@end
