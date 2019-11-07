//
//  PlatCarVideoCell.h
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/6.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayCarVideoModel.h"
#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"
NS_ASSUME_NONNULL_BEGIN
@protocol VideoBtn <NSObject>


-(void)clickVideo:(NSInteger)inter;

@end
@interface PlatCarVideoCell : UITableViewCell
@property (nonatomic,weak) id<VideoBtn> delegate;
@property (nonatomic ,strong)PlayCarVideoModel *model;
@property (nonatomic, strong) SelVideoPlayer *player;
@property (nonatomic , assign)NSInteger row;



@end

NS_ASSUME_NONNULL_END
