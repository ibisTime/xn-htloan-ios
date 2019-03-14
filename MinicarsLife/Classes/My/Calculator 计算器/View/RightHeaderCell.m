//
//  RightHeaderCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "RightHeaderCell.h"

@implementation RightHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = MainColor;
        self.titlelab = [UILabel labelWithFrame:CGRectMake(15, 20, SCREEN_WIDTH - 30, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kWhiteColor];
        self.titlelab.text = @"预计首付款（裸车价格+必要花费+商业保险）";
        [self addSubview:self.titlelab];
        
        self.moneylab = [UILabel labelWithFrame:CGRectMake(15, self.titlelab.yy + 10, SCREEN_WIDTH - 30, 70) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(18) textColor:kWhiteColor];
        self.moneylab.text = @"289，000元";
        [self addSubview:self.moneylab];
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, self.moneylab.yy + 5, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        [self addSubview:v1];
        
        for (int i = 0; i < 3; i ++) {
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0 + SCREEN_WIDTH / 3 * i, self.moneylab.yy + 10, SCREEN_WIDTH / 3, 70)];
            UILabel * money = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH / 3, 25) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kWhiteColor];
            money.text = @"123456";
            [view addSubview:money];
            
            UILabel * title = [UILabel labelWithFrame:CGRectMake(15, money.yy + 5, SCREEN_WIDTH / 3, 25) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kWhiteColor];
            title.text = @"月供（元）";
            [view addSubview:title];
            
            if (i < 2) {
                UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * (i+1),self.moneylab.yy + 20, 1, 40)];
                v1.backgroundColor = kLineColor;
                [self addSubview:v1];
            }
            
            [self addSubview:view];
        }
        
    }
    return self;
}
@end
