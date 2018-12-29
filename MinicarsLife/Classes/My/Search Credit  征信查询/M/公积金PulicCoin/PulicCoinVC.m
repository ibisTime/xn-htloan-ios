//
//  PulicCoinVC.m
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/15.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "PulicCoinVC.h"
#import "ClaimsTableView.h"
#import "WSDatePickerView.h"
#import "CZHAddressPickerView.h"
#import "FilterView.h"
@class BaoModel;
@interface PulicCoinVC ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) MyModel *model;
@property (nonatomic, strong) NSMutableArray <BaoModel *>*baoModels;
@property (nonatomic, strong) FilterView *filterPicker;

@end

@implementation PulicCoinVC
#pragma mark - Init
- (FilterView *)filterPicker {
    
    if (!_filterPicker) {
        
        
        
        _filterPicker = [[FilterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        _filterPicker.title =@"请选择地址";
        MJWeakSelf;
        _filterPicker.selectBlock = ^(NSInteger index) {
            
            weakSelf.tableView.chooseText = weakSelf.baoModels[index].areaName;
            [weakSelf.tableView reloadData];
        };
        
        _filterPicker.tagNames = self.baoModels;
        
    }
    
    return _filterPicker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公积金认证";
    [self initTableView];
    [self reauestList];}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
    }
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    
    [self.view endEditing:YES];

    NSLog(@"点击确认");
    [self sure];
}

- (void)sure
{
    UITextField *textFid1 = [self.view viewWithTag:101];
    UITextField *textFid2 = [self.view viewWithTag:102];
    UITextField *textFid3 = [self.view viewWithTag:103];
    UITextField *textFid4 = [self.view viewWithTag:104];
   
    if ([self.tableView.chooseText isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选取地区"];
        return;
    }
    

    if ([textFid1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入账号"];
        return;
    }
    if ([textFid2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入密码"];
        return;
    }
//    if ([textFid3.text isEqualToString:@""]) {
//        [TLAlert alertWithInfo:@"真实姓名"];
//        return;
//    }
//    if ([textFid4.text isEqualToString:@""]) {
//        [TLAlert alertWithInfo:@"其他信息"];
//        return;
//    }
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632930";
    
    http1.parameters[@"area"] = self.tableView.chooseText;
    
    http1.parameters[@"username"] = textFid1.text;
    http1.parameters[@"password"] = textFid2.text;
    http1.parameters[@"idNo"] = [USERDEFAULTS  objectForKey:IDNO];

    http1.parameters[@"realName"] = textFid3.text;
    http1.parameters[@"otherInfo"] = textFid4.text;
    http1.parameters[@"customerName"] = [USERDEFAULTS objectForKey:NAME];

    [http1 postWithSuccess:^(id responseObject) {
        NSString *data = responseObject[@"result"][@"data"];
        NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
        //        NSString * jsonString = @"";
        NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"code"] isEqualToString:@"1013"] || [dic[@"code"] isEqualToString:@"1016"] || [dic[@"code"] isEqualToString:@"1104"]) {
            [TLAlert alertWithInfo:dic[@"msg"]];
            return ;
        }else{
            [TLAlert alertWithInfo:dic[@"msg"]];
            //            [self.navigationController popViewControllerAnimated:YES];
        }    } failure:^(NSError *error) {
        
    }];
    
}

- (void)reauestList
{
    
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632928";
    [http1 postWithSuccess:^(id responseObject) {
        self.baoModels = [BaoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSLog(@"%@",self.baoModels);
    } failure:^(NSError *error) {
        
    }];
}


- (void)initTableView {
    self.tableView = [[ClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.isCoin = YES;
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
    MJWeakSelf;
    self.tableView.ChooseBlock = ^{
        [weakSelf chooseShow];
    };
}


- (void)chooseShow {
    
    [self.filterPicker show];
}



@end
