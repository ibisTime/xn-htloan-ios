//
//  BaseViewController.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/27.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic , strong)UIButton *LeftBackbButton;

@property (nonatomic , strong)UIButton *RightButton;

//导航栏设为透明
-(void)navigationTransparentClearColor;
//导航栏设为默认
-(void)navigationSetDefault;
//导航栏设为白色
-(void)navigationwhiteColor;
@end
