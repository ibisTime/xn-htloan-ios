//
//  ClassicCarsCell.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/6.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ClassicCarsCell.h"

@implementation ClassicCarsCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, 114)];
        self.logo.contentMode = UIViewContentModeScaleAspectFit;
        //        self.logo.autoresizesSubviews = YES;
        //        self.logo.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;;
        kViewRadius(self.logo, 4);
        [self addSubview:self.logo];
        
        self.desribelab = [UILabel labelWithFrame:CGRectMake(0, self.logo.yy + 11, self.width, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(15) textColor:kBlackColor];
        self.desribelab.numberOfLines = 2;
        
        [self addSubview:self.desribelab];
        
        self.moneylab = [UILabel labelWithFrame:CGRectMake(0,  self.logo.yy + 61.5, 80, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(14) textColor:kHexColor(@"#F84444")];
        
        [self addSubview:self.moneylab];
        
        self.personlab = [UILabel labelWithFrame:CGRectMake(self.moneylab.xx, self.logo.yy + 61.5, self.width - self.moneylab.xx, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
        [self addSubview:self.personlab];
        
//        self.monthAmountlab = [UILabel labelWithFrame:CGRectMake(0,  170, self.width, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(12) textColor:kHexColor(@"#F84444")];
//        [self addSubview:self.monthAmountlab];
    }
    return self;
}



-(void)setModel:(CarModel *)model{
    _model = model;
    [self.logo sd_setImageWithURL:[NSURL URLWithString:[model.pic convertImageUrl]] placeholderImage:kImage(@"default_pic")];
    self.desribelab.frame = CGRectMake(0, self.logo.yy + 10, self.width, 0);
    self.desribelab.text = [NSString stringWithFormat:@"%@",model.name];
    [self.desribelab sizeToFit];
    self.moneylab.text = [NSString stringWithFormat:@"%.2f万",[model.salePrice floatValue]/10000/1000];
    self.personlab.text = [NSString stringWithFormat:@"%@人关注",model.collectNumber];
    
//    if ([model.monthAmount floatValue] == 0) {
//        self.monthAmountlab.text = @"";
//    }else
//    {
//        self.monthAmountlab.text = [NSString stringWithFormat:@"月供%.2f元起",[model.monthAmount floatValue]/1000];
//    }
    
}

@end
