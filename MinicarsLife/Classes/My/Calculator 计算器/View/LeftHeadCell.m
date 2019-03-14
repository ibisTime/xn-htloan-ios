//
//  LeftHeadCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "LeftHeadCell.h"

@implementation LeftHeadCell

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
        self.titlelab = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kWhiteColor];
        self.titlelab.text = @"预计总花费（裸车价格+必要花费+商业保险）";
        [self addSubview:self.titlelab];
        
        self.moneylab = [UILabel labelWithFrame:CGRectMake(15, self.titlelab.yy + 10, SCREEN_WIDTH - 30, 70) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(18) textColor:kWhiteColor];
        self.moneylab.text = @"410，000元";
        [self addSubview:self.moneylab];
    }
    return self;
}

@end
