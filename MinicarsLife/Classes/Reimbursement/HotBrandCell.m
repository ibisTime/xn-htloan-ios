//
//  HotBrandCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/18.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "HotBrandCell.h"

@implementation HotBrandCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titlelab = [UILabel labelWithFrame:self.bounds textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        [self addSubview:self.titlelab];
        self.layer.borderColor = kLineColor.CGColor;
        self.layer.borderWidth = 1;
    }
    return self;
}
@end
