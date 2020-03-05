//
//  FaceSignView.h
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/5.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FaceSignView : UIView
@property (nonatomic , strong)UIButton *cancelBtn;
@property (nonatomic , strong)UIButton *confirmBtn;
@property (nonatomic , strong)UITextField *roomNumberTF;

@end

NS_ASSUME_NONNULL_END