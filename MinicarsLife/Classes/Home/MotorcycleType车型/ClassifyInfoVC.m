//
//  ClassifyInfoVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "ClassifyInfoVC.h"
#import "ClassifyInfoCell.h"
#import "CarInfoVC.h"
#import "ImageBrowserViewController.h"
#import "ImageBrowsingVC.h"
#import "HW3DBannerView.h"
#import "UITableView+AddForPlaceholder.h"
@interface ClassifyInfoVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate,HW3DBannerViewDelegate>
{
    ClassifyInfoCell *cell;
}
@property (nonatomic,strong) TLTableView * tableview;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSMutableArray<CarModel *> * carModel;

@end

@implementation ClassifyInfoVC
-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarHeight)];
//        if (self.models.count > 0) {
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.refreshDelegate = self;
        _tableview.defaultNoDataText = @"";
        _tableview.defaultNoDataImage = kImage(@"");
//        }
        [_tableview registerClass:[ClassifyInfoCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
//    if (self.models.cars.count > 0) {
//
//    }
    self.carModel = [CarModel mj_objectArrayWithKeyValuesArray:self.models.cars];
    [self loaddata];
//    [self car_versionLoadData];
    if (self.models) {
        [self TopView];
    }
//    [self.tableview beginRefreshing];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.models.cars.count;
    return self.carModel.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    
    cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        cell=[[ClassifyInfoCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
    }
//    cell.carmodel = [CarModel mj_objectWithKeyValues: self.models.cars[indexPath.row]];
    cell.carmodel = [CarModel mj_objectWithKeyValues:self.carModel[indexPath.row]];
//    cell.dataArray = self.dataArray;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cell.v1.yy;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CarModel * model = [CarModel mj_objectWithKeyValues:self.carModel[indexPath.row]];
    [self getcarinfo:model.code];
}

-(void)loaddata{
    MJWeakSelf;
    TLPageDataHelper * help = [TLPageDataHelper new];
    help.code = @"630492";
    help.parameters[@"seriesCode"] = self.models.code;
    help.parameters[@"brandCode"] = self.brandCode;
    help.parameters[@"carDealerCode"] = self.carDealerCode;
//    help.parameters[@"type"] = @"2";
    help.parameters[@"priceStart"] =[NSString stringWithFormat:@"%.0f",[self.priceStart floatValue]*1000];
    help.parameters[@"priceEnd"] =[NSString stringWithFormat:@"%.0f",[self.priceEnd floatValue]*1000];
    
    help.parameters[@"levelList"] =_levelList;
    help.parameters[@"versionList"] =_versionList;
    help.parameters[@"structureList"] =_structureList;
    help.parameters[@"displacementStart"] =_displacementStart;
    help.parameters[@"displacementEnd"] =_displacementEnd;
    help.parameters[@"queryName"] = self.queryName;
    help.tableView = self.tableview;
    [help modelClass:[CarModel class]];
    help.isCurrency = YES;
    [self.tableview addRefreshAction:^{
        [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.carModel = objs;
            [weakSelf.tableview reloadData];
            [weakSelf.tableview endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshHeader];
        }];
    }];
    [self.tableview addLoadMoreAction:^{
        [help loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.carModel = objs;
            [weakSelf.tableview reloadData];
            [weakSelf.tableview endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshFooter];
        }];
    }];
    [self.tableview beginRefreshing];
}



//-(void)car_versionLoadData
//{
//    TLNetworking *http = [TLNetworking new];
//    http.code = @"630036";
//    http.parameters[@"parentKey"] = @"car_version";
//    [http postWithSuccess:^(id responseObject) {
//
//        self.dataArray = responseObject[@"data"];
//        [self.tableview reloadData];
//
//    } failure:^(NSError *error) {
//
//    }];
//}
-(void)getcarinfo:(NSString *)code{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630427";
    http.showView = self.view;
    http.parameters[@"code"] = code;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        CarInfoVC * vc = [CarInfoVC new];
        vc.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}


-(void)TopView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, (440.00/690.00) * (SCREEN_WIDTH - 30) + 30)];
    
    NSArray * p= [self.models.advPic componentsSeparatedByString:@"||"];
    NSMutableArray *topImage = [NSMutableArray array];
    for (int i = 0; i < p.count; i ++) {
        [topImage addObject:[p[i] convertImageUrl]];
    }
    HW3DBannerView *_scrollView = [HW3DBannerView initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30 , (440.00/690.00) * (SCREEN_WIDTH - 30)) imageSpacing:15 imageWidth:SCREEN_WIDTH - 30];
    _scrollView.autoScroll = NO;
    _scrollView.userInteractionEnabled=YES;
    _scrollView.placeHolderImage = kImage(@"default_pic"); // 设置占位图片
    _scrollView.delegate = self;
    _scrollView.data = topImage;
    [view addSubview:_scrollView];
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, (440.00/690.00) * (SCREEN_WIDTH - 30))];
    [view addSubview:image];
    
    UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, image.height - 70, image.width, 70)];
    v1.backgroundColor = RGB(84, 84, 84);
    v1.alpha = 0.4;
    [image addSubview:v1];
    
    UILabel * titlelab = [UILabel labelWithFrame:CGRectMake(15, image.height - 70 + 16.5, view.width - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
    titlelab.text = self.title;

    [image addSubview:titlelab];
    
    UILabel * moneylab = [UILabel labelWithFrame:CGRectMake(15, image.height - 70 + 36.5, view.width / 2, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16.5) textColor:kWhiteColor];
    moneylab.text = [NSString stringWithFormat:@"%.2f-%.2f万",[self.models.lowest floatValue]/10000/1000,[self.models.highest floatValue]/10000/1000];
    [image addSubview:moneylab];
    
    UILabel * numberLabel = [UILabel labelWithFrame:CGRectMake( 4, 0, 30, 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
    numberLabel.text = self.models.picNumber;
    [numberLabel sizeToFit];
    numberLabel.frame = CGRectMake(view.width - 15 - numberLabel.width, image.height - 70 + 36.5, numberLabel.width, 22);
    [image addSubview:numberLabel];
    
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(view.width - 15 - numberLabel.width - 13-5, image.height - 70 + 36.5 + 6, 13, 10.65)];
    img.image = kImage(@"图片");
    [image addSubview:img];
    self.tableview.tableHeaderView = view;


    
}


-(void)HW3DBannerViewClick:(NSInteger)currentImageIndex
{
    NSArray * p= [self.models.advPic componentsSeparatedByString:@"||"];
    NSMutableArray *topImage = [NSMutableArray array];
    for (int i = 0; i < p.count; i ++) {
        [topImage addObject:[p[i] convertImageUrl]];
    }
    //    NSArray *array = self.models[0].advPic;
    ImageBrowsingVC *vc = [ImageBrowsingVC new];
    vc.imageArray = topImage;
    vc.title = self.title;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
