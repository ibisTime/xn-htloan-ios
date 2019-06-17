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
#import "CollectBottomView.h"
#import "CollectModel.h"
#import "CarInfoVC.h"
@interface CollectVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property (nonatomic,strong) TLTableView * tableview;
//@property (nonatomic ,strong) UIButton *btn;//编辑按钮
@property (nonatomic ,assign) BOOL isInsertEdit;//tableview编辑方式的判断
@property (nonatomic ,strong) CollectBottomView *bottom_view;//底部视图
@property (nonatomic,strong) NSMutableArray<CollectModel *> * CollectModels;

@property (nonatomic ,strong) NSMutableArray *deleteArray;//删除的数据

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation CollectVC
- (NSMutableArray *)deleteArray{
    if (!_deleteArray) {
        self.deleteArray = [NSMutableArray array];
    }
    return _deleteArray;
}
-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.allowsMultipleSelectionDuringEditing = YES;
//        [_tableview setEditing:YES animated:YES];
        [_tableview registerClass:[CollectCell class] forCellReuseIdentifier:collect];
        
    }
    return _tableview;
}


-(void)car_versionLoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630036";
    http.parameters[@"parentKey"] = @"car_version";
    [http postWithSuccess:^(id responseObject) {
        
        self.dataArray = responseObject[@"data"];
        [self.tableview reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (CollectBottomView *)bottom_view{
    if (!_bottom_view) {
        self.bottom_view = [[CollectBottomView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, SCREEN_WIDTH, 50)];
//        _bottom_view.backgroundColor = [UIColor yellowColor];
        [_bottom_view.deleteBtn addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
        [_bottom_view.allBtn addTarget:self action:@selector(tapAllBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottom_view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    MinicarsLifeWeakSelf;
//    self.title = @"我的收藏";
    [self getdata];
    
    [self.view addSubview:self.tableview];
    [self.tableview addRefreshAction:^{
        [weakSelf getdata];
        [weakSelf car_versionLoadData];
    }];
    [self.tableview beginRefreshing];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    self.RightButton.titleLabel.font = Font(16);
    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-57.5, 30, 42.5, 45)];
    [self.RightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.RightButton addTarget:self action:@selector(confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    
     _isInsertEdit = NO;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.CollectModels.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectCell * cell = [tableView dequeueReusableCellWithIdentifier:collect forIndexPath:indexPath];
    cell.model = self.CollectModels[indexPath.section];
    
    
    
    UIView *backGroundView = [[UIView alloc]init];
    backGroundView.backgroundColor = kClearColor;
    
    cell.selectedBackgroundView = backGroundView;
    cell.view.backgroundColor = kHexColor(@"#F5F5F5");
    cell.dataArray = self.dataArray;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 175;
}
-(void)confirm:(UIButton *)sender{{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.tableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50);
        //点击编辑的时候清空删除数组
//        [self.deleteArray removeAllObjects];
        [self.RightButton setTitle:@"完成" forState:UIControlStateNormal];
        _isInsertEdit = YES;//这个时候是全选模式
        [_tableview setEditing:YES animated:YES];
        
        //如果在全选状态下，点击完成，再次进来的时候需要改变按钮的文字和点击状态
        if (_bottom_view.allBtn.selected) {
            _bottom_view.allBtn.selected = !_bottom_view.allBtn.selected;
            [_bottom_view.allBtn setTitle:@"全选" forState:UIControlStateNormal];
        }
        
        //添加底部视图
        CGRect frame = self.bottom_view.frame;
        frame.origin.y -= 50;
        [UIView animateWithDuration:0.5 animations:^{
            self.bottom_view.frame = frame;
            [self.view addSubview:self.bottom_view];
        }];
        [self.deleteArray removeAllObjects];
        for (int i = 0; i < self.CollectModels.count; i++) {
            [self.deleteArray addObject:@""];
        }
        
        
    }else{
        self.tableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        [self.RightButton setTitle:@"编辑" forState:UIControlStateNormal];
        _isInsertEdit = NO;
        [_tableview setEditing:NO animated:YES];
        
        [UIView animateWithDuration:0.5 animations:^{
            CGPoint point = self.bottom_view.center;
            point.y      += 50;
            self.bottom_view.center   = point;
        } completion:^(BOOL finished) {
            [self.bottom_view removeFromSuperview];
        }];
    }
}
}

- (void)tapAllBtn:(UIButton *)btn{
//    {
//
        btn.selected = !btn.selected;

        if (btn.selected) {

            for (int i = 0; i< self.CollectModels.count; i++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:i];
                //全选实现方法
                [_tableview selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
                [self.deleteArray replaceObjectAtIndex:i withObject:self.CollectModels[i].code];
            }
            
//
//            //点击全选的时候需要清除deleteArray里面的数据，防止deleteArray里面的数据和列表数据不一致
//            if (self.deleteArray.count >0) {
//                [self.deleteArray removeAllObjects];
//            }
//            [self.deleteArray addObjectsFromArray:self.dataArray];
//
//            [btn setTitle:@"取消" forState:UIControlStateNormal];
        }else{
            //取消选中
            for (int i = 0; i< self.CollectModels.count; i++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:i];
                [_tableview deselectRowAtIndexPath:indexPath animated:NO];
                [self.deleteArray replaceObjectAtIndex:i withObject:@""];
            }

//            [btn setTitle:@"全选" forState:UIControlStateNormal];
//            [self.deleteArray removeAllObjects];
        }
//
//
//        //    NSLog(@"+++++%ld",self.deleteArray.count);
//        //    NSLog(@"===%@",self.deleteArray);
//
//    }
}

-(void)deleteData{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630461";
//    NSArray * codeList = [NSArray array];
    for (int i = 0; i < self.deleteArray.count; i++) {
        if ([self.deleteArray[i] isEqualToString:@""]) {
            [self.deleteArray removeObjectAtIndex:i];
        }
    }
    http.parameters[@"codeList"] = self.deleteArray;
    [http postWithSuccess:^(id responseObject) {
        [self.tableview beginRefreshing];
        self.deleteArray = [NSMutableArray array];
    } failure:^(NSError *error) {
        
    }];
    
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
//    view.backgroundColor = kBackgroundColor;
//    return view;
//}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //根据不同状态返回不同编辑模式
    if (_isInsertEdit) {
        
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
        
    }else{
        
        return UITableViewCellEditingStyleDelete;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.RightButton.selected) {
        NSLog(@"选中");
        NSString * str = self.CollectModels[indexPath.section].code;
        if ([self.deleteArray[indexPath.section] isEqualToString:@""]) {
            [self.deleteArray replaceObjectAtIndex:indexPath.section withObject:str];
        }
//        else{
//            [self.deleteArray replaceObjectAtIndex:indexPath.section withObject:@""];
//        }
        
        NSLog(@"%@",self.deleteArray);
        
    }else{
//        NSLog(@"跳转下一页");
        CarModel * model = [CarModel mj_objectWithKeyValues: self.CollectModels[indexPath.section].car];
        [self getcarinfo:model.code];
    }
}
-(void)getcarinfo:(NSString *)code{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630427";
    http.parameters[@"code"] = code;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        CarInfoVC * vc = [CarInfoVC new];
        vc.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.RightButton.selected) {
        NSLog(@"取消选中");
        [self.deleteArray replaceObjectAtIndex:indexPath.section withObject:@""];

        NSLog(@"%@",self.deleteArray);

    }else{
        NSLog(@"跳转下一页");
    }
}
-(void)getdata{
//    MinicarsLifeWeakSelf;
//    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
////    TLNetworking * help = [[TLNetworking alloc]init];
//    help.code = @"630465";
////    help.parameters[@"limit"] = @"10";
//    help.parameters[@"creater"] = [USERDEFAULTS objectForKey:USER_ID];
//    help.parameters[@"toType"] = @"0";
//    help.parameters[@"type"] = self.type;
//    [help modelClass:[CollectModel class]];
//    help.tableView = self.tableview;
//    help.isCurrency = YES;
//    [self.tableview addRefreshAction:^{
//        [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
//            weakSelf.CollectModels = objs;
////            for (int i = 0; i < weakSelf.CollectModels.count; i++) {
////                [weakSelf.deleteArray addObject:@""];
////            }
//            [weakSelf.tableview reloadData_tl];
//            [weakSelf.tableview endRefreshHeader];
//        } failure:^(NSError *error) {
//            [weakSelf.tableview endRefreshHeader];
//        }];
//    }];
//    [self.tableview addLoadMoreAction:^{
//        [help loadMore:^(NSMutableArray *objs, BOOL stillHave) {
//            weakSelf.CollectModels = objs;
//            [weakSelf.tableview reloadData_tl];
//            [weakSelf.tableview endRefreshFooter];
//        } failure:^(NSError *error) {
//            [weakSelf.tableview endRefreshFooter];
//        }];
//    }];
//    [self.tableview beginRefreshing];
    
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630467";
    http.parameters[@"toType"] = @"0";
    http.parameters[@"type"] = self.type;
    http.parameters[@"creater"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        self.CollectModels = [CollectModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (int i = 0; i < self.CollectModels.count; i++) {
            [self.deleteArray addObject:@""];
        }
        [self.tableview reloadData_tl];
        [self.tableview endRefreshHeader];
    } failure:^(NSError *error) {
        
    }];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
@end
