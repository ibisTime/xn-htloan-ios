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
#import "CarModel.h"
#import "ClassifyListVC.h"
#import "ClassifyInfoVC.h"
@interface RecentPaymentsVC ()<RefreshDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>




@property (nonatomic , strong)NSString *priceStart;
@property (nonatomic , strong)NSString *priceEnd;
@property (nonatomic , strong)NSArray *levelList;
@property (nonatomic , strong)NSArray *versionList;
@property (nonatomic , strong)NSArray *structureList;
@property (nonatomic , strong)NSString *displacementStart;
@property (nonatomic , strong)NSString *displacementEnd;




@property (nonatomic , strong)NearFutureTableView *tableView;

@property (nonatomic , strong)NSMutableArray <NearFutureModel *>*model;


@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) UILabel * ResultLab;
@property (nonatomic,strong) NSArray * titlearray;
@property (nonatomic,strong) UIButton * resultBtn;
@property (nonatomic,strong) NSMutableArray *selectArray;
@property (nonatomic,strong) NSMutableArray * selectTitleArray;
@property (nonatomic,strong) NSMutableArray<CarModel *> * CarModels;



@property (nonatomic , strong)NSArray *Array1;
@property (nonatomic , strong)NSMutableArray *Array2;
@property (nonatomic , strong)NSMutableArray *Array3;
@property (nonatomic , strong)NSMutableArray *Array4;
@property (nonatomic , strong)NSArray *Array5;
@end

@implementation RecentPaymentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.titlearray = [NSMutableArray array];
    self.titlearray = @[@[@"35万以下",@"35-50万",@"50-70万",@"70-90万",@"90-110万",@"110-150万",@"150万以上"],
                        @[@"SUV",@"轿车",@"MPV",@"跑车",@"皮卡",@"房车"],
                        @[@"中东",@"美规",@"加规",@"墨版",@"欧规"],
                        @[@"两厢",@"三厢",@"掀背",@"旅行版",@"硬顶敞篷",@"软顶敞篷",@"硬顶跑车"],
                        @[@"2.0L及以下",@"2.1-3.0L",@"3.1-4.0L",@"4.1-5.0L",@"5.0L以上"]];
    
    

    self.Array2 = [NSMutableArray array];
    self.Array3 = [NSMutableArray array];
    self.Array4 = [NSMutableArray array];

    

    
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
    

    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT - 40 - kTabBarHeight - kNavigationBarHeight - 50)collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = kWhiteColor;
    self.collectionView.allowsMultipleSelection = YES;
    [self.collectionView registerClass:[CarCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[CarCell class] forCellWithReuseIdentifier:@"cell1"];
    [self.collectionView registerClass:[CarlevelCell class] forCellWithReuseIdentifier:@"level"];
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self.view addSubview:self.collectionView];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.collectionView.yy, SCREEN_WIDTH, 50)];
    UIButton * reset = [UIButton buttonWithTitle:@"重置" titleColor:kWhiteColor backgroundColor:kHexColor(@"#313131") titleFont:14 cornerRadius:2];
    reset.frame = CGRectMake(15, 7.5, 85, 35);
    [reset addTarget:self action:@selector(resetClick) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:reset];
    UIButton * resultBtn = [UIButton buttonWithTitle:@"搜索车型" titleColor:kWhiteColor backgroundColor:MainColor titleFont:14 cornerRadius:2];
    resultBtn.frame = CGRectMake(reset.xx + 15, 7.5, SCREEN_WIDTH - reset.xx - 15  -15, 35);
    [resultBtn addTarget:self action:@selector(resultClick) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:resultBtn];
    self.resultBtn = resultBtn;
    [self.view addSubview:view];
    
    [self LoadData];
}

//确认按钮a点击方法
-(void)resultClick{
    
//    if (self.CarModels.count == 0) {
//        [TLProgressHUD showInfoWithStatus:@"无车型符合要求"];
//    }else
//    {
        ClassifyInfoVC * vc = [ClassifyInfoVC new];
        vc.title = @"车型";
        vc.priceStart = self.priceStart;
        vc.priceEnd = self.priceEnd;
        vc.levelList = self.levelList;
        vc.versionList = self.versionList;
        vc.structureList = self.structureList;
        vc.displacementStart = self.displacementStart;
        vc.displacementEnd = self.displacementEnd;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
//    }
    
}

-(void)getClassifyListData:(NSString *)code{
    
}

