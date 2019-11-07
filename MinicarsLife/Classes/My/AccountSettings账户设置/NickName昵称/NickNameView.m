//
//  NickNameView.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/6.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "NickNameView.h"

@implementation NickNameView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0, 23.5, self.width, 25) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(18) textColor:kBlackColor];
        nameLbl.text = @"昵称";
        [self addSubview:nameLbl];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 72.5, self.width - 30, 45)];
        backView.backgroundColor = kHexColor(@"#F5F5F5");
        kViewBorderRadius(backView, 2, 0.5, kHexColor(@"#CCCCCC"));
        [self addSubview:backView];
        
        UITextField *roomNumberTF = [[UITextField alloc]initWithFrame:CGRectMake(14, 0, self.width - 60, 45)];
        roomNumberTF.placeholder = @"请输入昵称";
        [roomNumberTF setValue:Font(14) forKeyPath:@"_placeholderLabel.font"];
        roomNumberTF.font = Font(14);
        _roomNumberTF = roomNumberTF;
        [backView addSubview:roomNumberTF];
        
        UIButton *cancelBtn = [UIButton buttonWithTitle:@"取消" titleColor:kHexColor(@"#666666") backgroundColor:kHexColor(@"#F0F0F0") titleFont:16];
        cancelBtn.frame = CGRectMake(0, 207 - 50, self.width/2, 50);
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:cancelBtn];
        
        UIButton *confirmBtn = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kHexColor(@"#F89C44") titleFont:16];
        confirmBtn.frame = CGRectMake(self.width/2, 207 - 50, self.width/2, 50);
        _confirmBtn = confirmBtn;
        [self addSubview:confirmBtn];
        
    }
    return self;
}

-(void)cancelBtnClick
{
    [[USERXX user].cusPopView dismiss];
    
}

@end
