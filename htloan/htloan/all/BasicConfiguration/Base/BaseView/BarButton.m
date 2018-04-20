//
//  BarButton.m
//  YS_iOS
//
//  Created by XI on 2017/6/8.
//  Copyright © 2017年 XI. All rights reserved.
//

#import "BarButton.h"

#import "TLUIHeader.h"
#import "AppColorMacro.h"

@implementation BarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //按钮
        self.iconImageView = [[UIImageView alloc] init];
        [self addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX);
            make.width.mas_equalTo(22);
            make.height.mas_equalTo(22);
            make.top.equalTo(self.mas_top).offset(15);
            
        }];
        
        //--//
        //文字
        self.titleLble = [UILabel labelWithFrame:CGRectZero textAligment:NSTextAlignmentCenter backgroundColor :[UIColor whiteColor] font:FONT(11) textColor:[UIColor themeColor]];
        [self addSubview:self.titleLble];
        [self.titleLble mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(50);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
        }];
    }
    return self;
}
@end
