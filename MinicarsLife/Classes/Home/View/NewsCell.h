//
//  NewsCell.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewsCell : UITableViewCell
@property (nonatomic,strong) NewsModel * model;
@end

NS_ASSUME_NONNULL_END
