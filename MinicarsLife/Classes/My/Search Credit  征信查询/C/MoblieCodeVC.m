//
//  MoblieCodeVC.m
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MoblieCodeVC.h"
#import "ClaimsTableView.h"

@interface MoblieCodeVC ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) MyModel *model;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy) NSString *token;

@end

@implementation MoblieCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.title = @"输入验证码";
//    //    [self initTableView];
//
//    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 50, SCREEN_WIDTH-200, 100)];
//    image1.contentMode = UIViewContentModeScaleToFill;
//    [self.view addSubview:image1];
//    image1.image = self.imageData;
//    if (self.isJD == YES) {
//        [TLAlert alertWithInfo:@"请使用手机京东扫描登录"];
//
//    }else{
//
//        [TLAlert alertWithInfo:@"请使用手机淘宝扫描登录"];
//
//    }
//
//}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    NSLog(@"点击确认");
    [self sure];
    [self.view endEditing:YES];

}

- (void)sure
{
    UITextField *textFid1 = [self.view viewWithTag:100];
    
    if ([textFid1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入验证码"];
        return;
    }
    if (self.isEC == YES) {
        TLNetworking *http1 = [TLNetworking new];
        http1.code = @"632935";
        
        http1.parameters[@"tokendb"] = self.code;
        http1.parameters[@"input"] = textFid1.text;
        
        [http1 postWithSuccess:^(id responseObject) {
            
            [TLAlert alertWithInfo:@"认证成功"];
            
        } failure:^(NSError *error) {
            
        }];
    }else{
        TLNetworking *http1 = [TLNetworking new];
        http1.code = @"632936";
        
        http1.parameters[@"tokendb"] = self.code;
        http1.parameters[@"input"] = textFid1.text;
        
        [http1 postWithSuccess:^(id responseObject) {
            
            NSString *data = responseObject[@"data"];
            NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
            //        NSString * jsonString = @"";
            NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            [self loadWithToken:dic[@"token"]];
            
        } failure:^(NSError *error) {
            
        }];
    }
    
}

- (void)loadWithToken: (NSString *)token
{
    
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632937";
    
    http1.parameters[@"tokendb"] = token;
    self.token = token;
    [http1 postWithSuccess:^(id responseObject) {
        
        NSString *data = responseObject[@"data"];
        NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
        //        NSString * jsonString = @"";
        NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"code"] isEqualToString:@"0000"]) {
            [TLAlert alertWithInfo:dic[@"msg"]];
            [self.timer invalidate];
            self.timer = nil;
            [TLAlert alertWithMsg:@"认证成功"];

            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [NSThread sleepForTimeInterval:5];
            [TLAlert alertWithMsg:@"认证中,请稍后"];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:5
                                                          target:self
                                                        selector:@selector(loadWithTok)
                                                        userInfo:nil
                                                         repeats:YES];
            if (self.isMb == YES) {
                [self.timer invalidate];
                self.timer = nil;

                [self.navigationController popToRootViewControllerAnimated:YES];

            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadWithTok
{
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632937";
    
    http1.parameters[@"tokendb"] = self.token;
    [http1 postWithSuccess:^(id responseObject) {
        
        NSString *data = responseObject[@"data"];
        NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
        //        NSString * jsonString = @"";
        NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"code"] isEqualToString:@"0000"]) {
            [TLAlert alertWithInfo:dic[@"msg"]];
            [self.timer invalidate];
            self.timer = nil;
            [TLAlert alertWithMsg:@"认证成功"];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
           
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

-(void)dealloc
{
    [self.timer setFireDate:[NSDate distantFuture]];
    
    [self.timer invalidate];
    self.timer = nil;
    
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
