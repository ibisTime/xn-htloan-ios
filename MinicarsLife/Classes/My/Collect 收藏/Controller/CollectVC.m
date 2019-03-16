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
@interface CollectVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property (nonatomic,strong) TLTableView * tableview;
//@property (nonatomic ,strong) UIButton *btn;//编辑按钮
@property (nonatomic ,assign) BOOL isInsertEdit;//tableview编辑方式的判断
@property (nonatomic ,strong) CollectBottomView *bottom_view;//底部视图
@property (nonatomic,strong) NSMutableArray<CollectModel *> * CollectModels;
@end

@implementation CollectVC

-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.allowsMultipleSelectionDuringEditing = YES;
//        [_tableview setEditing:YES animated:YES];
        [_tableview registerClass:[CollectCell class] forCellReuseIdentifier:collect];
        
    }
    return _tableview;
}

- (CollectBottomView *)bottom_view{
    if (!_bottom_view) {
        self.bottom_view = [[CollectBottomView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 375, 50)];
//        _bottom_view.backgroundColor = [UIColor yellowColor];
        [_bottom_view.deleteBtn addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
        [_bottom_view.allBtn addTarget:self action:@selector(tapAllBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottom_view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self getdata];
    
    [self.view addSubview:self.tableview];
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectCell * cell = [tableView dequeueReusableCellWithIdentifier:collect forIndexPath:indexPath];
    cell.model = self.CollectModels[indexPath.section];
    UIView *backGroundView = [[UIView alloc]init];
    backGroundView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = backGroundView;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 175;
}
-(void)confirm:(UIButton *)sender{{
    sender.selected = !sender.selected;
    if (sender.selected) {
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
        
        
        
    }else{
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
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
                //全选实现方法
                [_tableview selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
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
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
                [_tableview deselectRowAtIndexPath:indexPath animated:NO];

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
//        [self.deleteArray addObject:[self.dataArray objectAtIndex:indexPath.row]];
        
    }else{
        NSLog(@"跳转下一页");
    }
}

-(void)getdata{
    MinicarsLifeWeakSelf;
    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
//    TLNetworking * help = [[TLNetworking alloc]init];
    help.code = @"630465";
//    help.parameters[@"limit"] = @"10";
//    help.parameters[@"start"] = @"1";
    help.parameters[@"toType"] = @"0";
    help.parameters[@"type"] = @"3";
    [help modelClass:[CollectModel class]];
    help.tableView = self.tableview;
    help.isCurrency = YES;
    [self.tableview addRefreshAction:^{
        [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.CollectModels = objs;
            [weakSelf.tableview reloadData_tl];
            [weakSelf.tableview endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshHeader];
        }];
    }];
    [self.tableview addLoadMoreAction:^{
        [help loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.CollectModels = objs;
            [weakSelf.tableview reloadData_tl];
            [weakSelf.tableview endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshFooter];
        }];
    }];
    [self.tableview beginRefreshing];
}
@end
