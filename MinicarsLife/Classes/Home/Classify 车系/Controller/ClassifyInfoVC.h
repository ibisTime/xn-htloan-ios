//
//  ClassifyInfoVC.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ClassifyInfoVC : BaseViewController
@property (nonatomic,strong)CarModel *models;
@property (nonatomic,strong) NSString *priceStart;
@property (nonatomic,strong) NSString *priceEnd;
@property (nonatomic , strong)NSArray *levelList;
@property (nonatomic , strong)NSArray *versionList;
@property (nonatomic , strong)NSArray *structureList;
@property (nonatomic , strong)NSString *displacementStart;
@property (nonatomic , strong)NSString *displacementEnd;
@property (nonatomic , strong)NSString *queryName;

@property (nonatomic,strong) NSString * brandCode;
@property (nonatomic,strong) NSString * carDealerCode;


@end

NS_ASSUME_NONNULL_END
