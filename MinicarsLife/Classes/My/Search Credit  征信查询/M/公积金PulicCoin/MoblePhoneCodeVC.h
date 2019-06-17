//
//  MoblePhoneCodeVC.h
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/15.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

@interface MoblePhoneCodeVC : BaseViewController

@property (nonatomic ,copy) NSString *id;

@property (nonatomic ,assign) BOOL isEC;
@property (nonatomic ,assign) BOOL isJD;

@property (nonatomic ,strong) UIImage *imageData;

@end
