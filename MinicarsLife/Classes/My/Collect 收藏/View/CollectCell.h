//
//  CollectCell.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/13.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectModel.h"
#import "DeployModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CollectCell : UITableViewCell
@property (nonatomic,strong) CollectModel * model;
@property (nonatomic,strong) UIView * view ;
@property (nonatomic,strong) NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
