//
//  CarTextImgV.m
//  htloan
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "CarTextImgV.h"
#import <TYAttributedLabel.h>


#import "TLUIHeader.h"
#define RGBA(r,g,b,a)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface CarTextImgV ()<TYAttributedLabelDelegate>
@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UILabel *title;
@end
@implementation CarTextImgV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self initSubviews];
    }
    return self;
}
#pragma mark - Init
- (void)initSubviews {
    self.titleImg = [[ UIImageView alloc] init];
    self.titleImg.image = [UIImage imageNamed:@"矩形44"];
    [self addSubview:self.titleImg];
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(10);
    }];
    
    self.title = [UILabel labelWithTitle:@"图文详情" font:Font(13) BackgroundColor:kClearColor textColor:kBlackColor];
    [self addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.top.offset(10);
    }];
    
    
    
    
}
@end
