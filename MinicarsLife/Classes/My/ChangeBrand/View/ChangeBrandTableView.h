//
//  ChangeBrandTableView.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/6/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChangeBrandTableView : TLTableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray<CarModel *> * CarModels;
@end

NS_ASSUME_NONNULL_END
