//
//  JingDongVC.m
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/15.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "JingDongVC.h"
#import "ClaimsTableView.h"
#import "MoblePhoneCodeVC.h"
@interface JingDongVC ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) MyModel *model;
@property (nonatomic ,copy) NSString *id;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation JingDongVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initTableView];
    self.title = @"京东";
    [self sure];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    NSLog(@"点击确认");
    [self sure];
    [self.view endEditing:YES];

}

- (void)sure
{
    UITextField *textFid1 = [self.view viewWithTag:100];
    UITextField *textFid2 = [self.view viewWithTag:101];
    UITextField *textFid3 = [self.view viewWithTag:102];
//    if ([textFid1.text isEqualToString:@""]) {
//        [TLAlert alertWithInfo:@"请输入身份证号"];
//        return;
//    }
//    if ([textFid2.text isEqualToString:@""]) {
//        [TLAlert alertWithInfo:@"请输入姓名"];
//        return;
//    }
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632931";
    
    //    http1.showView = weakSelf.view;
    //    http1.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    NSString *idno =  [USERDEFAULTS objectForKey:IDNO];
    http1.parameters[@"idNo"] = idno;
    http1.parameters[@"loginType"] = @"qr";
    http1.parameters[@"idNo"] = idno;
    http1.parameters[@"username"] = @"admin";
    http1.parameters[@"password"] = @"111111";
    http1.parameters[@"customerName"] =[USERDEFAULTS objectForKey:NAME];

    [http1 postWithSuccess:^(id responseObject) {
        NSString *data = responseObject[@"data"][@"result"];
        self.id = responseObject[@"data"][@"id"];

        NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
        //        NSString * jsonString = @"";
        NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        [NSThread sleepForTimeInterval:2];

        if (dic[@"token"]) {
            [self statesCheck:dic[@"token"]];
            
            return ;
        }
        
        if (dic[@"msg"]) {
            [TLAlert alertWithInfo:dic[@"msg"]];
            return ;
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)statesCheck: (NSString *)token
{
    
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632944";
    
    //    http1.showView = weakSelf.view;
    //    http1.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    MJWeakSelf;
    http1.parameters[@"bizType"] = @"jd";

    http1.parameters[@"tokendb"] = token;
    [http1 postWithSuccess:^(id responseObject) {
        NSString *data = responseObject[@"data"];
        NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
        //        NSString * jsonString = @"";
        NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSString *image = dic[@"input"][@"value"];
        NSLog(@"第二次接口");
        if (image == nil) {
//            [TLAlert alertWithInfo:@"链接超时"];
            [self statesCheck:token];
            return ;
        }
        // 将base64字符串转为NSData
        NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:image options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
        // 将NSData转为UIImage
        UIImage *decodedImage = [UIImage imageWithData: decodeData];
        UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 50, 200, 200)];
        image1.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:image1];
        //        image1.image = decodedImage;
        MoblePhoneCodeVC *vc = [MoblePhoneCodeVC new];
//        vc.isEC = YES;
        vc.isJD = YES;

        vc.imageData = decodedImage;
        vc.id = self.id;
      
        image1.image = decodedImage;
        [TLAlert alertWithMsg:@"请使用手机京东扫码登录"];
        [self sureLoad];
    } failure:^(NSError *error) {
        
    }];
    
}
- (void)sureLoad
{
    UITextField *textFid1 = [self.view viewWithTag:100];
    
  
        TLNetworking *http1 = [TLNetworking new];
        http1.code = @"632948";
        
        http1.parameters[@"id"] = self.id;
        
        [http1 postWithSuccess:^(id responseObject) {
            
            NSString *data = responseObject[@"data"][@"status"];
            if ([data isEqualToString:@"2"]) {
                [TLAlert alertWithInfo:@"已认证"];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                self.timer = [NSTimer scheduledTimerWithTimeInterval:5
                                                              target:self
                                                            selector:@selector(refreshAds)
                                                            userInfo:nil
                                                             repeats:YES];
                
            }
            
        } failure:^(NSError *error) {
            
        }];
  
    
}

- (void)refreshAds
{
    [TLAlert alertWithMsg:@"认证中,请稍后"];
    
    
        TLNetworking *http1 = [TLNetworking new];
        http1.code = @"632948";
        
        http1.parameters[@"id"] = self.id;
        
        [http1 postWithSuccess:^(id responseObject) {
            
            NSString *data = responseObject[@"data"][@"status"];
            if ([data isEqualToString:@"2"] ) {
                [TLAlert alertWithInfo:@"认证成功"];
                [self.timer invalidate];
                
                self.timer = nil;
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }
            
        } failure:^(NSError *error) {
            
        }];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.timer setFireDate:[NSDate distantFuture]];
    [self.timer invalidate];
    self.timer = nil;
    [super viewWillDisappear:animated];
    
    
}
-(void)dealloc{
    
    [self.timer invalidate];
    self.timer = nil;
}
- (void)initTableView {
    self.tableView = [[ClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.isTD = YES;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
