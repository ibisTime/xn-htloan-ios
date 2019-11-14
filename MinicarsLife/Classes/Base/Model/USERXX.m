//
//  USERXX.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "USERXX.h"

@implementation USERXX


+ (instancetype)user{

    static USERXX *user = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{

        user = [[USERXX alloc] init];

    });

    return user;
}

- (void)setToken:(NSString *)token {

    _token = [token copy];
    [USERDEFAULTS objectForKey:TOKEN_ID];
    [USERDEFAULTS synchronize];
}

- (void)setUserId:(NSString *)userId {

    _userId = [userId copy];
    [USERDEFAULTS objectForKey:USER_ID];
    [USERDEFAULTS synchronize];
}

-(void)setNickname:(NSString *)nickname
{
    _nickname = [nickname copy];
    [USERDEFAULTS objectForKey:NICKNAME];
    [USERDEFAULTS synchronize];
}

-(void)setIdNo:(NSString *)idNo
{
    _idNo = [_idNo copy];
    [USERDEFAULTS objectForKey:idNo];
    [USERDEFAULTS synchronize];
    
}
-(void)setMobile:(NSString *)mobile
{
    _mobile = [mobile copy];
    [USERDEFAULTS objectForKey:MOBILE];
    [USERDEFAULTS synchronize];
}

- (BOOL)isLogin {
    NSString *userId = [USERDEFAULTS objectForKey:USER_ID];
    NSString *token = [USERDEFAULTS objectForKey:TOKEN_ID];
    NSLog(@"%@===%@",userId,token);
    if ([USERXX isBlankString:userId] == NO && [USERXX isBlankString:token] == NO) {

        self.userId = userId;
        self.token = token;

        return YES;
    } else {

        return NO;
    }
}

- (void)updateUserInfoWithNotification
{
    TLNetworking *http = [TLNetworking new];

    http.isShowMsg = NO;
    http.code = USER_INFO;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"token"] = [USERDEFAULTS objectForKey:TOKEN_ID];

    [http postWithSuccess:^(id responseObject) {

        [self setUserInfoWithDict:responseObject[@"data"]];

//        [self saveUserInfo:responseObject[@"data"]];
    } failure:^(NSError *error) {

    }];



}

+(NSString *)AddSymbols:(CGFloat)price
{
    if (price > 100000000) {
        return [NSString stringWithFormat:@"%.2f亿",price/100000000];
    }
    if (price > 10000) {
        return [NSString stringWithFormat:@"%.2f万",price/10000];
    }
    return [NSString stringWithFormat:@"%.2f",price];
}



- (void)setUserInfoWithDict:(NSDictionary *)dict {
    [USERDEFAULTS setObject:dict[@"mobile"] forKey:MOBILE];
    [USERDEFAULTS setObject:dict[@"nickname"] forKey:NICKNAME];
    [USERDEFAULTS setObject:dict[@"photo"] forKey:PHOTO];
    [USERDEFAULTS setObject:dict[@"tradepwdFlag"] forKey:PAYPASSWORD];
    [USERDEFAULTS setObject:dict[@"idNo"] forKey:IDNO];
    [USERDEFAULTS setObject:dict[@"realName"] forKey:NAME];

}

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL)
    {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    return NO;
}
- (void)showPopAnimationWithAnimationStyle:(NSInteger)style showView:(UIView *)showView BGAlpha:(CGFloat )alpha isClickBGDismiss:(BOOL)dismiss
{
    ZJAnimationPopStyle popStyle = (style == 8) ? ZJAnimationPopStyleCardDropFromLeft : (ZJAnimationPopStyle)style;
    ZJAnimationDismissStyle dismissStyle = (ZJAnimationDismissStyle)style;
    // 1.初始化
    ZJAnimationPopView *_popView = [[ZJAnimationPopView alloc] initWithCustomView:showView popStyle:popStyle dismissStyle:dismissStyle];
    self.cusPopView = _popView;
    //    _popView.isClickBGDismiss = [showView isKindOfClass:[UIView class]];
    //    移除
    _popView.isClickBGDismiss = dismiss;
    // 2.2 显示时背景的透明度
    _popView.popBGAlpha = alpha;
    
    // 2.3 显示时是否监听屏幕旋转
    _popView.isObserverOrientationChange = YES;
    // 2.6 显示完成回调
    _popView.popComplete = ^{
        NSLog(@"显示完成");
    };
    // 2.7 移除完成回调
    _popView.dismissComplete = ^{
        NSLog(@"移除完成");
    };
    // 4.显示弹框
    [_popView pop];
}

//查询未读消息条数
+(void)QueriesNumberOfUnreadMessageBars
{
    if ([USERDEFAULTS objectForKey:TOKEN_ID]) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"805309";
        http.parameters[@"token"] = [USERDEFAULTS objectForKey:TOKEN_ID];
        [http postWithSuccess:^(id responseObject) {
            [USERDEFAULTS setObject:responseObject[@"data"] forKey:@"unreadnumber"];
            [[XGPush defaultManager] setXgApplicationBadgeNumber:[responseObject[@"data"] integerValue]];
        } failure:^(NSError *error) {
            
        }];
        
    }
}

+ (NSString*)convertNull:(id)object{
    
    // 转换空串
    
    if ([object isEqual:[NSNull null]]) {
        return @"";
    }
    else if ([object isEqualToString:@""])
    {
        return @"";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if ([object isEqualToString:@"(null)"])
    {
        return @"";
    }
    else if (object==nil){
        return @"";
    }
    else if ([object isEqualToString:@"0.00"]){
        return @"";
    }
    
    return object;
    
}
@end
