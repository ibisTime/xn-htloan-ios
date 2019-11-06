//
//  ApplicationCell.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/6.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ApplicationCell.h"

@implementation ApplicationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 220)];
        backView.layer.cornerRadius=4;
        backView.layer.shadowOpacity = 0.22;// 阴影透明度
        backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        backView.layer.shadowRadius=3;// 阴影扩散的范围控制
        backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        [self addSubview:backView];
        
        UILabel *codeLbl = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 100 - 60, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
        codeLbl.text = @"订单编号：8890382090";
        [backView addSubview:codeLbl];
        
        UILabel *statusLbl = [UILabel labelWithFrame:CGRectMake(codeLbl.xx , 15, 100, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#F84444")];
        statusLbl.text = @"申请失败";
        [backView addSubview:statusLbl];
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 45.5, 110, 82.5)];
        iconImg.image = kImage(@"");
        [backView addSubview:iconImg];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 9, 48.5, SCREEN_WIDTH - iconImg.xx -  9 - 60, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kBlackColor];
        [self addSubview:nameLbl];
        
        
        UILabel *allPriceLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 9, 108.5, SCREEN_WIDTH - iconImg.xx -  9 - 60, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        [self addSubview:allPriceLbl];
        
        UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(15, iconImg.yy + 17.5, SCREEN_WIDTH/2 - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        [self addSubview:timeLbl];
        
        UILabel *paymentLbl = [UILabel labelWithFrame:CGRectMake(timeLbl.xx, iconImg.yy + 17.5, SCREEN_WIDTH/2 - 30, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        [self addSubview:paymentLbl];
        
        UILabel *label2 = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 15 - 96, iconImg.yy + 45, 96, 23) textAligment:(NSTextAlignmentCenter) backgroundColor:RGB(253, 246, 237) font:Font(12) textColor:kHexColor(@"#F89C44")];
        kViewRadius(label2, 11.5);
        label2.text = @"多花：1820元";
        [label2 sizeToFit];
        label2.frame = CGRectMake(SCREEN_WIDTH - 30 - 15 - label2.width, iconImg.yy + 45, label2.width + 20, 23);
        [self addSubview:label2];
        
        UILabel *label1 = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 15 - 96, iconImg.yy + 45, 96, 23) textAligment:(NSTextAlignmentCenter) backgroundColor:RGB(253, 246, 237) font:Font(12) textColor:kHexColor(@"#F89C44")];
        kViewRadius(label1, 11.5);
        label1.text = @"多花：1820元";
        [label1 sizeToFit];
        label1.frame = CGRectMake(SCREEN_WIDTH - 30 - 15 - label2.width - 10 - label1.width - 20, iconImg.yy + 45, label1.width + 20, 23);
        [self addSubview:label1];
        
    }
    return self;
}

@end
