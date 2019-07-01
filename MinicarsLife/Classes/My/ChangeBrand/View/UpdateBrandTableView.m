//
//  UpdateBrandTableView.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/6/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "UpdateBrandTableView.h"

@implementation UpdateBrandTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
@end
