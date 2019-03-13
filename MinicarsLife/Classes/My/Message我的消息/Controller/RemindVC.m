//
//  RemindVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/13.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "RemindVC.h"
#import "RemindCell.h"
#define remind @"RemindCell"
@interface RemindVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableview;
@end

@implementation RemindVC
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = BackColor;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableview registerClass:[RemindCell class] forCellReuseIdentifier:remind];
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RemindCell * cell = [tableView dequeueReusableCellWithIdentifier:remind forIndexPath:indexPath];
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
    time.text = @"2019-3-13 17:10";
    [time sizeToFit];
    time.frame = CGRectMake((SCREEN_WIDTH - time.width) / 2 - 10, (30 - time.height)/2 - 2.5, time.width + 10, time.height + 5);
    time.backgroundColor = kLineColor;
    [view addSubview:time];
    return view;
}
@end
