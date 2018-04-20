//
//  AppDelegate+Launch.h
//  b2c_user_ios
//
//  Created by XI on 2016/3/13.
//  Copyright © 2017年 XI. All rights reserved.
//

#import "AppDelegate.h"


typedef NS_ENUM(NSUInteger, LaunchOption) {
    LaunchOptionGuide,
    LaunchOptionLogin,
};


@interface AppDelegate (Launch)


- (void)launchEventWithCompletionHandle:(void (^) (LaunchOption launchOption))handle;




@end
