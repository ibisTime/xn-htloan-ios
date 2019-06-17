//
//  CalculatorModel.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/20.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalculatorModel : NSObject

/**
 "sfAmount" : 300000,
 "yjsfAmount" : 303600,
 "dkTotalAmount" : 700000,
 "dkAmount" : 700000,
 "monthReply" : 58333,
 "extraAmount" : 0,
 "procedureAmount" : 0,
 "totalAmount" : 1003596,
 "sybx" : 2000,
 "saleAmount" : 1000000,
 "byhf" : 1600
 */
@property (nonatomic,copy) NSString * sfAmount;//首付
@property (nonatomic,copy) NSString * yjsfAmount;//预计首付
@property (nonatomic,copy) NSString * dkTotalAmount;//贷款总金额
@property (nonatomic,copy) NSString * dkAmount;//贷款金额
@property (nonatomic,copy) NSString * monthReply;//月供
@property (nonatomic,copy) NSString * extraAmount;//额外费用
@property (nonatomic,copy) NSString * procedureAmount;//手续费
@property (nonatomic,copy) NSString * totalAmount;//总花费
@property (nonatomic,copy) NSString * sybx;//商业保险
@property (nonatomic,copy) NSString * saleAmount;//原价
@property (nonatomic,copy) NSString * byhf;//必要花费
@end

NS_ASSUME_NONNULL_END
