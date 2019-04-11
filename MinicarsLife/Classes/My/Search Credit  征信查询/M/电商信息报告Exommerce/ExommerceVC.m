//
//  ExommerceVC.m
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/16.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ExommerceVC.h"
#import "ClaimsTableView.h"
#import "MoblePhoneCodeVC.h"
#import "UIView+Frame.h"
@interface ExommerceVC ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) MyModel *model;
@property (nonatomic ,copy) NSString *id;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ExommerceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电商报告采集";
    [self initTableView];
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
   

    if ([textFid1.text isEqualToString:@""]) {
        [TLProgressHUD showInfoWithStatus:@"请输入身份证号"];
        return;
    }
    if ([textFid2.text isEqualToString:@""]) {
        [TLProgressHUD showInfoWithStatus:@"请输入姓名"];
        return;
    }
    if ([textFid3.text isEqualToString:@""]) {
        [TLProgressHUD showInfoWithStatus:@"请输入手机号"];
        return;
    }
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632939";
    
    //    http1.showView = weakSelf.view;
    //    http1.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    
    http1.parameters[@"identityCardNo"] = textFid1.text;
    http1.parameters[@"identityName"] = textFid2.text;
    
    http1.parameters[@"username"] = textFid3.text;
    http1.parameters[@"loginType"] = @"qr";
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
            [TLProgressHUD showInfoWithStatus:dic[@"msg"]];
            return ;
        }
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)statesCheck: (NSString *)token
{
    
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632940";
    
    //    http1.showView = weakSelf.view;
    //    http1.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    MJWeakSelf;
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
            [TLProgressHUD showInfoWithStatus:@"链接超时"];
            
            return ;
        }
        // 将base64字符串转为NSData
        NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:image options:NSDataBase64DecodingIgnoreUnknownCharacters];
        // 将NSData转为UIImage
        UIImage *decodedImage = [UIImage imageWithData: decodeData];
       
//        image1.image = decodedImage;
        MoblePhoneCodeVC *vc = [MoblePhoneCodeVC new];
        vc.isEC = YES;
        vc.imageData = decodedImage;
        vc.id = self.id;
        UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 250, 200, 200)];
        image2.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:image2];
        image2.image = decodedImage;
        [TLAlert alertWithMsg:@"请使用手机淘宝扫码授权"];

        [self sureLoad];
//        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSError *error) {
        
    }];
    
}
- (void)sureLoad
{
    UITextField *textFid1 = [self.view viewWithTag:100];
    
    //    if ([textFid1.text isEqualToString:@""]) {
    //        [TLAlert alertWithInfo:@"请输入验证码"];
    //        return;
    //    }
        TLNetworking *http1 = [TLNetworking new];
        http1.code = @"632948";
        
        http1.parameters[@"id"] = self.id;
        
        [http1 postWithSuccess:^(id responseObject) {
            
            NSString *data = responseObject[@"data"][@"status"];
            if ([data isEqualToString:@"2"]) {
                [TLAlert alertWithInfo:@"认证成功"];
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
            if ([data isEqualToString:@"2"]) {
                [TLAlert alertWithInfo:@"认证成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
                [self.timer invalidate];
                
                self.timer = nil;
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
    self.tableView.isDian = YES;
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
