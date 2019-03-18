//
//  CarlevelCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/18.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CarlevelCell.h"

@implementation CarlevelCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
        self.logo.image = kImage(@"1");
        [self addSubview:self.logo];
        
        
        self.name = [UILabel labelWithFrame:CGRectMake(0, self.logo.yy, self.bounds.size.width, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kBlackColor];
        self.name.text = @"车";
        [self addSubview:self.name];
    }
    return self;
}
@end
