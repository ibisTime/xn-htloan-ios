//
//  ClassifyListVC.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ClassifyListVC : BaseViewController
//
//@property (nonatomic,strong) NSMutableArray<CarModel*> * carmodel;
@property (nonatomic,strong) NSMutableArray<CarModel*> * CarModels;
@property (nonatomic,strong) NSString * brandcode;
@end

NS_ASSUME_NONNULL_END
