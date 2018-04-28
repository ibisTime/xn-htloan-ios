//
//  MineGroup.h
//  Coin
//
//  Created by XI on 2017/11/9.
//  Copyright © 2017年  XI. All rights reserved.
//

#import "BaseModel.h"
#import "MineModel.h"

@interface MineGroup : BaseModel

@property (nonatomic,copy) NSArray <MineModel *>*items;

@property (nonatomic, copy) NSArray *sections;    //分组

@end
