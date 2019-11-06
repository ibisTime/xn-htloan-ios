//
//  CarInfoCommonCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CarInfoCommonCell.h"
@interface CarInfoCommonCell()
@end

@implementation CarInfoCommonCell

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
        self.titlelab = [UILabel labelWithFrame:CGRectMake(15, 12.5, 75, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kTextColor2];
        self.titlelab.text = @"车源所在地";
        [self addSubview:self.titlelab];
        
        self.contentlab = [UILabel labelWithFrame:CGRectMake(self.titlelab.xx + 20.5, 12.5, SCREEN_HEIGHT - 30 - self.titlelab.xx, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        self.contentlab.text = @"杭州市";
        [self addSubview:self.contentlab];
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 44, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        [self addSubview:v1];
    }
    return self;
}
@end
