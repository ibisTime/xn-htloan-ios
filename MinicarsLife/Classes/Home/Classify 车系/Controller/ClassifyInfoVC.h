//
//  ClassifyInfoVC.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ClassifyInfoVC : BaseViewController
@property (nonatomic,strong)NSMutableArray< CarModel * >*models;
@property (nonatomic,strong) NSString * seriesCode;
@end

NS_ASSUME_NONNULL_END
