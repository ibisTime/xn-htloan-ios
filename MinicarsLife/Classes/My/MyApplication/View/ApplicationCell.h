//
//  ApplicationCell.h
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/6.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ApplicationCell : UITableViewCell

@property (nonatomic , strong)CarModel *model;

@end

NS_ASSUME_NONNULL_END