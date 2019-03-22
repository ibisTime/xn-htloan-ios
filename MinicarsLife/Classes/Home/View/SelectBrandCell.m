//
//  SelectBrandCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/22.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "SelectBrandCell.h"

@implementation SelectBrandCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 19, 19)];
        [self addSubview:self.logo];
        
        self.titlelab = [UILabel labelWithFrame:self.bounds textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kBlackColor];
        self.titlelab.frame = CGRectMake(self.logo.xx + 5, 0, (SCREEN_WIDTH - 75) /4 - 19, 20);
        [self addSubview:self.titlelab];
    }
    return self;
}
@end
