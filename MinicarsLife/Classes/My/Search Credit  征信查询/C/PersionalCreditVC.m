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
#import "InvolvedVC.h"
#import "DishonestVC.h"
#import "PulicCoinVC.h"
#import "TaobaoVC.h"
#import "JingDongVC.h"
#import "PhonePlace.h"
#import "MobleInfomationVC.h"
#import "ExommerceVC.h"
@interface PersionalCreditVC ()<UITableViewDelegate,UITableViewDataSource
>
{
    NSString *accountNumber;
    NSString *faceStr;
}
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UILabel *titleLabel;

@property (nonatomic, strong) UIAlertController *alertCtrl;
@property (nonatomic , strong)NSMutableArray *arr;

@property (nonatomic , strong) NSMutableDictionary *dic;

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

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [self loadRequest];

    
}

- (void)loadRequest
{
   
   NSString *idno = [USERDEFAULTS  objectForKey:IDNO];
    if (!idno) {
        return;
    }

    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632946";
    http1.parameters[@"userId"] = idno;
    
    [http1 postWithSuccess:^(id responseObject) {
        NSDictionary *data = responseObject[@"data"];
        NSLog(@"%@",data);
       
//        NSString *str = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![data count]) {
        
            NSMutableArray *arr = [NSMutableArray array];
            for (int i = 0; i< 11; i++) {
                [arr addObject:@"未认证"];
            }
            self.arr = arr;
            [self.tableView reloadData];
            return;
        }
        NSMutableDictionary *dicJD = [NSMutableDictionary dictionary];
        
        if ([data count]) {
            
            if (responseObject[@"data"][@"jd"]) {
                NSString *data1 = responseObject[@"data"][@"jd"];
                
                NSString *strUrl = [data1 stringByReplacingOccurrencesOfString:@"\%" withString:@""];
                //        NSString * jsonString = @"";
                NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                [dicJD setObject:dic[@"status"] forKey:@"jd"];
            }
            if (responseObject[@"data"][@"mobileReportTask"]) {
                NSString *data1 = responseObject[@"data"][@"mobileReportTask"];
                
                NSString *strUrl = [data1 stringByReplacingOccurrencesOfString:@"\%" withString:@""];
                //        NSString * jsonString = @"";
                NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                [dicJD setObject:dic[@"status"] forKey:@"mobileReportTask"];

            } if (responseObject[@"data"][@"mobileReportTaskData"]) {
                NSString *data1 = responseObject[@"data"][@"mobileReportTaskData"];
                
                NSString *strUrl = [data1 stringByReplacingOccurrencesOfString:@"\%" withString:@""];
                //        NSString * jsonString = @"";
                NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                [dicJD setObject:dic[@"status"] forKey:@"mobileReportTaskData"];
            } if (responseObject[@"data"][@"shixin"]) {
                NSString *data1 = responseObject[@"data"][@"shixin"];
                
                NSString *strUrl = [data1 stringByReplacingOccurrencesOfString:@"\%" withString:@""];
                //        NSString * jsonString = @"";
                NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                [dicJD setObject:dic[@"status"] forKey:@"shixin"];
            } if (responseObject[@"data"][@"taobao"]) {
                NSString *data1 = responseObject[@"data"][@"taobao"];
                
                NSString *strUrl = [data1 stringByReplacingOccurrencesOfString:@"\%" withString:@""];
                //        NSString * jsonString = @"";
                NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                [dicJD setObject:dic[@"status"] forKey:@"taobao"];
            } if (responseObject[@"data"][@"taobaoReportTaskData"]) {
                NSString *data1 = responseObject[@"data"][@"taobaoReportTaskData"];
                
                NSString *strUrl = [data1 stringByReplacingOccurrencesOfString:@"\%" withString:@""];
                //        NSString * jsonString = @"";
                NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                [dicJD setObject:dic[@"status"] forKey:@"taobaoReportTaskData"];
            }
            if (responseObject[@"data"][@"taobao_report"]) {
                NSString *data1 = responseObject[@"data"][@"taobao_report"];
                
                NSString *strUrl = [data1 stringByReplacingOccurrencesOfString:@"\%" withString:@""];
                //        NSString * jsonString = @"";
                NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                [dicJD setObject:dic[@"status"] forKey:@"taobao_report"];
            }
            if (responseObject[@"data"][@"identity"]) {
                NSString *data1 = responseObject[@"data"][@"identity"];
                
                NSString *strUrl = [data1 stringByReplacingOccurrencesOfString:@"\%" withString:@""];
                //        NSString * jsonString = @"";
                NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                [dicJD setObject:dic[@"status"] forKey:@"identity"];

            }
            if (responseObject[@"data"][@"socialsecurity"]) {
                NSString *data1 = responseObject[@"data"][@"socialsecurity"];
                
                NSString *strUrl = [data1 stringByReplacingOccurrencesOfString:@"\%" withString:@""];
                //        NSString * jsonString = @"";
                NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                [dicJD setObject:dic[@"status"] forKey:@"socialsecurity"];
                
            }
            if (responseObject[@"data"][@"involvedlistcheck"]) {
                NSString *data1 = responseObject[@"data"][@"involvedlistcheck"];
                
                NSString *strUrl = [data1 stringByReplacingOccurrencesOfString:@"\%" withString:@""];
                //        NSString * jsonString = @"";
                NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                [dicJD setObject:dic[@"status"] forKey:@"involvedlistcheck"];
                
            }
            if (responseObject[@"data"][@"housefund"]) {
                NSString *data1 = responseObject[@"data"][@"housefund"];
                
                NSString *strUrl = [data1 stringByReplacingOccurrencesOfString:@"\%" withString:@""];
                //        NSString * jsonString = @"";
                NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                [dicJD setObject:dic[@"status"] forKey:@"housefund"];
                
            }
           
            if (responseObject[@"data"][@"bankcard4check"]) {
                NSString *data1 = responseObject[@"data"][@"bankcard4check"];
                
                NSString *strUrl = [data1 stringByReplacingOccurrencesOfString:@"\%" withString:@""];
                //        NSString * jsonString = @"";
                NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                [dicJD setObject:dic[@"status"] forKey:@"bankcard4check"];

            }
            
        }
        NSLog(@"%@",dicJD);
        self.dic = dicJD;
        [self.tableView reloadData];
      
    } failure:^(NSError *error) {
        
    }];
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
    return 5;
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
//            cell.detailLabel.text = self.arr[indexPath.section];
           NSNumber *status  = [self.dic objectForKey:@"identity"];
            NSString *str = [NSString stringWithFormat:@"%@",status];
