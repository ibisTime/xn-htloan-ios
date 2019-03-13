//
//  CollectVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/13.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CollectVC.h"
#import "CollectCell.h"
#define collect @"CollectCell"
@interface CollectVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) TLTableView * tableview;
@end

@implementation CollectVC

-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerClass:[CollectCell class] forCellReuseIdentifier:collect];
        
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self.view addSubview:self.tableview];
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    self.RightButton.titleLabel.font = Font(16);
    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-57.5, 30, 42.5, 45)];
    [self.RightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.RightButton addTarget:self action:@selector(confirm:) forControlEvents:(UIControlEventTouchUpInside)];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectCell * cell = [tableView dequeueReusableCellWithIdentifier:collect forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 175;
}
-(void)confirm:(UIButton *)sender{
    
}
@end
