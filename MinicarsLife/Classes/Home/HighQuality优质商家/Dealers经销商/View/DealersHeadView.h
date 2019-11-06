//
//  DealersHeadView.h
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/8/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DealersHeadView : UIView
@property (nonatomic , strong)CarModel *dealersModel;
@property (nonatomic , strong)UIButton *shutdownBtn;
@property (nonatomic , assign)NSInteger newsTotalCount;
@property (nonatomic , assign)NSInteger carsTotalCount;
@end

NS_ASSUME_NONNULL_END
