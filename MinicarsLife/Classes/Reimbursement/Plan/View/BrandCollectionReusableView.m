//
//  BrandCollectionReusableView.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/22.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BrandCollectionReusableView.h"

@implementation BrandCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(13, 15, 3, 20)];
        v1.backgroundColor = MainColor;
        kViewRadius(v1, 1.5);
        [self addSubview:v1];
        
        
        self.leftlab = [UILabel labelWithFrame:CGRectMake(23, 15, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        self.leftlab.text = @"热门品牌";
        [self addSubview:self.leftlab];
        
        self.morebtn = [UIButton buttonWithTitle:@"更多" titleColor:kBlackColor backgroundColor:kClearColor titleFont:12 cornerRadius:0];
        self.morebtn.frame = CGRectMake(SCREEN_WIDTH - 24 - 25, 22, 25, 17);
        [self addSubview:self.morebtn];
        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(self.morebtn.xx + 1, 25, 6, 11)];
        img.image = kImage(@"you");
        [self addSubview:img];
    }
    return self;
}
@end
