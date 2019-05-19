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
        kViewRadius(self.logo, 4);
        [self addSubview:self.logo];
        
        self.desribelab = [UILabel labelWithFrame:CGRectMake(0, self.logo.yy + 10, self.width, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(15) textColor:kBlackColor];
        self.desribelab.numberOfLines = 2;
        self.desribelab.text= @"塞纳18款3.5四驱 Limited 7座加规";
        [self addSubview:self.desribelab];
        
        self.moneylab = [UILabel labelWithFrame:CGRectMake(0,  150, 80, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(14) textColor:MainColor];
        self.moneylab.text = @"73万";
        [self addSubview:self.moneylab];
        
        self.personlab = [UILabel labelWithFrame:CGRectMake(self.moneylab.xx, 150, 50, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
        self.personlab.text= @"950人关注";
        [self addSubview:self.personlab];
        
    }
    return self;
}
-(void)setModel:(CarModel *)model{
    _model = model;
    self.logo.backgroundColor = [UIColor redColor];
//    self.logo.contentMode = UIViewContentModeScaleAspectFill;
    [self.logo sd_setImageWithURL:[NSURL URLWithString:[model.pic convertImageUrl]] placeholderImage:kImage(@"default_pic")];
    
//    self.logo.clipsToBounds = YES;
    self.desribelab.frame = CGRectMake(0, self.logo.yy + 10, self.width, 0);
    self.desribelab.text = [NSString stringWithFormat:@"%@  %@",model.name,model.slogan];
    [self.desribelab sizeToFit];
    
    self.moneylab.text = [NSString stringWithFormat:@"%.2f万",[model.salePrice floatValue]/10000/1000];
    self.personlab.text = [NSString stringWithFormat:@"%@人关注",model.collectNumber];
}

@end