//重置
-(void)resetClick
{
    self.Array1 = @[];
    [self.Array2 removeAllObjects];
    [self.Array3 removeAllObjects];
    [self.Array4 removeAllObjects];
    self.Array5 = @[];
    self.ResultLab.text = @"您选择的条件会显示在这";
    self.CarModels = [NSMutableArray array];
//    [self.resultBtn setTitle:[NSString stringWithFormat:@"搜索车型"] forState:(UIControlStateNormal)];
    [self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSMutableArray * arr =self.titlearray[section];
    return arr.count;
   
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
        cell.TitleLab.text = self.titlearray[indexPath.section][indexPath.row];
//        if ([self.selectArray[indexPath.section] isEqualToString:@""]) {
//            cell.layer.borderColor = kLineColor.CGColor;
//            cell.layer.borderWidth = 1;
//        }else
//        {
//            if (indexPath.row == [self.selectArray[indexPath.section] integerValue]) {
//                cell.layer.borderColor = MainColor.CGColor;
//                cell.layer.borderWidth = 1;
//            }
//            else
//            {
//                cell.layer.borderColor = kLineColor.CGColor;
//                cell.layer.borderWidth = 1;
//            }
//        }
        if ([self.Array1 containsObject:@(indexPath.row)]) {
            cell.layer.borderColor = MainColor.CGColor;
            cell.layer.borderWidth = 1;
        }else
        {
            cell.layer.borderColor = kLineColor.CGColor;
            cell.layer.borderWidth = 1;
        }
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        CarlevelCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"level" forIndexPath:indexPath];
        cell.name.text = self.titlearray[indexPath.section][indexPath.row];
        cell.logo.image = kImage(self.titlearray[indexPath.section][indexPath.row]);
        if ([self.Array2 containsObject:@(indexPath.row)]) {
            cell.name.textColor = MainColor;
        }else
        {
            cell.name.textColor = kTextColor;
        }
        return cell;
    }
    
    CarCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    cell.TitleLab.text = self.titlearray[indexPath.section][indexPath.row];
//    if ([self.selectArray[indexPath.section] isEqualToString:@""]) {
//        cell.layer.borderColor = kLineColor.CGColor;
//        cell.layer.borderWidth = 1;
//    }else
//    {
//        if (indexPath.row == [self.selectArray[indexPath.section] integerValue]) {
//            cell.layer.borderColor = MainColor.CGColor;
//            cell.layer.borderWidth = 1;
//        }else
//        {
//            cell.layer.borderColor = kLineColor.CGColor;
//            cell.layer.borderWidth = 1;
//        }
//    }
    if (indexPath.section == 2) {
        if ([self.Array3 containsObject:@(indexPath.row + 1)]) {
            cell.layer.borderColor = MainColor.CGColor;
            cell.layer.borderWidth = 1;
        }else
        {
            cell.layer.borderColor = kLineColor.CGColor;
            cell.layer.borderWidth = 1;
        }
    }
    if (indexPath.section == 3) {
        if ([self.Array4 containsObject:@(indexPath.row + 1)]) {
            cell.layer.borderColor = MainColor.CGColor;
            cell.layer.borderWidth = 1;
        }else
        {
            cell.layer.borderColor = kLineColor.CGColor;
            cell.layer.borderWidth = 1;
        }
    }
    if (indexPath.section == 4) {
        if ([self.Array5 containsObject:@(indexPath.row)]) {
            cell.layer.borderColor = MainColor.CGColor;
            cell.layer.borderWidth = 1;
        }else
        {
            cell.layer.borderColor = kLineColor.CGColor;
            cell.layer.borderWidth = 1;
        }
    }
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
    return CGSizeMake(SCREEN_WIDTH, 40);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        if ([self.Array1 containsObject:@(indexPath.row)]) {
            self.Array1 = @[];;
        }else
        {
            self.Array1 = @[@(indexPath.row)];;
        }
        
