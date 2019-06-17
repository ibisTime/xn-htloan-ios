//
//  MoblePhoneCodeVC.m
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/15.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MoblePhoneCodeVC.h"
#import "ClaimsTableView.h"

@interface MoblePhoneCodeVC ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) MyModel *model;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MoblePhoneCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫码二维码";
//    [self initTableView];
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 10, 200, 200)];
    image1.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:image1];
    image1.image = self.imageData;
    if (self.isJD == YES) {
        [TLAlert alertWithInfo:@"请使用手机京东扫描登录"];

    }else{
        

    }
    
    [self sure];
    [self.view endEditing:YES];

}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.isEC==YES) {
        [TLAlert alertWithInfo:@"请使用手机淘宝扫描登录"];

    }
    [super viewWillAppear:animated];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    NSLog(@"点击确认");
}

- (void)sure
{
    UITextField *textFid1 = [self.view viewWithTag:100];
    
//    if ([textFid1.text isEqualToString:@""]) {
//        [TLAlert alertWithInfo:@"请输入验证码"];
//        return;
//    }
    if (self.isEC == YES) {
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
    }else{
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
    
}

- (void)refreshAds
{
    [TLAlert alertWithMsg:@"认证中,请稍后"];

    if (self.isEC == YES) {
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
    }else{
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
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.timer invalidate];
    
    self.timer = nil;
    [super viewWillDisappear:animated];
    
    
}

- (void)initTableView {
    self.tableView = [[ClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.isCode = YES;
    
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
