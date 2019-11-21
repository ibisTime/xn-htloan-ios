//
//  AppDelegate.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/27.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "GuideView.h"
#import "ViewController.h"
#import "TLWXManager.h"
#import "NSObject+Tool.h"

#import "NewsInfoVC.h"
#import "CarInfoVC.h"
#import "MessageInfoVC.h"
#import "MessageModel.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<XGPushDelegate,UNUserNotificationCenterDelegate>
@property (nonatomic , assign)BOOL isLaunchedByNotification;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"1080" ofType:@"png"];
    NSLog(@"%@",jsonPath);

    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //当前版本号
    
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前版本号%@",currentVersion);
    
    
    // 需要下载腾讯云实施音视频SDK 方能正常跑通项目 ILiveSDK 
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    [USERXX QueriesNumberOfUnreadMessageBars];
    [self XGPushSetUp];
    

//    [self registerAPNS];
    //为了更好的了解每一条推送消息的运营效果，需要将用户对消息的行为上报
    [[XGPush defaultManager] reportXGNotificationInfo:launchOptions];
    if (launchOptions) {
        self.isLaunchedByNotification = YES;

        BaseTabBarViewController *TabBarVC = [[BaseTabBarViewController alloc]init];
        self.window.rootViewController = TabBarVC;
        
        NSDictionary *pushNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//        [self performSelector:@selector(receiveRemoteNotificationWithUserInfo:) withObject:pushNotificationKey afterDelay:2.0];
        
    }else{
        self.isLaunchedByNotification = NO;
        GuideView *guideView = [[GuideView alloc]init];
        self.window.rootViewController = guideView;
        [self.window makeKeyAndVisible];
    }
    
    [WXApi registerApp:@"wx14ce9b413e063005"
         universalLink:@"https://share.ios.fhcdzx.com/"];
    
    return YES;
}


-(void)XGPushSetUp
{
    
    //    信鸽推送
    [[XGPush defaultManager] setEnableDebug:YES];
    [[XGPush defaultManager] startXGWithAppID:2200341534 appKey:@"I4A92YVD11HI"  delegate:self];
    //角标设置
    //    [[XGPush defaultManager] setXgApplicationBadgeNumber:4];
    
    //    在通知消息中创建一个可以点击的事件行为
    XGNotificationAction *action1 = [XGNotificationAction actionWithIdentifier:@"xgaction001" title:@"xgAction1" options:XGNotificationActionOptionNone];
    XGNotificationAction *action2 = [XGNotificationAction actionWithIdentifier:@"xgaction002" title:@"xgAction2" options:XGNotificationActionOptionNone];
    
    
    XGNotificationCategory *category = [XGNotificationCategory categoryWithIdentifier:@"xgCategory" actions:@[action1, action2] intentIdentifiers:@[] options:XGNotificationCategoryOptionNone];
    XGNotificationConfigure *configure = [XGNotificationConfigure configureNotificationWithCategories:[NSSet setWithObject:category] types:XGUserNotificationTypeAlert|XGUserNotificationTypeBadge|XGUserNotificationTypeSound];
    
    [[XGPush defaultManager] setNotificationConfigure:configure];
    
    //    上报角标s
    NSInteger number;
    if ([USERDEFAULTS objectForKey:USER_ID]) {
//        [[XGPush defaultManager] setXgApplicationBadgeNumber:[ integerValue]]
        number = [[USERDEFAULTS objectForKey:@"unreadnumber"] integerValue];
    }else
    {
        number = 0;
    }
    
    [[XGPush defaultManager] setBadge:number];
}



- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    //将来需要将此Token上传给后台服务器
    NSString *XGPushtokenStr = [[XGPushTokenManager defaultTokenManager] deviceTokenString];
    NSLog(@"XGPushtokenStr===>%@",XGPushtokenStr);
    
}





- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"%s======》",__func__);
    
    NSString *zero =[[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"body"];
    if (application.applicationState == UIApplicationStateActive) {
//        [self showAlertViewWithTitle:@"新消息提示" Message:zero ConfirmTitle:@"确定" CancelTitle:nil];
    }
//    [self receiveRemoteNotificationWithUserInfo:userInfo];

}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"%s",__func__);
    
    NSLog(@"[XGDemo] receive slient Notification");
    NSLog(@"[XGDemo] userinfo %@", userInfo);
    
    if (self.isLaunchedByNotification == NO) {
        if (application.applicationState == UIApplicationStateActive) {
            //iOS10之前，在前台时用自定义AlertView展示消息
            [self receiveRemoteNotificationWithUserInfo:userInfo];
        }else {
            [self receiveRemoteNotificationWithUserInfo:userInfo];
        }
    }else{
        self.isLaunchedByNotification = NO;
    }
    
    //iOS 9.x 及以前，需要在 UIApplicationDelegate 的回调方法(如下)中调用上报数据的接口
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);

}


//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
    //可设置是否在应用内弹出通知
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}


//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s",__func__);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
    //处理接收到的消息

    [self receiveRemoteNotificationWithUserInfo:response.notification.request.content.userInfo];
    [[XGPush defaultManager] reportXGNotificationResponse:response];
    completionHandler();
}

-(void)receiveRemoteNotificationWithUserInfo:(NSDictionary *)dic
{

    UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = tbc.viewControllers[tbc.selectedIndex];

    
    if ([dic[@"custom"][@"key1"] isEqualToString:@"1"] || [dic[@"custom"][@"key1"] isEqualToString:@"3"]) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"805307";
//        http.showView = self.view;
        http.parameters[@"code"] = dic[@"custom"][@"key2"];
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        [http postWithSuccess:^(id responseObject) {
            MessageInfoVC * vc = [MessageInfoVC new];
            vc.model = [MessageModel mj_objectWithKeyValues:responseObject[@"data"]];
            vc.hidesBottomBarWhenPushed = YES;
            
            [nav pushViewController:vc animated:YES];
        } failure:^(NSError *error) {
            
        }];
    }
    if ([dic[@"custom"][@"key1"] isEqualToString:@"2"]) {
        NewsInfoVC *vc = [NewsInfoVC new];
        vc.code = dic[@"custom"][@"key2"];
        vc.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:vc animated:YES];
    }

    if ([dic[@"custom"][@"key1"] isEqualToString:@"4"]) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630427";
//        http.showView = self.view;
        http.parameters[@"code"] = dic[@"custom"][@"key2"];
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        [http postWithSuccess:^(id responseObject) {
            CarInfoVC * vc = [CarInfoVC new];
            vc.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
            vc.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:vc animated:YES];
        } failure:^(NSError *error) {
            
        }];
    }

//    [[XGPush defaultManager] setXgApplicationBadgeNumber:[[USERDEFAULTS objectForKey:@"unreadnumber"] integerValue] - 1];
    
}




- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler
{
    NSLog(@"userActivity : %@",userActivity.webpageURL.description);
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *webpageURL = userActivity.webpageURL;
        NSString *host = webpageURL.host;
        //        if ([host isEqualToString:@"yohunl.com"]) {
        //            //进行我们需要的处理
        //        }
        //        else {
        //            [[UIApplication sharedApplication]openURL:webpageURL];
        //        }
    }
    
    return YES;
    
}


// iOS9 NS_AVAILABLE_IOS
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [WXApi handleOpenURL:url delegate:[TLWXManager manager]];
}

// iOS9 NS_DEPRECATED_IOS
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [WXApi handleOpenURL:url delegate:[TLWXManager manager]];
}




//推送token传给服务器
- (void)xgPushDidRegisteredDeviceToken:(nullable NSString *)deviceToken error:(nullable NSError *)error;
{
    if ([USERXX user].isLogin == YES) {
        if (![[USERDEFAULTS objectForKey:@"deviceToken"] isEqualToString:deviceToken]) {
            TLNetworking * http = [[TLNetworking alloc]init];
            http.code = @"805085";
            http.parameters[@"deviceToken"] = deviceToken;
            http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
            [http postWithSuccess:^(id responseObject) {
                [USERDEFAULTS setObject:deviceToken forKey:@"deviceToken"];
            } failure:^(NSError *error) {
                
            }];
        }
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
