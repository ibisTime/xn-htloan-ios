//
//  DetailsView.h
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/5.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsView : UIView<UIScrollViewDelegate>

@property (nonatomic , strong)NSString *url;
@property (nonatomic , strong)UIScrollView *scrollView;
@property (nonatomic , strong)UIImageView *imageView;
@end

NS_ASSUME_NONNULL_END
