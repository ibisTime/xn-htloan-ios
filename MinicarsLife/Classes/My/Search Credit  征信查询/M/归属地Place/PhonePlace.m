//
//  PhonePlace.m
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/15.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "PhonePlace.h"
#import "ClaimsTableView.h"

@interface PhonePlace ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) MyModel *model;

@end

@implementation PhonePlace

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"归属地";
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
   
    if ([textFid1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入手机号"];
        return;
    }
  
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632933";
  
    http1.parameters[@"mobileNo"] = textFid1.text;
    [http1 postWithSuccess:^(id responseObject) {
        NSString *data = responseObject[@"data"];
        NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
        //        NSString * jsonString = @"";
        NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        [TLAlert alertWithInfo:dic[@"msg"]];
        if (dic[@"data"][@"city"]) {
            self.tableView.isPhoneShow = YES;
            self.tableView.city = dic[@"data"][@"type"];
            self.tableView.type = [NSString stringWithFormat:@"%@ %@",dic[@"data"][@"province"],dic[@"data"][@"city"]];;
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)initTableView {
    self.tableView = [[ClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.isPlace = YES;

    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}



@end
