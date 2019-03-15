//
//  HotCarCollectionCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "HotCarCollectionCell.h"
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@implementation HotCarCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = randomColor;
        self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, 90)];
        self.logo.image = kImage(@"1");
        [self addSubview:self.logo];
        
        self.desribelab = [UILabel labelWithFrame:CGRectMake(0, self.logo.yy + 10, self.width, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(15) textColor:kBlackColor];
        self.desribelab.numberOfLines = 2;
        self.desribelab.text= @"塞纳18款3.5四驱 Limited 7座加规";
        [self addSubview:self.desribelab];
        
        self.moneylab = [UILabel labelWithFrame:CGRectMake(0, self.desribelab.yy + 10, self.width / 2, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(14) textColor:MainColor];
        self.moneylab.text = @"73万";
        [self addSubview:self.moneylab];
        
        self.personlab = [UILabel labelWithFrame:CGRectMake(self.moneylab.xx, self.desribelab.yy + 10, self.width/ 2, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
        self.personlab.text= @"950人关注";
        [self addSubview:self.personlab];
        
    }
    return self;
}
@end