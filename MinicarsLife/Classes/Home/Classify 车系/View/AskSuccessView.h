//
//  AskSuccessView.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/18.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol BackToHomeDelegate <NSObject>

-(void)BackToHomeClick;

@end

@interface AskSuccessView : UIView
@property (nonatomic,weak) id<BackToHomeDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
