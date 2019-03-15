//
//  CarModel.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarModel : NSObject

/**
 "code": "C201903071433051666580",
 "name": "豪华版",
 "seriesCode": "S201903071411292394034",
 "seriesName": "S400L",
 "brandCode": "B201806190344172014125",
 "brandName": "奔驰",
 "originalPrice": 1400000,
 "salePrice": 1400000,
 "sfAmount": 1000000,
 "location": 10,
 "orderNo": 10,
 "slogan": "极致享受",
 "advPic": "advPic",
 "pic": "缩略图",
 "description": "豪华体验",
 "status": "2",
 "updater": "admin",
 "updateDatetime": "Mar 7, 2019 2:38:04 PM",
 "remark": "备注"
 */
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * seriesCode;
@property (nonatomic,copy) NSString * seriesName;
@property (nonatomic,copy) NSString * brandCode;
@property (nonatomic,copy) NSString * brandName;
@property (nonatomic,copy) NSString * originalPrice;
@property (nonatomic,copy) NSString * salePrice;
@property (nonatomic,copy) NSString * sfAmount;
@property (nonatomic,copy) NSString * orderNo;
@property (nonatomic,copy) NSString * slogan;
@property (nonatomic,copy) NSString * advPic;
@property (nonatomic,copy) NSString * pic;
@property (nonatomic,copy) NSString * Description;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * updater;
@property (nonatomic,copy) NSString * updateDatetime;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,copy) NSString * letter;
@property (nonatomic,copy) NSString * logo;
@property (nonatomic,copy) NSString * picNumber;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * highest;
@property (nonatomic,copy) NSString * lowest;
@property (nonatomic,copy) NSString * level;
@property (nonatomic,copy) NSString * isReferee;

/**
 "price": 0,
 "highest": 0,
 "lowest": 0,
 "level": "4",
 "isReferee": "1",
 "status": "0",
 "updater": "U201806131315524345485",
 "updateDatetime": "Mar 15, 2019 10:51:12 AM",
 "remark": "小皮卡真棒",
 "updaterName": "洪仁飞"
 */

+(NSDictionary *)mj_replacedKeyFromPropertyName;
@end

NS_ASSUME_NONNULL_END
