//
//  BrandTableView.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/18.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BrandTableView : TLTableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray * indexArray;
@end

NS_ASSUME_NONNULL_END
