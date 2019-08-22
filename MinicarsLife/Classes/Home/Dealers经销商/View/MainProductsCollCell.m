//
//  MainProductsCollCell.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/8/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MainProductsCollCell.h"

@implementation MainProductsCollCell
{
    UIImageView *iconImg;
    UILabel *nameLbl;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        iconImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 60)/5/2 - 20, 7.5, 40, 40)];
//
        iconImg.contentMode = UIViewContentModeScaleAspectFit;
        iconImg.autoresizesSubviews = YES;
        iconImg.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;;
        
        [self addSubview:iconImg];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(0, iconImg.yy + 9, (SCREEN_WIDTH - 60)/5, 17) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kBlackColor];
        [self addSubview:nameLbl];
        
        
    }
    return self;
}

-(void)setBrand:(NSDictionary *)brand
{
    [iconImg sd_setImageWithURL:[NSURL URLWithString:[brand[@"brandLogo"] convertImageUrl]]];
    nameLbl.text = brand[@"brandName"];
}

@end
