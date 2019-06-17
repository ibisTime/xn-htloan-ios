//
//  WithdrawalVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "WithdrawalVC.h"
#import "WithdrawalCell.h"
#import "WithdrawalPriceCell.h"
#import "AddBankCardCell.h"
#import "SelectedListView.h"
#import "SelectedListModel.h"
#define Withdrawal @"WithdrawalCell"
#define AddBankCard @"AddBankCardCell"

#define WithdrawalPrice @"WithdrawalPriceCell"
@interface WithdrawalVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *bankCode;
}
@property (nonatomic , strong)UITableView *tableView;

@property (nonatomic , strong)NSMutableArray *dataArray;

@end

@implementation WithdrawalVC

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect tableView_frame;
        NSLog(@"%d",kStatusBarHeight);
        tableView_frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        _tableView = [[UITableView alloc]initWithFrame:tableView_frame style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=BackColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[WithdrawalCell class] forCellReuseIdentifier:Withdrawal];
        [_tableView registerClass:[WithdrawalPriceCell class] forCellReuseIdentifier:WithdrawalPrice];
        [_tableView registerClass:[AddBankCardCell class] forCellReuseIdentifier:AddBankCard];

    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提现";
    [self.view addSubview:self.tableView];
    [self LoadData];
}
-(void)LoadData
{
    MinicarsLifeWeakSelf;
    
    TLNetworking *http = [TLNetworking new];
    http.code = QueryChannelBankURL;
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        weakSelf.dataArray = responseObject[@"data"];
        
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
    return 3;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            AddBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:AddBankCard forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.button.hidden= NO;
            cell.nameLabel.text = @"开户行";
            cell.nameTextField.placeholder = @"请选择开户行";
            cell.nameTextField.tag = 100 + indexPath.row;

            cell.xiaImage.hidden = NO;
            [cell.button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            cell.button.tag = 1000;
            return cell;
        }else{
            
            WithdrawalCell *cell = [tableView dequeueReusableCellWithIdentifier:Withdrawal forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"持卡人",@"开户行",@"卡    号"];
            cell.nameLabel.text = nameArray[indexPath.row];
            NSArray *nameTextArray = @[@"请输入姓名",@"请选择开户行",@"请输入银行卡号"];
            cell.nameTextField.placeholder = nameTextArray[indexPath.row];
            cell.nameTextField.tag = 100 + indexPath.row;
            return cell;

            
        }
    }
    WithdrawalPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:WithdrawalPrice forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.priceTextField.tag = 103;
    return cell;

}


#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 130;
    }
    return 60;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 10;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 100;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];

        UIButton *confirmButton = [UIButton buttonWithTitle:@"确认" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18 cornerRadius:5];
        confirmButton.frame = CGRectMake(20, 40, SCREEN_WIDTH - 40, 50);
        [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        [headView addSubview:confirmButton];

        return headView;
    }
    return nil;
}
-(void)buttonClick:(UIButton *)sender
{

        if (self.dataArray.count == 0) {
            return;
        }
        NSMutableArray *nameArray = [NSMutableArray array];
        for (int i = 0;  i < _dataArray.count; i ++) {
            //            BankCardModel *model = _model[i];
            [nameArray addObject:[[SelectedListModel alloc] initWithSid:i Title:_dataArray[i][@"bankName"]]];
        }
        
        SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
        view.isSingle = YES;
        view.array = nameArray;
        view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
            [LEEAlert closeWithCompletionBlock:^{
                NSLog(@"选中的%@" , array);
                
                SelectedListModel *model = array[0];
                UITextField *textField = [self.view viewWithTag:101];
                textField.text = model.title;
                for (int i = 0; i < _dataArray.count; i ++) {
                    if ([model.title isEqualToString:_dataArray[i][@"bankName"]]) {
                        bankCode = _dataArray[i][@"bankCode"];
                    }
                }
            }];
        };
        [LEEAlert alert].config
        .LeeTitle(@"请选择银行")
        .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
        .LeeCustomView(view)
        .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
        .LeeClickBackgroundClose(YES)
        .LeeShow();
    
}
-(void)confirmButtonClick
{
    MinicarsLifeWeakSelf

    UITextField *textField1 = [weakSelf.view viewWithTag:100];
    UITextField *textField2 = [weakSelf.view viewWithTag:101];
    UITextField *textField3 = [weakSelf.view viewWithTag:102];
    UITextField *textField4 = [weakSelf.view viewWithTag:103];
    UITextField *textField = [self.view viewWithTag:101];

    if ([textField1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入持卡人"];
        return;
    }
    if ([textField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入开户行"];
        return;
    }
    if ([textField3.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入卡号"];
        return;
    }
    if ([textField4.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入提现金额"];
        return;
    }

    TLNetworking *http = [TLNetworking new];
    http.code = WithdrawalURL;
    http.showView = weakSelf.view;
    http.parameters[@"accountNumber"] = self.accointModel.accountNumber;
    http.parameters[@"amount"] = @([textField4.text floatValue] * 1000);
    http.parameters[@"applyNote"] = @"申请说明";
    http.parameters[@"applyUser"] = textField1.text;
    http.parameters[@"payCardInfo"] = textField.text;
    http.parameters[@"payCardNo"] = textField3.text;

    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"提现申请提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

@end
