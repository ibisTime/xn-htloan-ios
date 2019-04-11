//
//  SearchVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/18.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "SearchVC.h"
#import "HotBrandCell.h"
#import "ClassifyListVC.h"
#import "ClassifyInfoVC.h"
@interface SearchVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>
@property (nonatomic,strong) UISearchBar * SearchBar;
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSArray * titlearray;
@property (nonatomic,strong) NSMutableArray<CarModel *> * carmodels;
@end

@implementation SearchVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _SearchBar.alpha = 1;
    [_SearchBar resignFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{

    _SearchBar.alpha = 0;
    [_SearchBar resignFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self gethotclassify];
    
    
    
    self.titlearray = [[NSArray alloc]init];

    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 44)];
    view.backgroundColor = kClearColor;
//    view.backgroundColor = [UIColor redColor];
    self.SearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(40, kStatusBarHeight + 5.5, SCREEN_WIDTH - 100, 33)];
//    self.SearchBar.layer.borderWidth = 1;
    self.SearchBar.placeholder = @"请搜索品牌或车系";
    self.SearchBar.backgroundColor = kWhiteColor;
    
    
    self.SearchBar.delegate = self;
    self.SearchBar.backgroundImage = [UIImage imageNamed:@"PYSearch.bundle/clearImage"];
    [self.SearchBar setBackgroundImage:[UIImage new]];
    [self.SearchBar setTranslucent:YES];
    
    kViewRadius(self.SearchBar, 10);
    
    UITextField * searchField = [self.SearchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = [UIColor whiteColor];
    [searchField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    searchField.font = HGfont(14);
    
    [self.navigationController.view addSubview:self.SearchBar];


    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    self.RightButton.titleLabel.font = Font(16);
    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-57.5, 30, 42.5, 45)];
    [self.RightButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.RightButton addTarget:self action:@selector(searchClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.navigationItem.titleView = view;
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    // 设置Item的估计大小,用于动态设置item的大小，结合自动布局（self-sizing-cell）
    //        layout.estimatedItemSize = CGSizeMake(width , 338.00 / 226.00 * width);
    // 设置布局方向(滚动方向)
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UILabel* label = [UILabel labelWithFrame:CGRectMake(15, 25, SCREEN_WIDTH - 30, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#B9B9B9")];
    label.text = @"热门车系";
    [self.view addSubview:label];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, label.yy + 5, SCREEN_WIDTH, SCREEN_HEIGHT - 40 - 45 - kNavigationBarHeight - 50)collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = kWhiteColor;
    [self.collectionView registerClass:[HotBrandCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    
}

- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.carmodels.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotBrandCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    CarModel * model = [CarModel mj_objectWithKeyValues:self.carmodels[indexPath.row]];
    cell.titlelab.text = model.name;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     CarModel * model = [CarModel mj_objectWithKeyValues:self.carmodels[indexPath.row]];
//    [self getClassifyData:model.code :model.name];
    ClassifyInfoVC * vc = [ClassifyInfoVC new];
//    vc.models = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//    vc.seriesCode = model.code;
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = model.name;
    [self.navigationController pushViewController:vc animated:YES];
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CarModel * model = [CarModel mj_objectWithKeyValues:self.carmodels[indexPath.row]];
    CGSize size = [model.name sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Font(14),NSFontAttributeName,nil]];
    // 名字的H
    CGFloat nameW = size.width;
    return CGSizeMake(nameW + 20, 40);
}

-(void)searchClick{
    [self searchBarSearchButtonClicked:self.SearchBar];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (searchBar.text.length == 0) {
        [TLProgressHUD showInfoWithStatus:@"请输入搜索内容"];
    }else{
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630426";
        http.parameters[@"status"] = @"1";
        http.parameters[@"queryName"] = searchBar.text;
        [http postWithSuccess:^(id responseObject) {
            ClassifyListVC * vc = [ClassifyListVC new];
            vc.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            vc.state = @"1";
            [self.navigationController pushViewController:vc animated:YES];
            
        } failure:^(NSError *error) {
            
        }];
    }
}


-(void)gethotclassify{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630416";
    http.parameters[@"status"] = @"1";
    http.parameters[@"location"] = @"0";
    [http postWithSuccess:^(id responseObject) {
        self.carmodels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)getClassifyData:(NSString*)code :(NSString *)title{
    //列表查询车型
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.showView = self.view;
    http2.code = @"630426";
    http2.parameters[@"status"] = @"1";
    http2.parameters[@"location"] = @"0";
    http2.parameters[@"seriesCode"] = code;
    [http2 postWithSuccess:^(id responseObject) {
        ClassifyInfoVC * vc = [ClassifyInfoVC new];
        vc.models = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}
@end
