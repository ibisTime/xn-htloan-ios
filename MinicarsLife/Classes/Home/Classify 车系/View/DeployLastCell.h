//
//  DeployLastCell.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeployModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DeployLastCell : UITableViewCell
//@property (nonatomic,strong) CarModel * CarModel;
@property (nonatomic,strong) NSMutableArray<DeployModel *> * DeployModels;
@end

NS_ASSUME_NONNULL_END
