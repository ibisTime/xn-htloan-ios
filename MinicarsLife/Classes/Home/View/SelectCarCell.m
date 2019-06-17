//
//  SelectCarCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/19.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "SelectCarCell.h"

@implementation SelectCarCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        
            self.titlelab = [UILabel labelWithFrame:self.bounds textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kBlackColor];
            [self addSubview:self.titlelab];
        
    }
    return self;
}
@end
