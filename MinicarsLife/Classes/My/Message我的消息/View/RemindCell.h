//
//  RemindCell.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/13.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RemindCell : UITableViewCell
@property (nonatomic,strong) MessageModel * model;
@end

NS_ASSUME_NONNULL_END
