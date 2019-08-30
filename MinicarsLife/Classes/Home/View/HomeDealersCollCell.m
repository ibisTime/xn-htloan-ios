//
//  HomeDealersCollCell.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/8/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "HomeDealersCollCell.h"

@implementation HomeDealersCollCell
{
    UIImageView *iconImg;
    UILabel *nameLbl;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 90, 68)];
        kViewRadius(iconImg, 2);
        iconImg.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:iconImg];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(0, iconImg.yy + 6, 90, 17) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        [self addSubview:nameLbl];
    }
    return self;
}

-(void)setModel:(CarModel *)model
{
    [iconImg sd_setImageWithURL:[NSURL URLWithString:[model.shopLogo convertImageUrl]]];
    nameLbl.text = model.abbrName;
}

@end
