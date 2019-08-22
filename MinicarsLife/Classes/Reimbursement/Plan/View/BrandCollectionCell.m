//
//  BrandCollectionCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/20.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BrandCollectionCell.h"

@implementation BrandCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 35, 35)];
        [self addSubview:self.logo];
        
        self.titlelab = [UILabel labelWithFrame:CGRectMake(0, self.logo.yy + 5, self.bounds.size.width, 25) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kBlackColor];
        [self addSubview:self.titlelab];
    }
    return self;
}

@end
