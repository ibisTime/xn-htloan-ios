//
//  XIMyApplyForModel.h
//  htloan
//
//  Created by apple on 2018/4/17.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "BaseModel.h"

@interface XIMyApplyForModel : BaseModel
//数据模拟
//订单号
@property (nonatomic, copy) NSString *orderNumber;
//处理情况
@property (nonatomic, copy) NSString *ProcessingConditions;

//汽车标的
@property (nonatomic, copy) UIView *carPayShow;

//其他数据
//CellHeight
@property (nonatomic, assign) CGFloat cellHeight;
@end
