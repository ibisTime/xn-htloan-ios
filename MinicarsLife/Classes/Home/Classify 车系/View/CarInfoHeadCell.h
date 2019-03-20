//
//  CarInfoHeadCell.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CarInfoHeadCell : UITableViewCell
@property (nonatomic,strong) UILabel * titlelab;
@property (nonatomic,strong) UILabel * describdlab;
@property (nonatomic,strong) UILabel * timelab;
@property (nonatomic,strong) UILabel * moneylab;
@property (nonatomic,strong) UILabel * contentlab;
@property (nonatomic,strong) UIView * view;
@property (nonatomic,strong) CarModel * CarModel;
@property (nonatomic,strong) UIButton * button;
@end

NS_ASSUME_NONNULL_END
