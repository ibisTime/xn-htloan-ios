//
//  ClassicCarsVC.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/6.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ClassicCarsVC.h"
#import "ClassicCarsCell.h"
#import "CarModel.h"
#import "CarInfoVC.h"
@interface ClassicCarsVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong)UICollectionView *collection;
@property (nonatomic , strong)NSMutableArray <CarModel *>*carsModels;


@end

@implementation ClassicCarsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.s
    self.title = @"经典车型";
    
    [self.view addSubview:self.collection];
    
    [self DownRefresh];
//    [self PopularModels];
}

#pragma mark -- 下拉刷新
- (void)DownRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(PopularModels)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    _collection.mj_header = header;
    [_collection.mj_header beginRefreshing];
    
}

-(UICollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat width = 130.00;
        // 设置每个item的大小
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 45)/2, 195);
        // 设置列间距
        layout.minimumInteritemSpacing = 15;
        // 设置行间距
                layout.minimumLineSpacing = 15;
        //每个分区的四边间距UIEdgeInsetsMake
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        // 设置Item的估计大小,用于动态设置item的大小，结合自动布局（self-sizing-cell）
        //        layout.estimatedItemSize = CGSizeMake(width , 338.00 / 226.00 * width);
        // 设置布局方向(滚动方向)
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT - kNavigationBarHeight )collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.showsVerticalScrollIndicator = NO;
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.backgroundColor = [UIColor whiteColor];
        [_collection registerClass:[ClassicCarsCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collection;
}

//热门车型
-(void)PopularModels
{
    
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.code = @"630492";
    http2.parameters[@"location"] = @"0";
    http2.parameters[@"status"] = @"1";
    http2.parameters[@"start"] = @"0";
    http2.parameters[@"limit"] = @"100";
    http2.parameters[@"orderDir"] = @"asc";
    
    [http2 postWithSuccess:^(id responseObject) {
        self.carsModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        self.tableView.carsModels = self.carsModels;
        [self.collection reloadData];
        [self.collection.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.collection.mj_header endRefreshing];
    }];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.carsModels.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ClassicCarsCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.carsModels[indexPath.row];
//    cell.brand = self.dealersModel.brandList[indexPath.row];
    return cell;
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630427";
    http.showView = self.view;
    http.parameters[@"code"] = self.carsModels[indexPath.row].code;
//    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        CarInfoVC * vc = [CarInfoVC new];
        vc.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
