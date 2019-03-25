//
//  CommonCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CommonCell.h"

@implementation CommonCell

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
        self.TitleLab = [UILabel labelWithFrame:CGRectMake(15, 10, 60, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        self.TitleLab.text = @"预计总花费（裸车价格+必要花费+商业保险）";
        [self addSubview:self.TitleLab];
        
        self.ContentLab = [UILabel labelWithFrame:CGRectMake(90, 10, SCREEN_WIDTH - 105 - 15, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(15) textColor:kBlackColor];
        self.ContentLab.text = @"410，000元";
        [self addSubview:self.ContentLab];
        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 15, (self.bounds.size.height - 10)/2, 6, 11)];
        img.image = kImage(@"you");
        [self addSubview:img];
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 49, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        [self addSubview:v1];
        
    }
    return self;
}
@end
