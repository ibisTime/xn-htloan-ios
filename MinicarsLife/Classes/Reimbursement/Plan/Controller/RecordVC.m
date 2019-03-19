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
@interface RecordVC ()<RefreshDelegate>
//@property (nonatomic , strong)ReimbursementTableView *tableView;
@property (nonatomic,strong) BrandTableView * tableview;

@property (nonatomic , strong)NSMutableArray <ReimbursementModel *>*model;

@end

@implementation RecordVC

-(BrandTableView *)tableview{
    if (!_tableview) {
        _tableview = [[BrandTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
        
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    
    for (int i= 0; i < 10; i ++) {
        UIButton * button = [UIButton buttonWithTitle:@"" titleColor:kBlackColor backgroundColor:kClearColor titleFont:12 cornerRadius:0];
        button.tag = i;
        [button addTarget:self action:@selector(clickbtn:) forControlEvents:(UIControlEventTouchUpInside)];
        button.frame = CGRectMake(i % 5 * (kScreenWidth/5),label.yy + 16 + i / 5 * (56.5 + 20), SCREEN_WIDTH/5, 56.5);
        [headview addSubview:button];
        
//        [button SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:0 imagePositionBlock:^(UIButton *button) {
//            [button setImage:kImage(@"车型库-选中") forState:(UIControlStateNormal)];
//        }];
        
        UIImageView *iconImgae = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH/5, 30)];
        iconImgae.image = kImage(@"车型库-选中");
//        [iconImgae setContentScaleFactor:[[UIScreen mainScreen] scale]];
        iconImgae.contentMode =  UIViewContentModeScaleAspectFit;
//        iconImgae.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        iconImgae.clipsToBounds  = YES;
        [button addSubview:iconImgae];
        
        UILabel *iconLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH/5, 16.5)];
        iconLbl.text = titlearray[i];
        iconLbl.textAlignment = NSTextAlignmentCenter;
        iconLbl.textColor = kHexColor(@"#333333");
        iconLbl.font = Font(12);
        [button addSubview:iconLbl];
    }
    
//    for (int j = 0; j < 5; j ++) {
//        UIButton * button = [UIButton buttonWithTitle:titlearray[j] titleColor:kBlackColor backgroundColor:kClearColor titleFont:13 cornerRadius:0];
//        button.tag = j;
//        [button addTarget:self action:@selector(clickbtn:) forControlEvents:(UIControlEventTouchUpInside)];
//        button.frame = CGRectMake(15 + (SCREEN_WIDTH-30)/5 * j, label.yy + 17, (SCREEN_WIDTH-30)/5, 53);
//        [headview addSubview:button];
//    }
//    for (int j = 0; j < 5; j ++) {
//        UIButton * button = [UIButton buttonWithTitle:@"" titleColor:kBlackColor backgroundColor:kClearColor titleFont:13 cornerRadius:0];
//        button.tag = j + 4;
//        [button addTarget:self action:@selector(clickbtn:) forControlEvents:(UIControlEventTouchUpInside)];
//        button.frame = CGRectMake(15 + (SCREEN_WIDTH-30)/5 * j, label.yy + 3.5 + 100, (SCREEN_WIDTH-30)/5, 53);
//        [button setTitle:titlearray[j + 4] forState:(UIControlStateNormal)];
//
////        [button SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:5 imagePositionBlock:^(UIButton *button) {
////            [button setImage:kImage(logoarray[j + 5]) forState:(UIControlStateNormal)];
////        }];
//
//        [headview addSubview:button];
//
//        if (j < 4) {
//            UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15 + (SCREEN_WIDTH-30)/5 * (j+1), label.yy + 3.5 + 100, 1, 20)];
//            v1.backgroundColor = kLineColor;
//            [headview addSubview:v1];
//        }
//    }
    
    
//    [self.view addSubview:headview];
    self.tableview.tableHeaderView = headview;
    [self.view addSubview:self.tableview];
    
    
//    [self initTableView];
//    [self LoadData];
}
-(void)clickbtn:(UIButton*)sender{
    
}

-(void)moreBrand{
    BrandListVC * vc = [[BrandListVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordDetailsVC *vc = [[RecordDetailsVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = _model[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


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
