//
//  NoticeVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/13.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "NoticeVC.h"
#import "RemindCell.h"
#define remind @"RemindCell"
#import "MessageModel.h"
#import "MessageInfoVC.h"
#import "CarInfoVC.h"
#import "NewsInfoVC.h"
@interface NoticeVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property (nonatomic,strong) TLTableView * tableview;
@property (nonatomic,strong) NSMutableArray<MessageModel *> * messagemodels;
@end

@implementation NoticeVC

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = kBackgroundColor;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableview registerClass:[RemindCell class] forCellReuseIdentifier:remind];
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getdata];
    [self.view addSubview:self.tableview];
    self.title = @"消息";
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.messagemodels.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RemindCell * cell = [tableView dequeueReusableCellWithIdentifier:remind forIndexPath:indexPath];
    cell.model = self.messagemodels[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 79;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
//    UILabel * time = [UILabel labelWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 30) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(13) textColor:kWhiteColor];
//    MessageModel * model = self.messagemodels[section];
//    kViewRadius(time, 2);
//    time.text = [model.createDatetime convertToDetailDate];
//    [time sizeToFit];
//    time.frame = CGRectMake((SCREEN_WIDTH - time.width) / 2 - 10, 10 + (30 - time.height)/2 - 2.5, time.width + 10, time.height + 5);
//    time.backgroundColor = kShallowGreyColor;
//    [view addSubview:time];
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MessageInfoVC * vc = [[MessageInfoVC alloc]init];
//    vc.model = self.messagemodels[indexPath.section];
//    [self.navigationController pushViewController:vc animated:YES];
    
//    GG("1", "公告"), ZX("2", "资讯"), CAR_APPLY("3", "车辆申请单"),CAR("4", "发布车型");
    if ([self.messagemodels[indexPath.section].type isEqualToString:@"1"] || [self.messagemodels[indexPath.section].type isEqualToString:@"3"]) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"805307";
        http.showView = self.view;
        http.parameters[@"code"] = self.messagemodels[indexPath.section].code;
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        [http postWithSuccess:^(id responseObject) {
            MessageInfoVC * vc = [MessageInfoVC new];
            vc.model = [MessageModel mj_objectWithKeyValues:responseObject[@"data"]];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            if ([USERXX isBlankString:self.messagemodels[indexPath.section].isAlreadyRead] == NO) {
                [self.messagemodels[indexPath.section] setValue:@"1" forKey:@"isAlreadyRead"];
                [self.tableview reloadData];
            }
        } failure:^(NSError *error) {
            
        }];
    }
    if ([self.messagemodels[indexPath.section].type isEqualToString:@"2"]) {
        
        if ([USERXX isBlankString:self.messagemodels[indexPath.section].refCode] == YES) {
            TLNetworking * http = [[TLNetworking alloc]init];
            http.code = @"805307";
            http.showView = self.view;
            http.parameters[@"code"] = self.messagemodels[indexPath.section].code;
            http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
            [http postWithSuccess:^(id responseObject) {
                MessageInfoVC * vc = [MessageInfoVC new];
                vc.model = [MessageModel mj_objectWithKeyValues:responseObject[@"data"]];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                if ([USERXX isBlankString:self.messagemodels[indexPath.section].isAlreadyRead] == NO) {
                    [self.messagemodels[indexPath.section] setValue:@"1" forKey:@"isAlreadyRead"];
                    [self.tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
        }else
        {
            NewsInfoVC *vc = [NewsInfoVC new];
            vc.code = self.messagemodels[indexPath.section].refCode;
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            if ([USERXX isBlankString:self.messagemodels[indexPath.section].isAlreadyRead] == NO) {
                [self.messagemodels[indexPath.section] setValue:@"1" forKey:@"isAlreadyRead"];
                [self.tableview reloadData];
            }

        }
}
    if ([self.messagemodels[indexPath.section].type isEqualToString:@"4"]) {
        
        
        if ([USERXX isBlankString:self.messagemodels[indexPath.section].refCode] == YES) {
            TLNetworking * http = [[TLNetworking alloc]init];
            http.code = @"805307";
            http.showView = self.view;
            http.parameters[@"code"] = self.messagemodels[indexPath.section].code;
            http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
            [http postWithSuccess:^(id responseObject) {
                MessageInfoVC * vc = [MessageInfoVC new];
                vc.model = [MessageModel mj_objectWithKeyValues:responseObject[@"data"]];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                if ([USERXX isBlankString:self.messagemodels[indexPath.section].isAlreadyRead] == NO) {
                    [self.messagemodels[indexPath.section] setValue:@"1" forKey:@"isAlreadyRead"];
                    [self.tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
        }else
        {
            TLNetworking * http = [[TLNetworking alloc]init];
            http.code = @"630427";
            http.showView = self.view;
            http.parameters[@"code"] = self.messagemodels[indexPath.section].refCode;
            http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
            [http postWithSuccess:^(id responseObject) {
                CarInfoVC * vc = [CarInfoVC new];
                vc.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                if ([USERXX isBlankString:self.messagemodels[indexPath.section].isAlreadyRead] == NO) {
                    [self.messagemodels[indexPath.section] setValue:@"1" forKey:@"isAlreadyRead"];
                    [self.tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
        }
        
        
    }
}

-(void)getdata{
    
    MinicarsLifeWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = MyNewsURL;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.parameters[@"status"] = @"1";
    helper.parameters[@"typeList"] = self.typeList;
    helper.tableView = self.tableview;
    [helper modelClass:[MessageModel class]];
    [self.tableview addRefreshAction:^{
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.messagemodels = objs;
            [weakSelf.tableview reloadData_tl];
            [weakSelf.tableview endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshHeader];
        }];
    }];
    [self.tableview addLoadMoreAction:^{
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.messagemodels = objs;
            [weakSelf.tableview reloadData_tl];
            [weakSelf.tableview endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshFooter];
        }];
    }];
    [self.tableview beginRefreshing];
}

@end
