//
//  HighQualityTableView.h
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/4.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HighQualityTableView : TLTableView
@property (nonatomic , strong)NSMutableArray <CarModel *>*models;
@end

NS_ASSUME_NONNULL_END
