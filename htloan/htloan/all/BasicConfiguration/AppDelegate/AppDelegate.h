//
//  AppDelegate.h
//  ljs
//
//  Created by XI on 2017/7/13.
//  Copyright © 2017年 XI. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
//#import "JPushModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) CLLocationManager *locationManage;

@property (nonatomic, assign) CLLocationCoordinate2D myCoordinate;
//极光
//@property (nonatomic, strong) JPushModel *model;

@end

