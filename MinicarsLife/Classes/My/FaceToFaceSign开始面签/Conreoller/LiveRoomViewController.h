//
//  LiveRoomViewController.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import <ILiveSDK/ILiveCoreHeader.h>


@interface LiveRoomViewController : BaseViewController<ILiveMemStatusListener, ILiveRoomDisconnectListener>

@end
