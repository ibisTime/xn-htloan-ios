//
//  RecentPaymentsVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RecentPaymentsVC.h"
#import "NearFutureModel.h"
#import "NearFutureTableView.h"
#import "RecordDetailsVC.h"
#import "DetailsVC.h"
#import "CarCell.h"
#import "CollectionHeaderView.h"
#import "CarlevelCell.h"
@interface RecentPaymentsVC ()<RefreshDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic , strong)NearFutureTableView *tableView;

@property (nonatomic , strong)NSMutableArray <NearFutureModel *>*model;


@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) UILabel * ResultLab;

@end

@implementation RecentPaymentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ResultLab = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
    self.ResultLab.text = @"您选择的条件会显示在这";
    [self.view addSubview:self.ResultLab];
    
    UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH - 30, 1)];
    v1.backgroundColor = kLineColor;
    [self.view addSubview:v1];
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    
//    layout.itemSize = CGSizeMake(138, 35);
    
    layout.minimumInteritemSpacing = 10;
    // 设置行间距
    layout.minimumLineSpacing = 10;
    //每个分区的四边间距UIEdgeInsetsMake
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    // 设置Item的估计大小,用于动态设置item的大小，结合自动布局（self-sizing-cell）
    //        layout.estimatedItemSize = CGSizeMake(width , 338.00 / 226.00 * width);
    // 设置布局方向(滚动方向)
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT - 40 - 45 - kNavigationBarHeight - 50)collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = kWhiteColor;
    [self.collectionView registerClass:[CarCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[CarCell class] forCellWithReuseIdentifier:@"cell1"];
    [self.collectionView registerClass:[CarlevelCell class] forCellWithReuseIdentifier:@"level"];
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self.view addSubview:self.collectionView];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.collectionView.yy, SCREEN_WIDTH, 50)];
    
    UIButton * reset = [UIButton buttonWithTitle:@"重置" titleColor:kWhiteColor backgroundColor:kHexColor(@"#313131") titleFont:14 cornerRadius:2];
    reset.frame = CGRectMake(15, 7.5, 85, 35);
    [view addSubview:reset];
    
    UIButton * resultBtn = [UIButton buttonWithTitle:@"有1684款车型符合要求" titleColor:kWhiteColor backgroundColor:MainColor titleFont:14 cornerRadius:2];
    resultBtn.frame = CGRectMake(reset.xx + 15, 7.5, SCREEN_WIDTH - reset.xx - 15  -15, 35);
    [view addSubview:resultBtn];
    
    [self.view addSubview:view];
    
    
    
    [self LoadData];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake((SCREEN_WIDTH - 60) /3, 35);
    }else if (indexPath.section == 1){
        return CGSizeMake((SCREEN_WIDTH - 60) / 3  , 57);
    }
    
    return CGSizeMake((SCREEN_WIDTH - 75) /4, 35);
    
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CarCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.TitleLab.text = [NSString stringWithFormat:@"35万以下%ld",indexPath.row];
        return cell;
    }
    
    if (indexPath.section == 1) {
        CarlevelCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"level" forIndexPath:indexPath];
        return cell;
    }
    
    CarCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    cell.TitleLab.text = [NSString stringWithFormat:@"35万以下%ld",indexPath.row];
    return cell;
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CollectionHeaderView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        view.leftlab.text = @"预算";
    }
    else if (indexPath.section == 1){
        view.leftlab.text = @"级别";
    }
    else if (indexPath.section == 2){
        view.leftlab.text = @"规格/版本";
    }
    else if (indexPath.section == 3){
        view.leftlab.text = @"结构";
    }
    else {
        view.leftlab.text = @"排量";
    }
    
    return view;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 57.5);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//// cell点击变色
//-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    if ([self.collectionView isEqual:collectionView]) {
//        CarCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
//        cell.selected =!cell.selected;
//        cell.backgroundColor = MainColor;
//    }
//}
//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%s", __FUNCTION__);
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%s", __FUNCTION__);
//    return YES;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%s", __FUNCTION__);
//}

#pragma mark - Init
//- (void)initTableView {
//
//    self.tableView = [[NearFutureTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50) style:(UITableViewStyleGrouped)];
//
//    self.tableView.refreshDelegate = self;
//    self.tableView.backgroundColor = kBackgroundColor;
//
//    [self.view addSubview:self.tableView];
//
//}
//
//-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DetailsVC *vc = [[DetailsVC alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    vc.model = _model[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
//}




-(void)LoadData
{

    MinicarsLifeWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"630543";
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[NearFutureModel class]];

    [self.tableView addRefreshAction:^{

        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            //去除没有的币种
            NSLog(@" ==== %@",objs);

            NSMutableArray <NearFutureModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                NearFutureModel *model = (NearFutureModel *)obj;
                [shouldDisplayCoins addObject:model];

            }];

            //
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {


        }];


    }];

    [self.tableView addLoadMoreAction:^{
        helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种
            NSMutableArray <NearFutureModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                NearFutureModel *model = (NearFutureModel *)obj;
                //                if ([[CoinUtil shouldDisplayCoinArray] indexOfObject:currencyModel.currency ] != NSNotFound ) {

                [shouldDisplayCoins addObject:model];
                //                }

            }];

            //
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];

        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView beginRefreshing];
}


@end
