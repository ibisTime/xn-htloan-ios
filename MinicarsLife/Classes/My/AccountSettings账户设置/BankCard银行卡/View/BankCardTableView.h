//
//  BankCardTableView.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "BankCardModel.h"
@interface BankCardTableView : TLTableView
@property (nonatomic , strong)NSMutableArray <BankCardModel *>*model;
@end
