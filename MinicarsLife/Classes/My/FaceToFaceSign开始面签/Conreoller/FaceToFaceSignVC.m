//
//  FaceToFaceSignVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/8/9.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "FaceToFaceSignVC.h"

@interface FaceToFaceSignVC ()
{
    NSInteger number;
    //    ILiveRenderView *renderView1;
    CGRect rect;
    CGRect rect1;

}
@property (nonatomic, strong) UIAlertController *alertCtrl;

@end

@implementation FaceToFaceSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"面签";
    [self detectAuthorizationStatus];

    [[ILiveRoomManager getInstance] enableCamera:CameraPosFront enable:YES succ:^{
        NSLog(@"打开摄像头成功");
    } failed:^(NSString *module, int errId, NSString *errMsg) {
        NSLog(@"打开摄像头失败");
    }];

    [[ILiveRoomManager getInstance] enableMic:YES succ:^{
        NSLog(@"打开麦克风成功");
    } failed:^(NSString *module, int errId, NSString *errMsg) {
        NSLog(@"打开麦克风失败");
    }];
}

#pragma mark - Accessor
- (UIAlertController *)alertCtrl {
    if (!_alertCtrl) {
        _alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }] ;
        [_alertCtrl addAction:action];
    }
    return _alertCtrl;
}

#pragma mark - Custom Method
// 检测音视频权限
- (void)detectAuthorizationStatus {
    // 检测是否有摄像头权限
    AVAuthorizationStatus statusVideo = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (statusVideo == AVAuthorizationStatusRestricted || statusVideo == AVAuthorizationStatusDenied) {
        self.alertCtrl.message = @"获取摄像头权限失败，请前往隐私-麦克风设置里面打开应用权限";
        [self presentViewController:self.alertCtrl animated:YES completion:nil];
        return;
    } else if (statusVideo == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {

        }];
    }

    // 检测是否有麦克风权限
    AVAuthorizationStatus statusAudio = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (statusAudio == AVAuthorizationStatusRestricted || statusAudio == AVAuthorizationStatusDenied) {
        self.alertCtrl.message = @"获取麦克风权限失败，请前往隐私-麦克风设置里面打开应用权限";
        [self presentViewController:self.alertCtrl animated:YES completion:nil];
        return;
    } else if (statusAudio == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {

        }];
    }
}

// 房间销毁时记得调用退出房间接口
- (void)dealloc {
    [[ILiveRoomManager getInstance] quitRoom:^{
        NSLog(@"退出房间成功");
    } failed:^(NSString *module, int errId, NSString *errMsg) {
        NSLog(@"退出房间失败 %d : %@", errId, errMsg);
    }];
}

// 上/下麦
//- (IBAction)upToVideo:(id)sender {
//    if ([[self.upVideoButton titleForState:UIControlStateNormal] isEqualToString:@"上麦"]) {
//        // 上麦，打开摄像头和麦克风

//
//        [self.upVideoButton setTitle:@"下麦" forState:UIControlStateNormal];
//    } else {
//        // 下麦，关闭摄像头和麦克风
//        [[ILiveRoomManager getInstance] enableCamera:CameraPosFront enable:NO succ:^{
//            NSLog(@"打开摄像头成功");
//        } failed:^(NSString *module, int errId, NSString *errMsg) {
//            NSLog(@"打开摄像头失败");
//        }];
//
//        [[ILiveRoomManager getInstance] enableMic:NO succ:^{
//            NSLog(@"打开麦克风成功");
//        } failed:^(NSString *module, int errId, NSString *errMsg) {
//            NSLog(@"打开麦克风失败");
//        }];
//
//        [self.upVideoButton setTitle:@"上麦" forState:UIControlStateNormal];
//    }
//}

