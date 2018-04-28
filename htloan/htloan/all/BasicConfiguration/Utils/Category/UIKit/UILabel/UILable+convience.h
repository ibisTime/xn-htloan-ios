//
//  UILable+convience.h
//  WeRide
//
//  Created by  tianlei on 2016/12/5.
//  Copyright © 2016年 trek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (convience)

- (instancetype)initWithFrame:(CGRect)frame
                 textAligment:(NSTextAlignment)aligment
              backgroundColor:(UIColor *)color
                         font:(UIFont *)font
                    textColor:(UIColor *)textColor;

+ (UILabel *)labelWithFrame:(CGRect)frame
                 textAligment:(NSTextAlignment)aligment
              backgroundColor:(UIColor *)color
                         font:(UIFont *)font
                    textColor:(UIColor *)textColor;

//设置Label的字体
+ (UILabel *)labelWithBackgroundColor:(UIColor *)color textColor:(UIColor *)textColor font:(CGFloat)font;


//设置Label的 title 字体
+ (UILabel *)labelWithTitle:(NSString *)title font:( UIFont *)font BackgroundColor:(UIColor *)color textColor:(UIColor *)textColor;
+ (UILabel *)labelWithTitle:(NSString *)title  BackgroundColor:(UIColor *)color textColor:(UIColor *)textColor font:( UIFont *)font;

/**
 黑色Label，带frame
 */
+ (UILabel *)labelWithTitle:(NSString *)title frame:(CGRect)frame;

@end
