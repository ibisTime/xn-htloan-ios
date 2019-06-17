//
//  SelectcarFootCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/19.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "SelectcarFootCell.h"

@implementation SelectcarFootCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor greenColor];
        self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, self.bounds.size.width - 10, 60)];
        kViewRadius(self.logo, 4);
//        self.logo.contentMode =UIViewContentModeScaleAspectFill;
        [self addSubview:self.logo];
        
        self.titlelab = [UILabel labelWithFrame:CGRectMake(0, self.logo.yy, self.bounds.size.width, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(13) textColor:kBlackColor];
        [self addSubview:self.titlelab];
    }
    return self;
}
@end
