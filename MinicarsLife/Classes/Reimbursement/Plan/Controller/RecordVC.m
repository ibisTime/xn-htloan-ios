//
//  RecordVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RecordVC.h"
#import "ReimbursementTableView.h"
#import "ReimbursementModel.h"
#import "RecordDetailsVC.h"
#import "BrandTableView.h"
#import "BrandListVC.h"
#import "BrandCollectionCell.h"
#import "CarModel.h"
#import "ClassifyListVC.h"
@interface RecordVC ()<RefreshDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
//@property (nonatomic , strong)ReimbursementTableView *tableView;
@property (nonatomic,strong) BrandTableView * tableview;

@property (nonatomic , strong)NSMutableArray <ReimbursementModel *>*model;
@property (nonatomic,strong) UICollectionView * CollectionView;

@property (nonatomic,strong) NSMutableArray<CarModel *> * HotCarBrands;
@property (nonatomic,strong) NSMutableArray<CarModel *> * NormalCarBrands;
@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@end

@implementation RecordVC

-(BrandTableView *)tableview{
    if (!_tableview) {
        _tableview = [[BrandTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - kTabBarHeight)];
        
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LoadData];
    UIView * headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 205)];
    headview.backgroundColor = kWhiteColor;
    UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 23, 3, 14)];
    v1.backgroundColor = MainColor;
    kViewRadius(v1, 1.5);
    [headview addSubview:v1];
    
    UILabel * label = [UILabel labelWithFrame:CGRectMake(v1.xx + 5, 21, 60, 18) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
    label.text = @"热门品牌";
    [headview addSubview:label];
    
    
    UIButton * button = [UIButton buttonWithTitle:@"更多" titleColor:kTextColor2 backgroundColor:kClearColor titleFont:12 cornerRadius:0];
    [button addTarget:self action:@selector(moreBrand) forControlEvents:(UIControlEventTouchUpInside)];
    button.frame = CGRectMake(SCREEN_WIDTH - 15 - 40, 23, 40, 17);
    [button SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:3 imagePositionBlock:^(UIButton *button) {
        [button setImage:kImage(@"more") forState:(UIControlStateNormal)];
    }];
    [headview addSubview:button];

    
    NSArray * titlearray = @[@"丰田",@"路虎",@"奔驰",@"宝马",@"福特",@"奥迪",@"日产",@"玛莎拉蒂",@"保时捷",@"雷克萨斯"];
   
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat width = (SCREEN_WIDTH - 60.00)/5;
    // 设置每个item的大小
    layout.itemSize = CGSizeMake(width, 70);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 15);
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 41, SCREEN_WIDTH, 205-40) collectionViewLayout:layout];
    self.CollectionView.backgroundColor = kWhiteColor;
    self.CollectionView.delegate = self;
    self.CollectionView.dataSource = self;
    self.CollectionView.scrollEnabled = NO;
    [self.CollectionView registerClass:[BrandCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [headview addSubview:self.CollectionView];
    

    self.tableview.tableHeaderView = headview;
    [self.view addSubview:self.tableview];
    
    
//    [self initTableView];
//    [self LoadData];
}
-(void)clickbtn:(UIButton*)sender{
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.HotCarBrands.count < 5) {
        return 1;
    }
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.HotCarBrands.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BrandCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titlelab.text = self.HotCarBrands[indexPath.row].name;
    [cell.logo sd_setImageWithURL:[NSURL URLWithString:[self.HotCarBrands[indexPath.row].logo convertImageUrl]] placeholderImage:kImage(@"车型库-选中")];
    return cell;
}
-(void)moreBrand{
    BrandListVC * vc = [[BrandListVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [self getClassifyListData:self.HotCarBrands[indexPath.row].code];
}
-(void)getClassifyListData:(NSString *)code{
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.showView = self.view;
    http2.code = @"630416";
    http2.parameters[@"brandCode"] = code;
    [http2 postWithSuccess:^(id responseObject) {
        ClassifyListVC * vc = [ClassifyListVC new];
        vc.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordDetailsVC *vc = [[RecordDetailsVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = _model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)LoadData{
    MinicarsLifeWeakSelf;
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630406";
    http.parameters[@"isReferee"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        self.HotCarBrands = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.CollectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    
    
    TLPageDataHelper * http1 = [TLPageDataHelper new];
    http1.code = @"630405";
    http1.parameters[@""] = @"";
    [http1 modelClass:[CarModel class]];
    http1.tableView = self.tableview;
    http1.isCurrency = YES;
        [self.tableview addRefreshAction:^{
            [http1 refresh:^(NSMutableArray *objs, BOOL stillHave) {
                NSArray<CarModel *> *array = objs;
                NSMutableArray<CarModel *> *allArray = [NSMutableArray array];
                for(int i=0;i<26;i++)
                {
                    NSString *str = [NSString stringWithFormat:@"%c",'A'+ i];
                    NSMutableArray<CarModel *> *rowArray = [NSMutableArray array];
                    for (int j = 0; j < array.count; j ++) {

                        if ([str isEqualToString:array[j].letter]) {
                            [rowArray addObject:array[j]];
                        }
                    }
                    if (rowArray.count > 0) {
                        
                        [allArray addObject:rowArray];
                    }
                    
                }
                
                NSMutableArray *indexArray = [NSMutableArray array];
                for (int i = 0; i < allArray.count; i ++) {
                    NSMutableArray<CarModel *> * model = [CarModel mj_objectArrayWithKeyValuesArray:allArray[i]];
                    [indexArray addObject:[NSString stringWithFormat:@"%@",model[0].letter]];
                }
                weakSelf.tableview.indexArray = indexArray;
                weakSelf.tableview.normalArray = allArray;
                [weakSelf.tableview reloadData];
                [weakSelf.tableview endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshHeader];
        }];
        }];
    [self.tableview beginRefreshing];

    [self.tableview addLoadMoreAction:^{
        [http1 loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSArray *array = objs;
            NSMutableArray *allArray = [NSMutableArray array];
            for(int i=0;i<26;i++)
            {
                NSString *str = [NSString stringWithFormat:@"%c",'A'+ i];
                NSMutableArray *rowArray = [NSMutableArray array];
                for (int j = 0; j < array.count; j ++) {
                    
                    if ([str isEqualToString:array[j][@"letter"]]) {
                        [rowArray addObject:array[j]];
                    }
                }
                
                if (rowArray.count > 0) {
                    [allArray addObject:rowArray];
                }
            }
            NSMutableArray *indexArray = [NSMutableArray array];
            for (int i = 0; i < allArray.count; i ++) {
                [indexArray addObject:[NSString stringWithFormat:@"%@",allArray[i][0][@"letter"]]];
            }
            weakSelf.tableview.indexArray = indexArray;
            weakSelf.tableview.normalArray = allArray;
            [weakSelf.tableview reloadData];
            [weakSelf.tableview endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshFooter];
        }];
    }];
    
}


- (NSMutableArray *)filterMaxItemsArray:(NSArray *)array filterKey:(NSString *)key {
    NSMutableArray *origArray = [NSMutableArray arrayWithArray:array];
    NSMutableArray *filerArray = [NSMutableArray array];
    
    while (origArray.count > 0) {
        id obj = origArray.firstObject;
        NSPredicate *predic = nil;
        
        id value = [obj valueForKey:key];
        predic = [NSPredicate predicateWithFormat:@"self.%@ == %@",key,value];
        
        NSArray *pArray = [origArray filteredArrayUsingPredicate:predic];
        [filerArray addObject:pArray];
        [origArray removeObjectsInArray:pArray];
    }
    return filerArray;
}

#pragma mark - Init
//- (void)initTableView {
//
//    self.tableView = [[ReimbursementTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 50 - kTabBarHeight) style:(UITableViewStyleGrouped)];
//
//    self.tableView.refreshDelegate = self;
//    self.tableView.backgroundColor = kBackgroundColor;
//
//    [self.view addSubview:self.tableView];
//
//}
//-(void)LoadData
//{
//
//    MinicarsLifeWeakSelf;
//
//    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
//    helper.code = @"630520";
//    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
//
//    helper.isList = NO;
//    helper.isCurrency = YES;
//    helper.tableView = self.tableView;
//    [helper modelClass:[ReimbursementModel class]];
//
//    [self.tableView addRefreshAction:^{
//
//        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
//
//            //去除没有的币种
//            NSLog(@" ==== %@",objs);
//
//            NSMutableArray <ReimbursementModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
//            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                ReimbursementModel *model = (ReimbursementModel *)obj;
//                [shouldDisplayCoins addObject:model];
//
//            }];
//
//            //
//            weakSelf.model = shouldDisplayCoins;
//            weakSelf.tableView.model = shouldDisplayCoins;
//            [weakSelf.tableView reloadData_tl];
//
//        } failure:^(NSError *error) {
//
//
//        }];
//
//
//    }];
//
//    [self.tableView addLoadMoreAction:^{
//        helper.parameters[@"status"] = @"1";
//        helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
//        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
//            NSLog(@" ==== %@",objs);
//            //去除没有的币种
//            NSMutableArray <ReimbursementModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
//            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                ReimbursementModel *model = (ReimbursementModel *)obj;
//                //                if ([[CoinUtil shouldDisplayCoinArray] indexOfObject:currencyModel.currency ] != NSNotFound ) {
//
//                [shouldDisplayCoins addObject:model];
//                //                }
//
//            }];
//
//            //
//            weakSelf.model = shouldDisplayCoins;
//            weakSelf.tableView.model = shouldDisplayCoins;
//            [weakSelf.tableView reloadData_tl];
//
//        } failure:^(NSError *error) {
//        }];
//    }];
//
//    [self.tableView beginRefreshing];
//}


@end
