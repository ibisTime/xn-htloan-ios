//
//  DealersTableView.h
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/8/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "CarModel.h"
#import "NewsModel.h"
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DealersTableView : TLTableView
@property (nonatomic , strong)NSMutableArray <CarModel *>*CarModelsCars;
@property (nonatomic , strong)NSMutableArray <NewsModel *>*NewsModels;
@property (nonatomic , strong)CarModel *dealersModel;
@property (nonatomic ,strong)NSArray *newstagDataAry;
@end

NS_ASSUME_NONNULL_END
