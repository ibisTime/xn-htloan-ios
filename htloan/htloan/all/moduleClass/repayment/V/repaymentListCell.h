//
//  repaymentListCell.h
//  htloan
//
//  Created by apple on 2018/4/27.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "repaymentModel.h"
@interface repaymentListCell : BaseTableViewCell
//是否最近还款
@property (nonatomic, assign) BOOL isNewRepayment;

//
@property (nonatomic, strong) repaymentModel *repaymentModel;
@end
