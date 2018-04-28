//
//  stagingTableView.h
//  htloan
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "TLTableView.h"
@class  stagingModel;
@interface stagingTableView : TLTableView
@property( strong,nonatomic)NSMutableArray<stagingModel*> *stagings;
@end
