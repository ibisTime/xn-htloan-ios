//
//  CarInfoCommonCell.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CarInfoCommonCell : UITableViewCell
@property (nonatomic,strong) UILabel * titlelab;
@property (nonatomic,strong) UILabel * contentlab;
@property (nonatomic,strong) CarModel * CarModel;
@end

NS_ASSUME_NONNULL_END
