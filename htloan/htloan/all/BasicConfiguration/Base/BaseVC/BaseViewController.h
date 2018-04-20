//
//  BaseViewController.h
//  BS
//
//  Created by JH on 16/3/31.
//  Copyright © 2016年 JH. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "CoinHeader.h"

@interface BaseViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) UIView *placeholderView;

@property (nonatomic, strong) UIScrollView *bgSV;

- (void)placeholderOperation;

- (void)setPlaceholderViewTitle:(NSString *)title  operationTitle:(NSString *)optitle;

- (void)removePlaceholderView; //移除
- (void)addPlaceholderView; // 添加

/**
 登录成功后执行loginSuccess
 */
- (void)checkLogin:(void(^)(void))loginSuccess;
/**
 登录成功后执行loginSuccess
 已经登录的执行event
 */
- (void)checkLogin:(void(^)(void))loginSuccess event:(void(^)(void))event;

@end
