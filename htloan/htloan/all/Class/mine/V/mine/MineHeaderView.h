//
//  MineHeaderView.h
//  Base_iOS
//
//  Created by XI on 2018/2/8.
//  Copyright © 2018年 XI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MineHeaderSeletedType) {
    MineHeaderSeletedTypeDefault = 0,   //设置
    MineHeaderSeletedTypeLogin,         //登录
};

@protocol MineHeaderSeletedDelegate <NSObject>

- (void)didSelectedWithType:(MineHeaderSeletedType)type idx:(NSInteger)idx;

@end

@interface MineHeaderView : UIView
//标题
@property (nonatomic, strong) UILabel *title;
//头像
@property (nonatomic, strong) UIImageView *userPhoto;
//昵称
@property (nonatomic, strong) UIButton *nameBtn;
//手机
@property (nonatomic, strong) UIButton *phoneNub;
//更多
@property (nonatomic, strong) UIButton *more;


@property (nonatomic, weak) id<MineHeaderSeletedDelegate> delegate;


@end
