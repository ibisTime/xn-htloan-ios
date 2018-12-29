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

@property (nonatomic ,assign) BOOL  isCoin;

@property (nonatomic ,assign) BOOL  isTD;//淘宝京东

@property (nonatomic ,assign) BOOL  isPlace;

@property (nonatomic ,assign) BOOL  isMobleInformation;

@property (nonatomic ,assign) BOOL  isCode;

@property (nonatomic ,assign) BOOL  isDian;

@property (nonatomic ,assign) BOOL  isPhoneShow;


@property(nonatomic, copy)  void (^ChooseBlock)();
@property(nonatomic, copy)  void (^ScrolleWBlock)();

@property (nonatomic ,copy) NSString  *chooseText;
@property (nonatomic ,copy) NSString  *city;
@property (nonatomic ,copy) NSString  *type;


@end
