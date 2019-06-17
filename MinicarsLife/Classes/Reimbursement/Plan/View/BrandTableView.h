//
//  BrandTableView.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/18.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BrandTableView : TLTableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray * indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;
//@property (nonatomic,strong) NSMutableArray<CarModel *> * NormalCarBrands;
@property (nonatomic , strong)NSArray<CarModel *> *normalArray;
@end

NS_ASSUME_NONNULL_END
