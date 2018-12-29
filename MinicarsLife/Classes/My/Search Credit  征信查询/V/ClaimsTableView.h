//
//  ClaimsTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "MyModel.h"
@interface ClaimsTableView : TLTableView
@property (nonatomic ,strong) MyModel *model;

@property (nonatomic ,assign) BOOL  isBank;

@property (nonatomic ,assign) BOOL  isShe;

@property(nonatomic, copy)  void (^ChooseBlock)();


@end
