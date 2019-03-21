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
@interface RecentPaymentsVC ()<RefreshDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic , strong)NearFutureTableView *tableView;

@property (nonatomic , strong)NSMutableArray <NearFutureModel *>*model;


@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) UILabel * ResultLab;
@property (nonatomic,strong) NSArray * titlearray;
@property (nonatomic,strong) UIButton * resultBtn;
@property (nonatomic,strong) NSMutableArray *selectArray;
@property (nonatomic,strong) NSMutableArray * selectTitleArray;
@property (nonatomic,strong) NSMutableArray<CarModel *> * CarModels;
@end

@implementation RecentPaymentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.titlearray = [NSMutableArray array];
    self.titlearray = @[@[@"35万以下",@"35-50万",@"50-70万",@"70-90万",@"90-110万",@"110-150万",@"150万以上"],
                        @[@[@"1",@"2",@"3",@"3",@"2",@"1"],@[@"SUV",@"轿车",@"MPV",@"跑车",@"皮卡",@"房车"]],
                        @[@"中东",@"美规",@"加规",@"墨版",@"欧规"],
                        @[@"两厢",@"三厢",@"掀背",@"旅行版",@"硬顶敞篷",@"软顶敞篷",@"硬顶跑车"],
                        @[@"2.0L以下",@"2.1-3.0L",@"3.1-4.0L",@"4.1-5.0L",@"5.0L以上"]];
    self.selectArray = [NSMutableArray array];
    [self.selectArray addObjectsFromArray:@[@"",@"",@"",@"",@""]];
    self.selectTitleArray = [NSMutableArray array];
    [self.selectTitleArray addObjectsFromArray:@[@"",@"",@"",@"",@""]];
    
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
    UIButton * resultBtn = [UIButton buttonWithTitle:@"有0款车型符合要求" titleColor:kWhiteColor backgroundColor:MainColor titleFont:14 cornerRadius:2];
    resultBtn.frame = CGRectMake(reset.xx + 15, 7.5, SCREEN_WIDTH - reset.xx - 15  -15, 35);
    [resultBtn addTarget:self action:@selector(resultClick) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:resultBtn];
    self.resultBtn = resultBtn;
    [self.view addSubview:view];
    
    
    
    [self LoadData];
}
-(void)resultClick{
    ClassifyListVC * vc = [ClassifyListVC new];
    vc.CarModels = self.CarModels;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)getClassifyListData:(NSString *)code{
    
}
-(void)resetClick
{
    self.selectArray = [NSMutableArray array];
    [self.selectArray addObjectsFromArray:@[@"",@"",@"",@"",@""]];
    self.selectTitleArray = [NSMutableArray array];
    [self.selectTitleArray addObjectsFromArray:@[@"",@"",@"",@"",@""]];
    self.ResultLab.text = @"您选择的条件会显示在这";
    [self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 1) {
        NSMutableArray * arr =self.titlearray[section][0];
        return arr.count;
    }
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
        if ([self.selectArray[indexPath.section] isEqualToString:@""]) {
            cell.layer.borderColor = kLineColor.CGColor;
            cell.layer.borderWidth = 1;
        }else
        {
            if (indexPath.row == [self.selectArray[indexPath.section] integerValue]) {
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
    
    if (indexPath.section == 1) {
        CarlevelCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"level" forIndexPath:indexPath];
        cell.name.text = self.titlearray[indexPath.section][1][indexPath.row];
        cell.logo.image = kImage(self.titlearray[indexPath.section][0][indexPath.row]);
        if ([self.selectArray[indexPath.section] isEqualToString:@""]) {
            cell.name.textColor = kTextColor;
        }else
        {
            if (indexPath.row == [self.selectArray[indexPath.section] integerValue]) {
                cell.name.textColor = MainColor;
            }else
            {
                cell.name.textColor = kTextColor;
            }
        }
        return cell;
    }
    
    CarCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    cell.TitleLab.text = self.titlearray[indexPath.section][indexPath.row];
    if ([self.selectArray[indexPath.section] isEqualToString:@""]) {
        cell.layer.borderColor = kLineColor.CGColor;
        cell.layer.borderWidth = 1;
    }else
    {
        if (indexPath.row == [self.selectArray[indexPath.section] integerValue]) {
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
    [self.selectArray replaceObjectAtIndex:indexPath.section withObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
    [self getData:indexPath];
    if (indexPath.section == 1) {
        [self.selectTitleArray replaceObjectAtIndex:indexPath.section withObject:[NSString stringWithFormat:@"%@",self.titlearray[indexPath.section][1][indexPath.row]]];
    }
    else
        [self.selectTitleArray replaceObjectAtIndex:indexPath.section withObject:[NSString stringWithFormat:@"%@",self.titlearray[indexPath.section][indexPath.row]]];
    
    NSMutableArray *newArray = [NSMutableArray array];
    
    for (int i = 0;i < self.selectTitleArray.count; i++) {
        NSString *string = [self.selectTitleArray objectAtIndex:i];
        if ( ! [newArray containsObject:string] ){
            [newArray addObject:string];
            
        }
        
    }
    NSString *string = [newArray componentsJoinedByString:@"/"];
    self.ResultLab.text = string;
    [self.collectionView reloadData];
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
     [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:indexPath.section] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}

-(void)getData:(NSIndexPath *)indexPath{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630426";
    
    //根据价格
    if (![self.selectArray[0] isEqualToString:@""]) {
    int i = [self.selectArray[0] intValue];
    switch (i) {
        case 0:{
            http.parameters[@"priceStart"] =@"" ;
            http.parameters[@"priceEnd"] = @"350000";

        }
            break;
        case 1:{
            http.parameters[@"priceStart"] =@"350000" ;
            http.parameters[@"priceEnd"] = @"500000";

        }
            break;
        case 2:{
            http.parameters[@"priceStart"] =@"500000" ;
            http.parameters[@"priceEnd"] = @"700000";

        }
            break;
        case 3:{
            http.parameters[@"priceStart"] =@"700000" ;
            http.parameters[@"priceEnd"] = @"900000";

        }
            break;
        case 4:{
            http.parameters[@"priceStart"] =@"900000" ;
            http.parameters[@"priceEnd"] = @"1100000";

        }
            break;
        case 5:{
            http.parameters[@"priceStart"] =@"1100000" ;
            http.parameters[@"priceEnd"] = @"1500000";

        }
            break;
        case 6:{
            http.parameters[@"priceStart"] =@"1500000" ;
            http.parameters[@"priceEnd"] = @"";

        }
            break;
            
        default:
            break;
    }
    }
    //根据级别
    if (![self.selectArray[1] isEqualToString:@""]) {
    int a = [self.selectArray[1] intValue];
    switch (a) {
        case 0:{
            NSArray  *levelList = @[@"0"];
            http.parameters[@"levelList"] = levelList;
        }
            break;
        case 1:{
            NSArray  *levelList = @[@"1"];
            http.parameters[@"levelList"] = levelList;
        }
            break;
        case 2:{
            NSArray  *levelList = @[@"2"];
            http.parameters[@"levelList"] = levelList;
        }
            break;
        case 3:{
            NSArray  *levelList = @[@"3"];
            http.parameters[@"levelList"] = levelList;
        }
            break;
        case 4:{
            NSArray  *levelList = @[@"4"];
            http.parameters[@"levelList"] = levelList;
        }
            break;
        case 5:{
            NSArray  *levelList = @[@"5"];
            http.parameters[@"levelList"] = levelList;
        }
            break;
            
        default:
            break;
    }
    }
    //根据规格版本
    if (![self.selectArray[2] isEqualToString:@""]) {
    int b = [self.selectArray[2] intValue];
    switch (b) {
        case 0:{
            NSArray  *versionList = @[@"1"];
            http.parameters[@"versionList"] = versionList;
        }
            break;
        case 1:{
            NSArray  *versionList = @[@"2"];
            http.parameters[@"versionList"] = versionList;
        }
            break;
        case 2:{
            NSArray  *versionList = @[@"3"];
            http.parameters[@"versionList"] = versionList;
        }
            break;
        case 3:{
            NSArray  *versionList = @[@"4"];
            http.parameters[@"versionList"] = versionList;
        }
            break;
        case 4:{
            NSArray  *versionList = @[@"5"];
            http.parameters[@"versionList"] = versionList;
        }
            break;
            
        default:
            break;
    }
    }
    //根据结构版本
    if (![self.selectArray[3] isEqualToString:@""]) {
    int c = [self.selectArray[3] intValue];
    switch (c) {
        case 0:{
            NSArray  *structureList = @[@"1"];
            http.parameters[@"structureList"] = structureList;
        }
            break;
        case 1:{
            NSArray  *structureList = @[@"2"];
            http.parameters[@"structureList"] = structureList;
        }
            break;
        case 2:{
            NSArray  *structureList = @[@"3"];
            http.parameters[@"structureList"] = structureList;
        }
            break;
        case 3:{
            NSArray  *structureList = @[@"4"];
            http.parameters[@"structureList"] = structureList;
        }
            break;
        case 4:{
            NSArray  *structureList = @[@"5"];
            http.parameters[@"structureList"] = structureList;
        }
            break;
        case 5:{
            NSArray  *structureList = @[@"6"];
            http.parameters[@"structureList"] = structureList;
        }
            break;
        case 6:{
            NSArray  *structureList = @[@"7"];
            http.parameters[@"structureList"] = structureList;
        }
            break;
            
        default:
            break;
    }
    }
    //排量
    if (![self.selectArray[4] isEqualToString:@""]) {
        int d = [self.selectArray[4] intValue];
        switch (d) {
            case 0:{
                http.parameters[@"displacementStart"] =@"" ;
                http.parameters[@"displacementEnd"] = @"2.0";
                
            }
                break;
            case 1:{
                http.parameters[@"displacementStart"] =@"2.1" ;
                http.parameters[@"displacementEnd"] = @"3.0";
                
            }
                break;
            case 2:{
                http.parameters[@"displacementStart"] =@"3.1" ;
                http.parameters[@"displacementEnd"] = @"4.0";
                
            }
                break;
            case 3:{
                http.parameters[@"displacementStart"] =@"4.1" ;
                http.parameters[@"displacementEnd"] = @"5.0";
                
            }
                break;
            case 4:{
                http.parameters[@"displacementStart"] =@"5.1" ;
                http.parameters[@"displacementEnd"] = @"";
                
            }
                break;
            default:
                break;
        }
    }
    
    [http postWithSuccess:^(id responseObject) {
        self.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.resultBtn setTitle:[NSString stringWithFormat:@"有%ld款车型符合要求",self.CarModels.count] forState:(UIControlStateNormal)];
    } failure:^(NSError *error) {

    }];
}


















//-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
////// cell点击变色
//-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
////    if ([self.collectionView isEqual:collectionView]) {
////        CarCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
////        cell.selected =!cell.selected;
////        cell.backgroundColor = MainColor;
////    }
//    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = MainColor;
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