#pragma mark - ILiveMemStatusListener
- (BOOL)onEndpointsUpdateInfo:(QAVUpdateEvent)event updateList:(NSArray *)endpoints {
    if (endpoints.count <= 0) {
        return NO;
    }
    //
    //    NSInteger aaa = 0;
    for (QAVEndpoint *endpoint in endpoints) {
        
        switch (event) {
            case QAV_EVENT_ID_ENDPOINT_HAS_CAMERA_VIDEO:
            {
                /*
                 创建并添加渲染视图，传入userID和渲染画面类型，这里传入 QAVVIDEO_SRC_TYPE_CAMERA（摄像头画面）,
                 */
                
                
                if([endpoint.identifier isEqualToString:[USERDEFAULTS objectForKey:USER_ID]])
                {
                    ILiveFrameDispatcher *frameDispatcher = [[ILiveRoomManager getInstance] getFrameDispatcher];
                    ILiveRenderView *renderView = [frameDispatcher addRenderAt:self.view.bounds forIdentifier:[USERDEFAULTS objectForKey:USER_ID] srcType:QAVVIDEO_SRC_TYPE_CAMERA];
                    [self.view addSubview:renderView];
                    //                    [self.view bringSubviewToFront:renderView];
                    [self.view sendSubviewToBack:renderView];
                }else
                {
                    //                    if (endpoints.count == 1) {
                    //                        number = 0;
                    //                    }
                    if (rect.size.width != 0 && rect1.size.width != 0) {
                        number = 0;
                        ILiveFrameDispatcher *frameDispatcher = [[ILiveRoomManager getInstance] getFrameDispatcher];
                        ILiveRenderView *renderView = [frameDispatcher addRenderAt:CGRectMake(20, 30 +  number * 180, 100, 150) forIdentifier:endpoint.identifier srcType:QAVVIDEO_SRC_TYPE_CAMERA];
                        //                    renderView.tag = 100 + number;
                        [self.view addSubview:renderView];
                        [self.view bringSubviewToFront:renderView];
                        //                    [self.view sendSubviewToBack:renderView];
                        number ++;
                        rect = CGRectMake(0, 0, 0, 0);
                        rect1 = CGRectMake(0, 0, 0, 0);
                    }else
                    {
                        if (rect.size.width != 0) {
                            ILiveFrameDispatcher *frameDispatcher = [[ILiveRoomManager getInstance] getFrameDispatcher];
                            ILiveRenderView *renderView = [frameDispatcher addRenderAt:rect forIdentifier:endpoint.identifier srcType:QAVVIDEO_SRC_TYPE_CAMERA];
                            //                    renderView.tag = 100 + number;
                            [self.view addSubview:renderView];
                            [self.view bringSubviewToFront:renderView];
                            
                            rect = CGRectMake(0, 0, 0, 0);
                            
                            //                    [self.view sendSubviewToBack:renderView];
                            //                        number ++;
                        }else if (rect1.size.width != 0)
                        {
                            ILiveFrameDispatcher *frameDispatcher = [[ILiveRoomManager getInstance] getFrameDispatcher];
                            ILiveRenderView *renderView = [frameDispatcher addRenderAt:rect1 forIdentifier:endpoint.identifier srcType:QAVVIDEO_SRC_TYPE_CAMERA];
                            //                    renderView.tag = 100 + number;
                            [self.view addSubview:renderView];
                            rect1 = CGRectMake(0, 0, 0, 0);
                            [self.view bringSubviewToFront:renderView];
                        }else
                        {
                            ILiveFrameDispatcher *frameDispatcher = [[ILiveRoomManager getInstance] getFrameDispatcher];
                            ILiveRenderView *renderView = [frameDispatcher addRenderAt:CGRectMake(20, 30 +  number * 180, 100, 150) forIdentifier:endpoint.identifier srcType:QAVVIDEO_SRC_TYPE_CAMERA];
                            //                    renderView.tag = 100 + number;
                            [self.view addSubview:renderView];
                            [self.view bringSubviewToFront:renderView];
                            //                    [self.view sendSubviewToBack:renderView];
                            number ++;
                        }
                    }
                    
                    
                    
                    
                    
                }
                
                
                
                
                // 房间内上麦用户数量变化，重新布局渲染视图
                //                [self onCameraNumChange:endpoint.identifier];
                //                if (renderView.frame.size.width < SCREEN_WIDTH && [endpoint.identifier isEqualToString:[USERDEFAULTS objectForKey:USER_ID]] ) {
                //                    NSArray *allRenderViews = [[[ILiveRoomManager getInstance] getFrameDispatcher] getAllRenderViews];
                //
                //
                //                }
                //                    if (allRenderViews.count == 3) {
                //                        [allRenderViews enumerateObjectsUsingBlock:^(ILiveRenderView *renderView, NSUInteger idx, BOOL * _Nonnull stop) {
                //                            if (renderView.frame.size.width < SCREEN_WIDTH && [endpoint.identifier isEqualToString:[USERDEFAULTS objectForKey:USER_ID]] )
                //                            {
                //                                renderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                //                                [self.view sendSubviewToBack:renderView];
                //                            }else{
                //
                //                                [self.view bringSubviewToFront:renderView];
                //                            }
                //
                //                        }];
                //                    }
                
                
                //                }
            }
                break;
            case QAV_EVENT_ID_ENDPOINT_NO_CAMERA_VIDEO:
            {
                
                //                number = 0;
                // 移除渲染视图
                ILiveFrameDispatcher *frameDispatcher = [[ILiveRoomManager getInstance] getFrameDispatcher];
                ILiveRenderView *renderView = [frameDispatcher removeRenderViewFor:endpoint.identifier srcType:QAVVIDEO_SRC_TYPE_CAMERA];
                //                rect = renderView.frame;
                [renderView removeFromSuperview];
                CGRect viewRect = renderView.frame;
                if (renderView.frame.origin.y == 30) {
                    rect = viewRect;
                }
                else
                {
                    rect1 = viewRect;
                }
                //                    if (endpoints.count == 0) {
                //                        number = 0;
                //                        rect = CGRectMake(0, 0, 0, 0);
                //                    }
                // 房间内上麦用户数量变化，重新布局渲染视图
                //                [self onCameraNumChange:@""];
                
                //                if([endpoint.identifier isEqualToString:[USERDEFAULTS objectForKey:USER_ID]])
                //                {
                //                    ILiveFrameDispatcher *frameDispatcher = [[ILiveRoomManager getInstance] getFrameDispatcher];
                //                    ILiveRenderView *renderView = [frameDispatcher addRenderAt:self.view.bounds forIdentifier:[USERDEFAULTS objectForKey:USER_ID] srcType:QAVVIDEO_SRC_TYPE_CAMERA];
                //                    [self.view addSubview:renderView];
                //
                //                    [self.view sendSubviewToBack:renderView];
                //                }else
                //                {
                //
                //                    ILiveFrameDispatcher *frameDispatcher = [[ILiveRoomManager getInstance] getFrameDispatcher];
                //                    ILiveRenderView *renderView = [frameDispatcher addRenderAt:CGRectMake(20, 30 +  number * 180, 100, 150) forIdentifier:endpoint.identifier srcType:QAVVIDEO_SRC_TYPE_CAMERA];
                //                    [self.view addSubview:renderView];
                //                    //                    [self.view sendSubviewToBack:renderView];
                //                    [self.view bringSubviewToFront:renderView];
                ////                    number ++;
                //
                //                }
            }
                break;
            default:
                break;
        }
    }
    
    return YES;
}

