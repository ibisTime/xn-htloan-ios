//
//  CarCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/18.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CarCell.h"

@implementation CarCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.TitleLab = [UILabel labelWithFrame:self.bounds textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kBlackColor];
//        self.TitleLab.text = @"35万以下";
        [self addSubview:self.TitleLab];
        
        self.layer.borderColor = kLineColor.CGColor;
        self.layer.borderWidth = 1;
    }
    return self;
}
//-(void)setSelected:(BOOL)selected{
//    if (selected) {
////        self.backgroundColor = MainColor;
//        self.layer.borderColor = MainColor.CGColor;
////        [self.TitleLab setTintColor:MainColor];
//        self.TitleLab.textColor = MainColor;
//    }
//    else{
//        self.layer.borderColor = kLineColor.CGColor;
////        [self.TitleLab setTintColor:kBlackColor];
//        self.TitleLab.textColor = kBlackColor;
//    }
//}
//-(void)setIsselect:(BOOL *)isselect{
//    if (isselect) {
//        self.layer.borderColor = MainColor.CGColor;
//        self.TitleLab.textColor = MainColor;
//    }
//    else{
//        self.layer.borderColor = kLineColor.CGColor;
//        self.TitleLab.textColor = kBlackColor;
//    }
//}
@end
