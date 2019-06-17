//
//  NearFutureModel.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/19.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "NearFutureModel.h"

@implementation NearFutureModel


-(NSString *)getStatusFromCode:(NSString *)curNodecode
{
    
    if ([curNodecode isEqualToString:@"004_01"] ||[curNodecode isEqualToString:@"004_04"] ||[curNodecode isEqualToString:@"004_05"]||[curNodecode isEqualToString:@"006_01"]||[curNodecode isEqualToString:@"006_06"]||[curNodecode isEqualToString:@"006_04"]) {
        return @"还款中";
    }else if([curNodecode isEqualToString:@"004_03"] ||[curNodecode isEqualToString:@"004_06"] ||[curNodecode isEqualToString:@"004_07"]||[curNodecode isEqualToString:@"004_08"]||[curNodecode isEqualToString:@"004_09"]||[curNodecode isEqualToString:@"004_10"]||[curNodecode isEqualToString:@"006_05"]||[curNodecode isEqualToString:@"006_03"])
    {
        return @"已逾期";
    }else if([curNodecode isEqualToString:@"004_02"] ||[curNodecode isEqualToString:@"006_02"])
    {
        return @"已还款";
    }else{
        return @"结清中";
    }
    
    
}



@end
