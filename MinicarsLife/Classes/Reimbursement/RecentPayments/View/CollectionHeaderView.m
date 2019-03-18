//
//  CollectionHeaderView.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/18.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CollectionHeaderView.h"

@implementation CollectionHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(13, 15, 3, 20)];
        v1.backgroundColor = MainColor;
        [self addSubview:v1];
        
        
        self.leftlab = [UILabel labelWithFrame:CGRectMake(23, 015, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        [self addSubview:self.leftlab];
    }
    return self;
}
@end
