//
//  homeCarShowModel.h
//  htloan
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "BaseModel.h"

@interface homeCarShowModel : BaseModel
//shuju
@property (nonatomic,copy) NSString * pic;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * originalPrice;

@property (nonatomic, copy) NSString *code;

@property (nonatomic,strong) void(^action)();


@end
