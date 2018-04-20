//
//  BarButton.h
//  YS_iOS
//
//  Created by XI on 2017/6/8.
//  Copyright © 2017年 XI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarButton : UIButton

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLble;

@property (nonatomic, assign) BOOL isCurrentSelected;


@end
