//
//  NotifyVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/13.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "NotifyVC.h"
#import "RemindCell.h"
#define remind @"RemindCell"
#import "MessageModel.h"
#import "MessageInfoVC.h"
@interface NotifyVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property (nonatomic,strong) TLTableView * tableview;
@property (nonatomic,strong) NSMutableArray<MessageModel *> * messagemodels;

@end

@implementation NotifyVC

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
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    UILabel * time = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 30) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(13) textColor:kWhiteColor];
    MessageModel * model = self.messagemodels[section];
    time.text = [model.createDatetime convertToDetailDate];
    [time sizeToFit];
    time.frame = CGRectMake((SCREEN_WIDTH - time.width) / 2 - 10, (30 - time.height)/2 - 2.5, time.width + 10, time.height + 5);
    time.backgroundColor = kShallowGreyColor;
    [view addSubview:time];
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageInfoVC * vc = [[MessageInfoVC alloc]init];
    vc.model = self.messagemodels[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)getdata{
    MinicarsLifeWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = MyNewsURL;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.parameters[@"type"] = @"2";
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
