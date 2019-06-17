//
//  DishonestVC.m
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/15.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "DishonestVC.h"
#import "ClaimsTableView.h"

@interface DishonestVC ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) MyModel *model;

@end

@implementation DishonestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"失信被执行人";
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
    [self.view endEditing:YES];
    UITextField *textFid1 = [self.view viewWithTag:100];
    UITextField *textFid2 = [self.view viewWithTag:101];
    if ([textFid1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入身份证号"];
        return;
    }
    if ([textFid2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入姓名"];
        return;
    }
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632924";
    
    //    http1.showView = weakSelf.view;
    //    http1.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    http1.parameters[@"identityNo"] = textFid1.text;
    http1.parameters[@"name"] = textFid2.text;
    [http1 postWithSuccess:^(id responseObject) {
        NSString *data = responseObject[@"data"];
        NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
        //        NSString * jsonString = @"";
        NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
       NSArray *arr = dic[@"result"][@"data"][@"dishonests"];
        if (arr.count >0) {
            [TLAlert alertWithInfo:@"存在失信信息"];

        }else{
            
            [TLAlert alertWithInfo:@"不存在失信信息"];

        }

    } failure:^(NSError *error) {
        
    }];
    
}

- (void)initTableView {
    self.tableView = [[ClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
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
