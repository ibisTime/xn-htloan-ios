//
//  DeployModel.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/22.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface DeployModel : NSObject

/**
 "code": "CCC201903192055539139744",
 "carCode": "C201903191540014947886",
 "configCode": "CC201903192054092006418",
 "config": {
 "code": "CC201903192054092006418",
 "name": "天窗",
 "pic": "tu",
 "updater": "admin",
 "updateDatetime": "Mar 19, 2019 8:54:09 PM",
 "remark": "0"
 }
 */
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * carCode;
@property (nonatomic,copy) NSString * configCode;
@property (nonatomic,strong) NSDictionary * config;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * pic;
@property (nonatomic,copy) NSString * updater;
@property (nonatomic,copy) NSString * updateDatetime;
@property (nonatomic,copy) NSString * remark;

@end

NS_ASSUME_NONNULL_END