// 房间内上麦用户数量变化时调用，重新布局所有渲染视图，
- (void)onCameraNumChange:(NSString*)userID {
    // 获取当前所有渲染视图
    
    
    NSArray *allRenderViews = [[[ILiveRoomManager getInstance] getFrameDispatcher] getAllRenderViews];
    // 检测异常情况
    if (allRenderViews.count == 0) {
        return;
    }
    // 计算并设置每一个渲染视图的frame
    //    CGFloat renderViewHeight = ((SCREEN_HEIGHT - kStatusBarHeight) / allRenderViews.count);
    CGFloat renderViewWidth = SCREEN_WIDTH;
    __block CGFloat renderViewY = 0.f;
    CGFloat renderViewX = 0.f;
    
    if (number == 0) {
        number = allRenderViews.count + 1;
    }
    
    [allRenderViews enumerateObjectsUsingBlock:^(ILiveRenderView *renderView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //        if([renderView.identifier isEqualToString:[USERDEFAULTS objectForKey:USER_ID]])
        //        {
        //            CGRect frame = CGRectMake(renderViewX, renderViewY, renderViewWidth, SCREEN_HEIGHT);
        //            renderView.frame = frame;
        //        }else
        //        {
        //            CGRect frame = CGRectMake(20, 30 + idx % allRenderViews.count * 180, 100, 150);
        //            renderView.frame = frame;
        //            [self.view bringSubviewToFront:renderView];
        //        }
        //        for (int i = 0; i < allRenderViews.count; i ++) {
        if (idx == allRenderViews.count - number) {
            //                return;
            CGRect frame = CGRectMake(renderViewX, renderViewY, renderViewWidth, SCREEN_HEIGHT);
            renderView.frame = frame;
        }else
        {
            CGRect frame = CGRectMake(20, 30 + idx % allRenderViews.count * 180, 100, 150);
            renderView.frame = frame;
            [self.view bringSubviewToFront:renderView];
        }
        
        //        }
        //        if (idx == allRenderViews.count - num + 1) {
        //
        //        }
        
        //        if (allRenderViews.count == 2) {
        //            if (idx == 0) {
        //
        //                CGRect frame = CGRectMake(20, 30, 100, 150);
        //                renderView.frame = frame;
        //                [self.view bringSubviewToFront:renderView];
        //
        //            }else if (idx == 1)
        //            {
        //                renderViewY = 0;
        //
        //                CGRect frame = CGRectMake(renderViewX, renderViewY, renderViewWidth, SCREEN_HEIGHT);
        //                renderView.frame = frame;
        //
        //            }
        //        }
        
        //        if (allRenderViews.count == 3){
        //
        //            if (idx == 0) {
        //
        //
        //                CGRect frame = CGRectMake(20, 30, 100, 150);
        //                renderView.frame = frame;
        //                [self.view bringSubviewToFront:renderView];
        //
        //            }else if (idx == 1)
        //            {
        //
        //                CGRect frame = CGRectMake(20, 210, 100, 150);
        //                renderView.frame = frame;
        //                [self.view bringSubviewToFront:renderView];
        //
        //            }else{
        //
        //                renderViewY = 0;
        //                CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        //                renderView.frame = frame;
        ////                [self.view sendSubviewToBack:renderView];
        //
        //            }
        //
        //        }
        //        if (allRenderViews.count == 1)
        //        {
        //            renderViewY = 0;
        //            CGRect frame = CGRectMake(renderViewX, renderViewY, renderViewWidth, SCREEN_HEIGHT);
        //            renderView.frame = frame;
        //
        //        }
        
        
    }];
}


/**
 SDK主动退出房间提示。该回调方法表示SDK内部主动退出了房间。SDK内部会因为30s心跳包超时等原因主动退出房间，APP需要监听此退出房间事件并对该事件进行相应处理
 
 @param reason 退出房间的原因，具体值见返回码
 
 @return YES 执行成功
 */
- (BOOL)onRoomDisconnect:(int)reason {
    NSLog(@"房间异常退出：%d", reason);
    return YES;
}
#pragma mark - ILiveRoomDisconnectListener
/**
 SDK主动退出房间提示。该回调方法表示SDK内部主动退出了房间。SDK内部会因为30s心跳包超时等原因主动退出房间，APP需要监听此退出房间事件并对该事件进行相应处理
 @param reason 退出房间的原因，具体值见返回码
 @return YES 执行成功
 */



@end