//            NSString *idno = [USERDEFAULTS  objectForKey:IDNO];
            if (str == nil || [str isEqualToString:@""] || str == NULL || [str isEqual:[NSNull class]] || str.length == 6) {
              
                cell.detailLabel.text = @"未认证";

            }else{
                cell.detailLabel.text = @"已认证";
                cell.userInteractionEnabled = NO;
            }

        }
            break;
        case 1:
        {
            cell.iconImage.image = HGImage(@"myicon1");
            cell.nameLabel.text = @"银行卡四要素";
            NSNumber *status  = [self.dic objectForKey:@"bankcard4check"];
            NSString *str = [NSString stringWithFormat:@"%@",status];

            if ([str isEqualToString:@"2"]) {
                cell.detailLabel.text = @"已认证";
                cell.userInteractionEnabled = NO;

            }else if ([str isEqualToString:@"1"])
            {
                cell.detailLabel.text = @"认证中";
                
            }else{
                cell.detailLabel.text = @"未认证";
                
                
            }
        }
            break;
//        case 2:
//        {
//            cell.iconImage.image = HGImage(@"myicon1");
//            cell.nameLabel.text = @"社保";
//            NSNumber *status  = [self.dic objectForKey:@"socialsecurity"];
//
//            NSString *str = [NSString stringWithFormat:@"%@",status];
//
//            if ([str isEqualToString:@"2"]) {
//                cell.detailLabel.text = @"已认证";
//                cell.userInteractionEnabled = NO;
//
//            }else if ([str isEqualToString:@"1"])
//            {
//                cell.detailLabel.text = @"认证中";
//
//            }else{
//                cell.detailLabel.text = @"未认证";
//
//
//            }
//
//        }
//            break;
//        case 3:
//        {
//            cell.iconImage.image = HGImage(@"myicon1");
//            cell.nameLabel.text = @"涉案信息";
//            NSNumber *status  = [self.dic objectForKey:@"involvedlistcheck"];
//
//            NSString *str = [NSString stringWithFormat:@"%@",status];
//
//            if ([str isEqualToString:@"2"]) {
//                cell.detailLabel.text = @"已认证";
//                cell.userInteractionEnabled = NO;
//
//            }else if ([str isEqualToString:@"1"])
//            {
//                cell.detailLabel.text = @"认证中";
//
//            }else{
//                cell.detailLabel.text = @"未认证";
//
//
//            }
//
//        }
//            break;
//        case 4:
//        {
//            cell.iconImage.image = HGImage(@"myicon1");
//            cell.nameLabel.text = @"失信被执行人";
//            NSNumber *status  = [self.dic objectForKey:@"shixin"];
//
//            NSString *str = [NSString stringWithFormat:@"%@",status];
//
//            if ([str isEqualToString:@"2"]) {
//                cell.detailLabel.text = @"已认证";
//                cell.userInteractionEnabled = NO;
//
//            }else{
//                cell.detailLabel.text = @"未认证";
//
//
//            }
//        }
//            break;
//        case 5:
//        {
//            cell.iconImage.image = HGImage(@"myicon1");
//            cell.nameLabel.text = @"公积金";
//            NSNumber *status  = [self.dic objectForKey:@"housefund"];
//
//            NSString *str = [NSString stringWithFormat:@"%@",status];
//
//            if ([str isEqualToString:@"2"]) {
//                cell.detailLabel.text = @"已认证";
//                cell.userInteractionEnabled = NO;
//            }else if ([str isEqualToString:@"1"])
//            {
//                  cell.detailLabel.text = @"认证中";
//
//            }
//            else{
//                cell.detailLabel.text = @"未认证";
//            }
//        }
//            break;
//        case 6:
//        {
//            cell.iconImage.image = HGImage(@"myicon1");
//            cell.nameLabel.text = @"淘宝";
//            NSNumber *status  = [self.dic objectForKey:@"taobao"];
//
//            NSString *str = [NSString stringWithFormat:@"%@",status];
//
//            if ([str isEqualToString:@"2"]) {
//                cell.detailLabel.text = @"已认证";
//                cell.userInteractionEnabled = NO;
//            }else if ([str isEqualToString:@"1"])
//            {
//                cell.detailLabel.text = @"认证中";
//
//            }
//            else{
//                cell.detailLabel.text = @"未认证";
//            }
//        }
//            break;
        case 2:
        {
            cell.iconImage.image = HGImage(@"myicon1");
            cell.nameLabel.text = @"京东";
            NSNumber *status  = [self.dic objectForKey:@"jd"];
            
            NSString *str = [NSString stringWithFormat:@"%@",status];
            
            if ([str isEqualToString:@"2"]) {
                cell.detailLabel.text = @"已认证";
                cell.userInteractionEnabled = NO;
            }else if ([str isEqualToString:@"1"])
            {
                cell.detailLabel.text = @"认证中";
                
            }
            else{
                cell.detailLabel.text = @"未认证";
            }

        }
            break;
