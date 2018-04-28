//
//  CalculatorGounp.h
//  htloan
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "BaseModel.h"
#import "CalculatorModel.h"

@interface CalculatorGounp : BaseModel
@property (nonatomic,copy) NSArray < CalculatorModel* >* items;

@property (nonatomic, copy) NSArray *sections;
@end
