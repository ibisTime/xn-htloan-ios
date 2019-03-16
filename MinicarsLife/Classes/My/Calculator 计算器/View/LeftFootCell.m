//
//  LeftFootCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "LeftFootCell.h"

@implementation LeftFootCell

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
        self.leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2, 81)];
        self.leftmoney = [UILabel labelWithFrame:CGRectMake(15, 15,self.leftview.width - 30 , 25) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        self.leftmoney.text = @"41.157";
        [self.leftview addSubview:self.leftmoney];
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, self.leftmoney.yy + 10, self.leftview.width - 30, 25) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(13) textColor:kTextColor3];
        label.text = @"必要花费（元）";
        [label sizeToFit];
        label.frame = CGRectMake((self.leftview.width - label.width) / 2, self.leftmoney.yy + 10, label.width, 25);
        [self.leftview addSubview:label];
        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 15 - 15, (self.leftview.height - 15) / 2, 13, 15)];
        img.image = kImage(@"you");
        [self.leftview addSubview:img];
        [self addSubview:self.leftview];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2, 20, 1, 40)];
        view.backgroundColor = kLineColor;
        [self addSubview:view];
        
        self.rightview = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, 70)];
        self.rightmoney = [UILabel labelWithFrame:CGRectMake(15, 15,self.rightview.width - 30 , 25) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        self.rightmoney.text = @"41.157";
        [self.rightview addSubview:self.rightmoney];
        
        UILabel * label1 = [UILabel labelWithFrame:CGRectMake(15, self.rightmoney.yy + 10, self.rightview.width - 30, 25) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(13) textColor:kTextColor3];
        label1.text = @"必要花费（元）";
        [label1 sizeToFit];
        label1.frame = CGRectMake((self.rightview.width - label1.width) / 2, self.rightmoney.yy + 10, label1.width, 25);
        [self.rightview addSubview:label1];
        
        UIImageView * img1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 15 - 15, (self.rightview.height - 15) / 2, 13, 15)];
        img1.image = kImage(@"you");
        [self.rightview addSubview:img1];
        
        [self addSubview:self.rightview];
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        [self addSubview:v1];
    }
    return self;
}
@end
