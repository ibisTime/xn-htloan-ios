//
//  CollectBottomView.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CollectBottomView.h"

@implementation CollectBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.allBtn];
        self.backgroundColor = kWhiteColor;
//        [self addSubview:self.readBtn];
        [self addSubview:self.deleteBtn];
    }
    return self;
}

- (UIButton *)allBtn{
    if (!_allBtn) {
        self.allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allBtn.frame = CGRectMake(10, 0, 40, self.bounds.size.height);
        _allBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_allBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _allBtn;
}


//- (UIButton *)readBtn{
//    if (!_readBtn) {
//        self.readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _readBtn.frame = CGRectMake((self.bounds.size.width - 70)/2, 0, 70, self.bounds.size.height);
//        _readBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [_readBtn setTitle:@"标记已读" forState:UIControlStateNormal];
//        [_readBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    }
//    return _readBtn;
//}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
//        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.deleteBtn = [[UIButton alloc]init];
        _deleteBtn = [UIButton buttonWithTitle:@"删除" titleColor:kWhiteColor backgroundColor:MainColor titleFont:16 cornerRadius:2];
        _deleteBtn.frame = CGRectMake(self.bounds.size.width - 90, 10, 75, 32);
//        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//        [_deleteBtn setBackgroundColor:MainColor forState:(UIControlStateNormal)];
//        [_deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        kViewRadius(_deleteBtn, 2);
    }
    return _deleteBtn;
}

@end
