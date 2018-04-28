//
//  CalculatorModel.h
//  htloan
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "BaseModel.h"

@interface CalculatorModel : BaseModel
//headerview
@property (nonatomic, copy) NSString * totalPriceNub;
@property (nonatomic, copy) NSString *paymentNub;
@property (nonatomic, copy) NSString *monthlyPaymentNub;
@property (nonatomic, copy) NSString *morePaymentNub;


//tableview
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *carText;

@property (nonatomic,strong) void(^action)();
@end
