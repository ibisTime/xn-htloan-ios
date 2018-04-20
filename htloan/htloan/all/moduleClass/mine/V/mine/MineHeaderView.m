//
//  MineHeaderView.m
//  Base_iOS
//
//  Created by 蔡卓越 on 2018/2/8.
//  Copyright © 2018年 caizhuoyue. All rights reserved.
//

#import "MineHeaderView.h"

//Macro
#import "TLUIHeader.h"
#import "AppColorMacro.h"
//M
#import "TLUser.h"

@interface MineHeaderView()
//图片
@property (nonatomic, strong) UIImageView *bgIV ;

@end

@implementation MineHeaderView

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
    
//    self.backgroundColor = kClearColor;
//    CGFloat MaxHeight = XIImageHeight;
//    self.bgIV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.bounds.size.width, MaxHeight)];
//    
//   self.bgIV.image =kImage(@"我的背景");
//   self.bgIV.contentMode = UIViewContentModeScaleToFill;
//    
//    [self addSubview:self.bgIV];
    
//    self.title =[UILabel labelWithTitle:@"我的" frame:CGRectMake((kScreenWidth-200)/2, 20, 200, 44)];
//
//    [self addSubview:self.title];
    //头像
    CGFloat imgWidth = 65;
    CGFloat imgY = 20;
    self.userPhoto = [[UIImageView alloc] init];
    
    self.userPhoto.frame = CGRectMake(15,imgY, imgWidth, imgWidth);
    self.userPhoto.image = USER_PLACEHOLDER_SMALL;
    self.userPhoto.layer.cornerRadius = imgWidth/2.0;
    self.userPhoto.layer.masksToBounds = YES;
    self.userPhoto.contentMode = UIViewContentModeScaleAspectFill;
    
    self.userPhoto.userInteractionEnabled = YES;
    
    [self addSubview:self.userPhoto];
    
//    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhoto:)];
//
//    [self.userPhoto addGestureRecognizer:tapGR];
    //名字
    self.nameBtn = [UIButton buttonWithTitle:@"王敏"
                                  titleColor:kWhiteColor
                             backgroundColor:kClearColor
                                   titleFont:14.0];
    [self.nameBtn addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.nameBtn];
    
    [self.nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.userPhoto.mas_centerY).offset(-5);
        make.left.equalTo(self.userPhoto.mas_right).offset(10);
    }];
    
    //手机号码
    self.phoneNub = [UIButton buttonWithTitle:@"15890988458"
                                  titleColor:kWhiteColor
                             backgroundColor:kClearColor
                                   titleFont:14.0];
       [self addSubview:self.phoneNub];
    
    [self.phoneNub mas_makeConstraints:^(MASConstraintMaker *make) {
        
       make.top.equalTo(self.nameBtn.mas_bottom);
        make.left.equalTo(self.userPhoto.mas_right).offset(10);
    }];
// 更多
    self.more = [UIButton buttonWithImageName:@"更多白"];
    [self addSubview:self.more];
    [self.more mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.userPhoto.mas_centerY);
        make.right.offset(-20);
    }];
    
    
}

#pragma mark - Events
- (void)clickLogin {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedWithType:idx:)] && ![TLUser user].isLogin) {
        
        [self.delegate didSelectedWithType:MineHeaderSeletedTypeLogin idx:0];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedWithType:idx:)]) {
        
        [self.delegate didSelectedWithType:MineHeaderSeletedTypeDefault idx:0];
    }
    
}

@end
