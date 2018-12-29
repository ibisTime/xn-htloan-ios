//
//  MoblieCodeVC.h
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

@interface MoblieCodeVC : BaseViewController
@property (nonatomic ,copy) NSString *code;

@property (nonatomic ,assign) BOOL isEC;
@property (nonatomic ,assign) BOOL isJD;
@property (nonatomic ,assign) BOOL isMb;

@property (nonatomic ,strong) UIImage *imageData;
@end
