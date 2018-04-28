//
//  stagingModel.h
//  htloan
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "BaseModel.h"

@interface stagingModel : BaseModel
@property (nonatomic,copy) NSString *carImg;
@property (nonatomic,copy) NSString *carTitle;
@property (nonatomic, copy) NSString *carPayments;
@property (nonatomic, copy) NSString *carMonthlyPayments;


//@property (nonatomic, assign) BOOL isHiddenArrow;

@property (nonatomic,strong) void(^action)();
@end
