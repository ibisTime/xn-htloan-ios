//
//  ApplicationCell.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/6.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ApplicationCell.h"

@implementation ApplicationCell
{
    UILabel *codeLbl;
    UILabel *statusLbl;
    UIImageView *iconImg;
    UILabel *nameLbl;
    UILabel *allPriceLbl;
    UILabel *timeLbl;
    UILabel *paymentLbl;
    UILabel *label2;
    UILabel *label1;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kHexColor(@"#FAFAFA");
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 220)];
        backView.layer.cornerRadius=4;
        backView.layer.shadowOpacity = 0.22;// 阴影透明度
        backView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        backView.layer.shadowRadius=3;// 阴影扩散的范围控制
        backView.layer.shadowOffset = CGSizeMake(1, 1);// 阴
        backView.backgroundColor = kWhiteColor;
        [self addSubview:backView];
        
        codeLbl = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 100 - 60, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
        codeLbl.text = @"订单编号：8890382090";
        [backView addSubview:codeLbl];
        
        
        statusLbl = [UILabel labelWithFrame:CGRectMake(codeLbl.xx , 15, 100, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#F84444")];
        statusLbl.text = @"申请失败";
        [backView addSubview:statusLbl];
        
        iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 45.5, 110, 82.5)];
        iconImg.image = kImage(@"");
        kViewRadius(iconImg, 4);
        [backView addSubview:iconImg];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 9, 48.5, SCREEN_WIDTH - iconImg.xx -  9 - 60, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kBlackColor];
        nameLbl.numberOfLines = 2;
        [backView addSubview:nameLbl];
        
        
        allPriceLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 9, 108.5, SCREEN_WIDTH - iconImg.xx -  9 - 60, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        [backView addSubview:allPriceLbl];
        
        timeLbl = [UILabel labelWithFrame:CGRectZero textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        [backView addSubview:timeLbl];
        
        [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_offset(145.5);
            make.height.mas_offset(16.5);
        }];
        
        paymentLbl = [UILabel labelWithFrame:CGRectMake(timeLbl.xx, iconImg.yy + 17.5, SCREEN_WIDTH/2 - 60, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        [backView addSubview:paymentLbl];
        
        [paymentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(timeLbl.mas_right).mas_offset(10);
            make.top.mas_offset(145.5);
            make.height.mas_offset(16.5);
            make.right.mas_offset(-15);
        }];
        
        label2 = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 15 - 96, iconImg.yy + 45, 96, 23) textAligment:(NSTextAlignmentCenter) backgroundColor:RGB(253, 246, 237) font:Font(12) textColor:kHexColor(@"#F89C44")];
        kViewRadius(label2, 11.5);
        
        [backView addSubview:label2];
        

    }
    return self;
}


-(void)setModel:(CarModel *)model
{
    codeLbl.text = [NSString stringWithFormat:@"订单编号：%@",model.code];
    if ([model.status isEqualToString:@"0"]) {
        statusLbl.text = @"待处理";
        statusLbl.textColor = kHexColor(@"#F89C44");
    }
    if ([model.status isEqualToString:@"1"]) {
        statusLbl.text = @"已处理";
        statusLbl.textColor = kHexColor(@"#999999");
    }
    if ([model.status isEqualToString:@"2"]) {
        statusLbl.text = @"申请失败";
        statusLbl.textColor = kHexColor(@"#F84444");
    }
    [iconImg sd_setImageWithURL:[NSURL URLWithString:[model.car[@"pic"] convertImageUrl]]];
    nameLbl.text = model.car[@"name"];
    nameLbl.frame = CGRectMake(iconImg.xx + 9, 48.5, SCREEN_WIDTH - iconImg.xx -  9 - 60, 0);
    [nameLbl sizeToFit];
    allPriceLbl.text = [NSString stringWithFormat:@"总价：%.2f元",[model.price floatValue]/1000];
    timeLbl.text = [model.createDatetime convertToDetailDate];
    
    
    NSString *sfAmount = [NSString stringWithFormat:@"%.2f",[model.sfAmount floatValue]/1000];
    NSString *allStr = [NSString stringWithFormat:@"首付：%@元",sfAmount];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:allStr];
    [attrStr addAttribute:NSFontAttributeName
                    value:Font(16)
                    range:NSMakeRange(allStr.length - sfAmount.length - 1,  sfAmount.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:kHexColor(@"#F84444")
                    range:NSMakeRange(allStr.length - sfAmount.length - 1,  sfAmount.length)];
    paymentLbl.attributedText = attrStr;
    
    label2.frame = CGRectMake(SCREEN_WIDTH - 30 - 15 - label2.width, iconImg.yy + 45, label2.width + 20, 23);
    label2.text = [NSString stringWithFormat:@"月供：%.2f",[model.monthAmount floatValue]/1000];
    [label2 sizeToFit];
    label2.frame = CGRectMake(SCREEN_WIDTH - 30 - 15 - label2.width - 20, iconImg.yy + 45, label2.width + 20, 23);
}

@end
