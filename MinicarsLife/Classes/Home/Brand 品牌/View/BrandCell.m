//
//  BrandCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BrandCell.h"
@interface BrandCell()
@property (nonatomic,strong) UIImageView * logo;
@property (nonatomic,strong) UILabel * brandname;
@end
@implementation BrandCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = randomColor;
        self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(40, 25, 45, 30.2)];
        self.logo.image = kImage(@"1");
        [self addSubview:self.logo];
        
        self.brandname = [UILabel labelWithFrame:CGRectMake(0, self.logo.yy + 5.3, self.width, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kBlackColor];
        self.brandname.text = @"丰田";
        [self addSubview:self.brandname];
        
    }
    return self;
}
-(void)setCarmodel:(CarModel *)carmodel{
    _carmodel = carmodel;
    [self.logo sd_setImageWithURL:[NSURL URLWithString:[carmodel.logo convertImageUrl]] placeholderImage:kImage(@"default_pic")];
    self.logo.contentMode =UIViewContentModeScaleAspectFill;
    //超出容器范围的切除掉
    self.logo.clipsToBounds = YES;
    self.brandname.text = carmodel.name;
}
@end
