//
//  ClassicCarsCell.h
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/6.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ClassicCarsCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView * logo;
@property (nonatomic,strong) UILabel * desribelab;
@property (nonatomic,strong) UILabel * moneylab;
@property (nonatomic,strong) UILabel * monthAmountlab;
@property (nonatomic,strong) UILabel * personlab;
@property (nonatomic , strong)CarModel *model;

@end

NS_ASSUME_NONNULL_END
