//
//  SearchVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/18.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "SearchVC.h"
#import "HotBrandCell.h"
@interface SearchVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UISearchBar * SearchBar;
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSArray * titlearray;
@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.titlearray = [[NSArray alloc]init];
    self.titlearray = @[@"揽胜运动3.0柴油",@"奔驰GLE400",@"酷路泽4500",@"揽胜运动3.0汽油",@"Levante"];
    
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(-35, 0, SCREEN_WIDTH, 44)];
    view.backgroundColor = kClearColor;
    self.SearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 5.5, 272, 33)];
//    self.SearchBar.layer.borderWidth = 1;
    self.SearchBar.placeholder = @"请搜索品牌或车系";
    self.SearchBar.backgroundColor = kClearColor;
//    self.SearchBar.barStyle = UIBarStyleBlack;
    
    UIImage* searchBarBg = [self GetImageWithColor:[UIColor clearColor] andHeight:32.0f];
    [self.SearchBar setBackgroundImage:searchBarBg];
    
    
    
    [view addSubview:self.SearchBar];
    
    UIButton * button = [UIButton buttonWithTitle:@"搜索" titleColor:kWhiteColor backgroundColor:kClearColor titleFont:16 cornerRadius:0];
    button.frame = CGRectMake(self.SearchBar.xx + 6, 15, 33, 22.5);
    [view addSubview:button];
    
    self.navigationItem.titleView = view;
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    // 设置Item的估计大小,用于动态设置item的大小，结合自动布局（self-sizing-cell）
    //        layout.estimatedItemSize = CGSizeMake(width , 338.00 / 226.00 * width);
    // 设置布局方向(滚动方向)
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UILabel* label = [UILabel labelWithFrame:CGRectMake(15, 69, SCREEN_WIDTH - 30, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#B9B9B9")];
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
    
    // Do any additional setup after loading the view.
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
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotBrandCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titlelab.text = self.titlearray[indexPath.row];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize size = [self.titlearray[indexPath.row] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Font(14),NSFontAttributeName,nil]];
    // 名字的H
    CGFloat nameW = size.width;
    
    return CGSizeMake(nameW + 10, 40);
}

@end
