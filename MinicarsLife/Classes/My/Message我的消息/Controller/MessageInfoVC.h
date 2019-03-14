//
//  MessageInfoVC.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "MessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageInfoVC : BaseViewController
@property (nonatomic,strong) NSString * code;
@property (nonatomic,strong) MessageModel * model;
@end

NS_ASSUME_NONNULL_END
