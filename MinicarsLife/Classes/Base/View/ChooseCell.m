//
//  ChooseCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ChooseCell.h"

@implementation ChooseCell

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, 100, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    }
    return _nameLabel;
}

-(UIImageView *)xiaImage
{
    if (!_xiaImage) {
        _xiaImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 10, 22, 10, 6)];
        _xiaImage.image = HGImage(@"下拉");
        _xiaImage.userInteractionEnabled = YES;
        
    }
    return _xiaImage;
}

-(UILabel *)detailsLabel
{
    if (!_detailsLabel) {
        _detailsLabel = [UILabel labelWithFrame:CGRectMake(115, 0, SCREEN_WIDTH - 155, 50) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    }
    return _detailsLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.detailsLabel];
        [self addSubview:self.xiaImage];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
    }
    return self;
}

-(void)setName:(NSString *)name
{
    _nameLabel.text = name;
}

-(void)setDetails:(NSString *)details
{
    _detailsLabel.text = details;
}

@end
