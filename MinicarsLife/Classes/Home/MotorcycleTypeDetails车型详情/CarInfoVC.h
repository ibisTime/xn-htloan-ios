//
//  CarInfoVC.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CarInfoVC : BaseViewController
@property (nonatomic,strong) CarModel *CarModel;
@property (nonatomic,strong)NSString *status;
@end

NS_ASSUME_NONNULL_END
