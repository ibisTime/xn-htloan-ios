//
//  HotCarCollectionCell.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HotCarCollectionCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView * logo;
@property (nonatomic,strong) UILabel * desribelab;
@property (nonatomic,strong) UILabel * moneylab;
@property (nonatomic,strong) UILabel * personlab;
@property (nonatomic,strong) CarModel * model;
@end

NS_ASSUME_NONNULL_END
