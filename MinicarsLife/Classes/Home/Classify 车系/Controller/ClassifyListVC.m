//
//  ClassifyListVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "ClassifyListVC.h"
#import "ClassifyCell.h"
#import "ClassifyInfoVC.h"
@interface ClassifyListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) TLTableView * tableview;
@end

@implementation ClassifyListVC
-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerClass:[ClassifyCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车系列表";
    [self.view addSubview:self.tableview];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.CarModels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    
    ClassifyCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[ClassifyCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        
    }
    cell.carmodel = [CarModel mj_objectWithKeyValues:self.CarModels[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self getClassifyData:self.CarModels[indexPath.row].code];
}
-(void)getClassifyData:(NSString*)code{
    //列表查询车型
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.showView = self.view;
    http2.code = @"630426";
    http2.parameters[@"seriesCode"] = code;
    [http2 postWithSuccess:^(id responseObject) {
        ClassifyInfoVC * vc = [ClassifyInfoVC new];
        vc.models = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //        if (vc.models.count > 0) {
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        //        }
        
    } failure:^(NSError *error) {
        
    }];
}
@end
