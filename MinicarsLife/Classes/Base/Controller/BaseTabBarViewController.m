//
//  BaseTabBarViewController.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/27.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "HomeViewController.h"
#import "ReimbursementViewController.h"
#import "MyViewController.h"
#import "CarNewsVC.h"
#import "AfterSaleVC.h"
#import "InstallmentVC.h"
#import "InsuranceVC.h"

@interface BaseTabBarViewController ()<UITabBarControllerDelegate>
@property (nonatomic,assign) NSInteger index;
@end

@implementation BaseTabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self createTabBar];

}
- (void)createTabBar{
    NSString *ISSHELVES = [[NSUserDefaults standardUserDefaults]objectForKey:@"ISSHELVES"];
    if ([ISSHELVES isEqualToString:ISSHELVESSTR]) {
        [self createControllerWithTitle1:@"玩汽车" image:@"玩汽车-未点击" selectedimage:@"玩汽车-点击" className:[HomeViewController class]];
        [self createControllerWithTitle1:@"玩售后" image:@"玩售后-未点击" selectedimage:@"玩售后-点击" className:[AfterSaleVC class]];
        [self createControllerWithTitle1:@"玩会员" image:@"玩会员-未点击"selectedimage:@"玩会员-点击" className:[MyViewController class]];
    }
    else
    {
        [self createControllerWithTitle1:@"玩分期" image:@"玩分期-未点击"selectedimage:@"玩分期-点击" className:[InstallmentVC class]];
        [self createControllerWithTitle1:@"玩保险" image:@"玩保险-未点击"selectedimage:@"玩保险-点击" className:[InsuranceVC class]];
        [self createControllerWithTitle1:@"玩汽车" image:@"玩汽车-未点击" selectedimage:@"玩汽车-点击" className:[HomeViewController class]];
        [self createControllerWithTitle1:@"玩售后" image:@"玩售后-未点击" selectedimage:@"玩售后-点击" className:[AfterSaleVC class]];
        [self createControllerWithTitle1:@"玩会员" image:@"玩会员-未点击"selectedimage:@"玩会员-点击" className:[MyViewController class]];
    }

}

//提取公共方法
- (void)createControllerWithTitle1:(NSString *)title image:(NSString *)image selectedimage:(NSString *)selectedimage  className:(Class)class{

    UIViewController *vc = [[class alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedimage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];

    nav.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:MainColor, NSForegroundColorAttributeName,
                                                       nil,nil] forState:UIControlStateSelected];
}



- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UIViewController*)viewController

{
    
    
    NSString *ISSHELVES = [[NSUserDefaults standardUserDefaults]objectForKey:@"ISSHELVES"];
    if ([ISSHELVES isEqualToString:ISSHELVESSTR]) {
        if (viewController ==self.viewControllers[2]) {
            if([USERXX user].isLogin == NO) {
                LoginViewController *vc = [[LoginViewController alloc]init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
                [rootViewController presentViewController:nav animated:YES completion:nil];
                return NO;
            }else
            {
                return YES;
            }
        }
    }else
    {
        if (viewController ==self.viewControllers[4]) {
            if([USERXX user].isLogin == NO) {
                LoginViewController *vc = [[LoginViewController alloc]init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
                [rootViewController presentViewController:nav animated:YES completion:nil];
                return NO;
            }else
            {
                return YES;
            }
        }
    }
    
    
    return YES;


}



// 点击tabbarItem自动调用
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != _index) {
//        [self animationWithIndex:index];
        _index = index;
    }
}
//- (void)animationWithIndex:(NSInteger) index {
//
//    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            [tabbarbuttonArray addObject:tabBarButton];
//        }
//    }
//    /**
//     CABasicAnimation类的使用方式就是基本的关键帧动画。
//     所谓关键帧动画，就是将Layer的属性作为KeyPath来注册，指定动画的起始帧和结束帧，然后自动计算和实现中间的过渡动画的一种动画方式。
//     */
//    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//
//    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    pulse.duration = 0.2;
//    pulse.repeatCount= 1;
//    pulse.autoreverses= YES;
//    pulse.fromValue= [NSNumber numberWithFloat:0.7];
//    pulse.toValue= [NSNumber numberWithFloat:1.3];
//    [[tabbarbuttonArray[index] layer]
//     addAnimation:pulse forKey:nil];
//
//
//
//}

@end
