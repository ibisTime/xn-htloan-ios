//
//  repaymentListV.h
//  htloan
//
//  Created by apple on 2018/4/27.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "TLTableView.h"
#import "repaymentModel.h"
@interface repaymentListV : TLTableView
//是否最近还款
@property (nonatomic, assign) BOOL isNewRepayment;
//
@property (nonatomic, strong) NSArray <repaymentModel *>*news;
@end
