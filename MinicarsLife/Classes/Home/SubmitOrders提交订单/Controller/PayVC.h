//
//  PayVC.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

@interface PayVC : BaseViewController

@property (nonatomic , copy)NSString *state;

@property (nonatomic , copy)NSString *code;

@property (nonatomic , assign)CGFloat price;

@end
