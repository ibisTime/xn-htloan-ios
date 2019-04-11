//
//  CollectModel.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CollectModel : NSObject
/**
 "code": "A201903141352249807595",
 "type": "3",
 "toType": "0",
 "toCode": "C201903071433051666580",
 "creater": "U201903141332098002963",
 "createDatetime": "Mar 14, 2019 1:52:24 PM",
 "car": {
 
 }
 */
@property (nonatomic,copy) NSString * level;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * toType;
@property (nonatomic,copy) NSString * toCode;
@property (nonatomic,copy) NSString * creater;
@property (nonatomic,copy) NSString * createDatetime;
@property (nonatomic,copy) NSDictionary * car;
@property (nonatomic,copy) NSString * Description;
@end

NS_ASSUME_NONNULL_END
