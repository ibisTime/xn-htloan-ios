//
//  ReimbursementModel.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/19.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ReimbursementModel.h"

@implementation ReimbursementModel
-(NSString *)getStatusFromCode:(NSString *)curNodecode
{
    
    if ([curNodecode isEqualToString:@"003_01"] ||[curNodecode isEqualToString:@"003_17"] ||[curNodecode isEqualToString:@"003_18"]||[curNodecode isEqualToString:@"003_19"]||[curNodecode isEqualToString:@"005_01"]) {
        return @"还款中";
    }else if([curNodecode isEqualToString:@"003_02"] ||[curNodecode isEqualToString:@"003_03"] ||[curNodecode isEqualToString:@"003_04"]||[curNodecode isEqualToString:@"003_05"]||[curNodecode isEqualToString:@"003_06"]||[curNodecode isEqualToString:@"003_20"]||[curNodecode isEqualToString:@"005_02"])
    {
        return @"结清中";
    }else if([curNodecode isEqualToString:@"003_08"] ||[curNodecode isEqualToString:@"003_09"] ||[curNodecode isEqualToString:@"003_10"]||[curNodecode isEqualToString:@"003_11"]||[curNodecode isEqualToString:@"003_13"]||[curNodecode isEqualToString:@"003_14"]||[curNodecode isEqualToString:@"003_15"]||[curNodecode isEqualToString:@"003_16"]||[curNodecode isEqualToString:@"005_04"])
    {
        return @"已逾期";
    }else if([curNodecode isEqualToString:@"003_07"] ||[curNodecode isEqualToString:@"005_03"]){
        return @"已结清";
    }else{
        return @"已结清";
    }
    
    
}


@end
