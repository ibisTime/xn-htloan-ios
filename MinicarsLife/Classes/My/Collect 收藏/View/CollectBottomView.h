//
//  CollectBottomView.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectBottomView : UIView
/**
 全选按钮
 */
@property (nonatomic ,strong) UIButton *allBtn;


/**
 标记已读按钮
 */
//@property (nonatomic ,strong) UIButton *readBtn;


/**
 删除按钮
 */
@property (nonatomic ,strong) UIButton *deleteBtn;

@end

NS_ASSUME_NONNULL_END