//        case 8:
//        {
//            cell.iconImage.image = HGImage(@"myicon1");
//            cell.nameLabel.text = @"归属地";
//
//
//        }
//            break;
//
        case 3:
        {
            cell.iconImage.image = HGImage(@"myicon1");
            cell.nameLabel.text = @"运营商报告采集";
            NSNumber *status  = [self.dic objectForKey:@"mobileReportTask"];
            
            NSString *str = [NSString stringWithFormat:@"%@",status];
            
            if ([str isEqualToString:@"2"]) {
                cell.detailLabel.text = @"已认证";
                cell.userInteractionEnabled = NO;
            }else if ([str isEqualToString:@"1"])
            {
                cell.detailLabel.text = @"认证中";
                
            }
            else{
                cell.detailLabel.text = @"未认证";
            }

        }
            break;
        case 4:
        {
            cell.iconImage.image = HGImage(@"myicon1");
            cell.nameLabel.text = @"电商报告采集";
            NSNumber *status  = [self.dic objectForKey:@"taobao_report"];
            
            NSString *str = [NSString stringWithFormat:@"%@",status];
            
            if ([str isEqualToString:@"2"]) {
                cell.detailLabel.text = @"已认证";
                cell.userInteractionEnabled = NO;
            }else if ([str isEqualToString:@"1"])
            {
                cell.detailLabel.text = @"认证中";
                
            }
            else{
                cell.detailLabel.text = @"未认证";
            }
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
//        case 2:
//        {  SheBaoVC *vc = [[SheBaoVC alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//        case 3:
//        {  InvolvedVC *vc = [[InvolvedVC alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//        case 4:
//        {
//            DishonestVC *vc = [[DishonestVC alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//        case 5:
//        {
//            PulicCoinVC *vc = [[PulicCoinVC alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//        case 6:
//        {
//            TaobaoVC *vc = [[TaobaoVC alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
        case 2:
        {
            JingDongVC *vc = [[JingDongVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
//        case 3:
//        {
//            PhonePlace *vc = [[PhonePlace alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
            
        case 3:
        {
            MobleInfomationVC *vc = [[MobleInfomationVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            ExommerceVC *vc = [[ExommerceVC alloc]init];
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
