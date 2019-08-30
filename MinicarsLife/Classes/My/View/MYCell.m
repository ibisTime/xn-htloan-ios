//
//  MYCell.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MYCell.h"

@implementation MYCell

-(UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage  = [[UIImageView alloc]initWithFrame:CGRectMake(15, 17.5, 15, 15)];

    }
    return _iconImage;
}

-(UILabel *)numberLbl
{
    if (!_numberLbl) {
        _numberLbl = [UILabel labelWithFrame:CGRectMake(22.5, 10, 15, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:MainColor font:HGfont(9) textColor:[UIColor whiteColor]];
        kViewRadius(_numberLbl, 7.5);
        _numberLbl.text = [NSString stringWithFormat:@"%ld",[[USERDEFAULTS objectForKey:@"unreadnumber"] integerValue]];
        _numberLbl.hidden = YES;
    }
    return _numberLbl;
}

-(void)setNumber:(NSInteger)number
{
     _numberLbl.text = [NSString stringWithFormat:@"%ld",number];
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(40, 0, 150, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:[UIColor whiteColor] font:HGfont(14) textColor:[UIColor blackColor]];

    }
    return _nameLabel;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH-100, 0, 110, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:[UIColor whiteColor] font:HGfont(14) textColor:[UIColor blackColor]];
        
    }
    return _detailLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.iconImage];
        [self addSubview:self.numberLbl];
        [self addSubview:self.nameLabel];
        [self addSubview:self.detailLabel];

        UIImageView *youImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 21, 19.5, 6, 11)];
        youImage.image= HGImage(@"more");
        [self addSubview:youImage];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 49, SCREEN_WIDTH - 20, 1)];
        lineView.backgroundColor = BackColor;
        [self addSubview:lineView];

    }
    return self;

}

@end
