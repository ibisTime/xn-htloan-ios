//
//  ClassifyInfoCell.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
#import "JKSmallLabels.h"
NS_ASSUME_NONNULL_BEGIN

@interface ClassifyInfoCell : UITableViewCell

@property (nonatomic ,strong)JKSmallLabels *jkSmallLabels;
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) UILabel * titlelab;
@property (nonatomic,strong) UILabel * describdlab;
@property (nonatomic,strong) UILabel * timelab;
@property (nonatomic,strong) UILabel * moneylab;
@property (nonatomic,strong) UILabel * contentlab;
@property (nonatomic,strong) UIView * v1;
@property (nonatomic,strong) CarModel * carmodel;
@property (nonatomic,strong) NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
