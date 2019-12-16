//
//  DeployFirstCell.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CarModel.h"
#import "DeployModel.h"
#import "JKSmallLabels.h"
NS_ASSUME_NONNULL_BEGIN

@interface DeployFirstCell : UITableViewCell

@property (nonatomic ,strong)JKSmallLabels *jkSmallLabels;
@property (nonatomic,strong)NSString *carConfig;
@property (nonatomic,strong) UILabel * contentlab;
@end

NS_ASSUME_NONNULL_END
