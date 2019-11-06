//
//  CarsTableView.h
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/4.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CarsTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <CarModel *>*carsModels;

@property (nonatomic,strong) NSMutableArray<CarModel *> * HotCarBrands;

@property (nonatomic,strong) NSArray * indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@property (nonatomic , strong)NSArray<CarModel *> *normalArray;

@end

NS_ASSUME_NONNULL_END
