//
//  PersionalCreditVC.m
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "PersionalCreditVC.h"
#import "NumberCodeVC.h"
#import "BankCodeVC.h"
#import "MYCell.h"
#import "SheBaoVC.h"
@interface PersionalCreditVC ()<UITableViewDelegate,UITableViewDataSource
>
{
    NSString *accountNumber;
    NSString *faceStr;
}
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UILabel *titleLabel;

@property (nonatomic, strong) UIAlertController *alertCtrl;

@end

@implementation PersionalCreditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"征信认证";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

#pragma mark -- tableView懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect tableView_frame;
        NSLog(@"%d",kStatusBarHeight);
        tableView_frame = CGRectMake(0, kStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT + 44 + kStatusBarHeight - kTabBarHeight);
        _tableView = [[UITableView alloc] initWithFrame:tableView_frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=BackColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MYCell class] forCellReuseIdentifier:@"MYCell"];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MYCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MYCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
            cell.iconImage.image = HGImage(@"myicon1");
            cell.nameLabel.text = @"身份证实名认证";
        }
            break;
        case 1:
        {
            cell.iconImage.image = HGImage(@"myicon1");
            cell.nameLabel.text = @"银行卡四要素";
        }
            break;
        case 2:
        {
            cell.iconImage.image = HGImage(@"myicon2");
            cell.nameLabel.text = @"社保";
        }
            break;
       
            
        default:
            break;
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            NumberCodeVC *vc = [[NumberCodeVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {  BankCodeVC *vc = [[BankCodeVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
          
        }
            break;
        case 2:
        {  SheBaoVC *vc = [[SheBaoVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


@end