//        [self.Array1 addObjectsFromArray:array];
    }
    if (indexPath.section == 1) {
        
        if ([self.Array2 containsObject:@(indexPath.row)]) {
            [self.Array2 removeObject:@(indexPath.row)];
        }else
        {
            [self.Array2 addObject:@(indexPath.row)];
        }
    }
    if (indexPath.section == 2) {
        
        if ([self.Array3 containsObject:@(indexPath.row + 1)]) {
            [self.Array3 removeObject:@(indexPath.row + 1)];
        }else
        {
            [self.Array3 addObject:@(indexPath.row + 1)];
        }
        
    }
    if (indexPath.section == 3) {
        
        if ([self.Array4 containsObject:@(indexPath.row+ 1)]) {
            [self.Array4 removeObject:@(indexPath.row+ 1)];
        }else
        {
            [self.Array4 addObject:@(indexPath.row+ 1)];
        }
        
    }
    if (indexPath.section == 4) {
        
        if ([self.Array5 containsObject:@(indexPath.row)]) {
            self.Array5 = @[];;
        }else
        {
            self.Array5 = @[@(indexPath.row)];;
        }
        
    }

    
    NSMutableArray *array1 = [NSMutableArray array];
    NSMutableArray *array2 = [NSMutableArray array];
    NSMutableArray *array3 = [NSMutableArray array];
    NSMutableArray *array4 = [NSMutableArray array];
    NSMutableArray *array5 = [NSMutableArray array];
    
    if (self.Array1.count > 0) {
        [array1 addObject:self.titlearray[0][[self.Array1[0] integerValue]]];
    }
    for (int i = 0; i < self.Array2.count; i ++) {
        [array2 addObject:self.titlearray[1][[self.Array2[i] integerValue]]];
    }
    for (int i = 0; i < self.Array3.count; i ++) {
        [array3 addObject:self.titlearray[2][[self.Array3[i] integerValue] - 1]];
    }
    for (int i = 0; i < self.Array4.count; i ++) {
        [array4 addObject:self.titlearray[3][[self.Array4[i] integerValue] - 1]];
    }
    for (int i = 0; i < self.Array5.count; i ++) {
        [array5 addObject:self.titlearray[4][[self.Array5[i] integerValue]]];
    }
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:array1];
    [array addObjectsFromArray:array2];
    [array addObjectsFromArray:array3];
    [array addObjectsFromArray:array4];
    [array addObjectsFromArray:array5];
    NSString *string = [array componentsJoinedByString:@"/"];
    self.ResultLab.text = string;
    [self.collectionView reloadData];
    
    
    
    
    
//    [self.selectArray replaceObjectAtIndex:indexPath.section withObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
    [self getData];
}


-(void)getData{
//    TLNetworking * http = [[TLNetworking alloc]init];
//    http.code = @"630426";
//    http.showView = self.view;
    //根据价格
    if (self.Array1.count > 0) {
    int i = [self.Array1[0] intValue];
    switch (i) {
        case 0:{
            _priceStart =@"0" ;
            _priceEnd = @"350000";
        }
            break;
        case 1:{
            _priceStart =@"350000";
            _priceEnd = @"500000";

        }
            break;
        case 2:{
            _priceStart =@"500000";
            _priceEnd = @"700000";

        }
            break;
        case 3:{
            _priceStart =@"700000";
            _priceEnd = @"900000";

        }
            break;
        case 4:{
            _priceStart =@"900000" ;
            _priceEnd = @"1100000";

        }
            break;
        case 5:{
            _priceStart =@"1100000" ;
            _priceEnd = @"1500000";

        }
            break;
        case 6:{
            _priceStart =@"1500000" ;
            _priceEnd = @"";

        }
            break;
            
        default:
            break;
    }
    }
    //根据级别
    _levelList = self.Array2;

    //根据规格版本
    _versionList = self.Array3;

    //根据结构版本
    _structureList = self.Array4;

    //排量
    if (self.Array5.count > 0) {
        int d = [self.Array5[0] intValue];
        switch (d) {
            case 0:{
                _displacementStart = @"0" ;
                _displacementEnd = @"2.0";
                
            }
                break;
            case 1:{
                _displacementStart =@"2.1" ;
                _displacementEnd = @"3.0";
                
            }
                break;
            case 2:{
                _displacementStart =@"3.1" ;
                _displacementEnd = @"4.0";
                
            }
                break;
            case 3:{
                _displacementStart =@"4.1" ;
                _displacementEnd = @"5.0";
                
            }
                break;
            case 4:{
                _displacementStart =@"5.1" ;
                _displacementEnd = @"";
                
            }
                break;
            default:
                break;
        }
    }
//    http.parameters[@"status"] = @"1";
//    [http postWithSuccess:^(id responseObject) {
//        self.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        NSInteger num = 0;
//        for (int i = 0; i < self.CarModels.count; i ++) {
//            num = num + self.CarModels[i].cars.count;
//        }
////        [self.resultBtn setTitle:[NSString stringWithFormat:@"有%ld款车型符合要求",num] forState:(UIControlStateNormal)];
//    } failure:^(NSError *error) {
//    }];
}




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
