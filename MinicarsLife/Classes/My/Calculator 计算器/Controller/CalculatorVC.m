//
//  CalculatorVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CalculatorVC.h"
#import "LeftHeadCell.h"
#define LeftHead @"LeftHeadCell"
#import "CommonCell.h"
#define Common @"CommonCell"
#import "LeftFootCell.h"
#define leftfoot @"LeftFootCell"
#import "RightHeaderCell.h"
#import "ChooseCarVC.h"
#import "CalculatorModel.h"
#import "CarModel.h"
@interface CalculatorVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>{
    int tag;
}
@property (nonatomic,strong) TLTableView * leftTable;
@property (nonatomic,strong) TLTableView * rightTable;
@property (nonatomic,strong) CalculatorModel * CalculatorModel;
@property (nonatomic,strong) CarModel * CarModel;
@property (nonatomic,strong) NSString * DkYear;
@end

@implementation CalculatorVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.carcode) {
        [self getcarname:self.carcode];
        [self getData:@"12" total:@"0"];
    }
    
    
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    MinicarsLifeWeakSelf;
    
    tag = 0;
    [self createSegMentController];
    
    self.leftTable = [[TLTableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-kNavigationBarHeight) style:UITableViewStylePlain];
    self.leftTable.delegate = self;
    self.leftTable.dataSource = self;
    self.leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTable.refreshDelegate = self;
    [self.leftTable addRefreshAction:^{
        if (weakSelf.carcode) {
            [weakSelf getcarname:weakSelf.carcode];
            
        }
        [weakSelf getData:@"12" total:@"0"];
    }];
    if (self.carcode) {
        [self.leftTable beginRefreshing];
    }
    
    
    [self.view addSubview:self.leftTable];
    
    self.rightTable = [[TLTableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-kNavigationBarHeight) style:UITableViewStylePlain];
    self.rightTable.delegate = self;
    self.rightTable.dataSource = self;
    self.rightTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.rightTable addRefreshAction:^{
        [weakSelf getData:@"12" total:@"0"];
        if (weakSelf.carcode) {
            [weakSelf getcarname:weakSelf.carcode];
            
        }
        
    }];
    if (self.carcode) {
        [self.rightTable beginRefreshing];
    }
    [self.view addSubview:self.rightTable];
    
}

//创建导航栏分栏控件
-(void)createSegMentController{
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"全款",@"贷款",nil];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    
    segmentedControl.frame = CGRectMake(0, 0, 180, 30);
    
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor colorWithRed:252/255.0 green:245/255.0 blue:248/255.0 alpha:1];
    
    [segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    
    [self.navigationItem setTitleView:segmentedControl];
}
-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender
{
    //我定义了一个 NSInteger tag，是为了记录我当前选择的是分段控件的左边还是右边。
    NSInteger selecIndex = sender.selectedSegmentIndex;
    switch(selecIndex){
        case 0:
            self.leftTable.hidden = NO;
            self.rightTable.hidden = YES;
            sender.selectedSegmentIndex=0;
            tag = 0;
//            [self getData:@"12"];
            [self getData:@"12" total:@"0"];
            [self.leftTable reloadData];
            break;
            
        case 1:
            self.leftTable.hidden = YES;
            self.rightTable.hidden = NO;
            sender.selectedSegmentIndex = 1;
            tag=1;
            [self getData:@"12" total:@"1"];
            [self.rightTable reloadData];
            break;
            
        default:
            break;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tag==0){
        return 4;
    }
    else if (tag==1){
        return 6;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tag == 0) {
        NSArray * array = @[@"车型",@"裸车售价"];
        
        
        if (indexPath.row == 0) {
            static NSString *rid=LeftHead;
            LeftHeadCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            if(cell==nil){
                cell=[[LeftHeadCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
            }
            if (self.CalculatorModel.saleAmount) {
                cell.moneystr = [NSString stringWithFormat:@"%@ 元",[self NumberWithFromatter:self.CalculatorModel.saleAmount]];
                cell.moneylab.attributedText = [self getPriceAttribute:cell.moneystr];
            }
            else
                cell.moneylab.attributedText =[self getPriceAttribute:@"00.00 元"];
           
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        else if (indexPath.row == 1||indexPath.row == 2){
            static NSString *rid=Common;
            CommonCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            if(cell==nil){
                cell=[[CommonCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.TitleLab.text = array[indexPath.row-1];
            
            if (indexPath.row == 1) {
                if (self.CarModel) {
                    NSString * str = [NSString stringWithFormat:@"%@ %@ %@",self.CarModel.brandName,self.CarModel.seriesName,self.CarModel.name];
                    cell.ContentLab.text = str;
                }
                else
                    cell.ContentLab.text = @"请选择车型";
            }else if (indexPath.row == 2){
                if (self.CalculatorModel) {
                    cell.ContentLab.text = self.CalculatorModel.saleAmount;
                }
                else
                    cell.ContentLab.text = @"00.00";
            }
            return cell;
        }
        
        static NSString *rid=leftfoot;
        LeftFootCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[LeftFootCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
//        cell.leftmoney.text = [self NumberWithFromatter:self.CalculatorModel.byhf];
//        cell.rightmoney.text = [self NumberWithFromatter:self.CalculatorModel.sybx];
        if (self.CalculatorModel.byhf&&self.CalculatorModel.sybx) {
            cell.leftmoney.text = [self NumberWithFromatter:self.CalculatorModel.byhf];
            cell.rightmoney.text = [self NumberWithFromatter:self.CalculatorModel.sybx];
        }else{
            cell.leftmoney.text = @"00.00";
            cell.rightmoney.text = @"00.00";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    NSArray * array = @[@"车型",@"裸车售价",@"贷款年限",@"裸车首付"];
    
    if (indexPath.row == 0) {
        static NSString *rid=@"cell";
        
        RightHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        
        if(cell==nil){
            
            cell=[[RightHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
            
        }
        
        cell.moneystr = [NSString stringWithFormat:@"%@ 元",[self NumberWithFromatter:self.CalculatorModel.yjsfAmount]];
        if (self.CalculatorModel.monthReply) {
            cell.moneyarray = @[self.CalculatorModel.monthReply,self.CalculatorModel.extraAmount,self.CalculatorModel.totalAmount];
        }
        if (self.CalculatorModel.yjsfAmount) {
            cell.moneylab.attributedText = [self getPriceAttribute:cell.moneystr];
        }
        else
            cell.moneylab.attributedText =[self getPriceAttribute:@"00.00 元"];
//            cell.moneylab.text = @"00.00";
        
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 5) {
        static NSString *rid=leftfoot;
        LeftFootCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[LeftFootCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
        if (self.CalculatorModel.byhf&&self.CalculatorModel.sybx) {
            cell.leftmoney.text = [self NumberWithFromatter:self.CalculatorModel.byhf];
            cell.rightmoney.text = [self NumberWithFromatter:self.CalculatorModel.sybx];
        }else{
            cell.leftmoney.text = @"00.00";
            cell.rightmoney.text = @"00.00";
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *rid=@"com";
    
    CommonCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[CommonCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
    }
    cell.TitleLab.text = array[indexPath.row - 1];
    if (indexPath.row == 1) {
        if (self.CarModel) {
            NSString * str1 = [NSString stringWithFormat:@"%@ %@ %@",self.CarModel.brandName,self.CarModel.seriesName,self.CarModel.name];
            cell.ContentLab.text = str1;
        }
        else
            cell.ContentLab.text = @"暂无车型";
    }else if (indexPath.row == 2){
        if (self.CalculatorModel) {
            NSString * str2 = [self NumberWithFromatter: self.CalculatorModel.saleAmount];
            cell.ContentLab.text = str2;
        }else
            cell.ContentLab.text = @"00.00";
    }else if (indexPath.row == 3){
        cell.ContentLab.text = @"一年";
        if (self.DkYear) {
            cell.ContentLab.text = self.DkYear;
        }
    }
    else{
        if (self.CalculatorModel) {
            NSString * str4 = [self NumberWithFromatter:self.CalculatorModel.sfAmount];
            cell.ContentLab.text = str4;
        }else
            cell.ContentLab.text = @"00.00";
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tag == 0) {
        if (indexPath.row == 0) {
            return 101;
        }
        else if (indexPath.row == 1||indexPath.row == 2){
            return 50;
        }
        else
            return 81;
    }
    if (indexPath.row == 0) {
        return 161;
    }
    else if (indexPath.row == 5){
        return 81;
    }
    
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tag == 0) {
        if (indexPath.row == 1) {
            ChooseCarVC * vc = [ChooseCarVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (tag == 1) {
        if (indexPath.row == 1) {
            ChooseCarVC * vc = [ChooseCarVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 3) {
            NSArray * array1 = @[@"一年",@"两年",@"三年"];
//            NSMutableArray * array = [NSMutableArray arrayWithArray:array1];
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0;  i < array1.count; i ++) {
                [array addObject:[[SelectedListModel alloc] initWithSid:i Title:array1[i]]];
            }
            SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
            view.isSingle = YES;
            view.array = array;
            view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
                [LEEAlert closeWithCompletionBlock:^{
                    SelectedListModel *model = array[0];
                    NSLog(@"选中第%ld行" , model.sid);
                    self.DkYear = array1[model.sid];
                    [self.rightTable reloadData_tl];
                    [self getData:[NSString stringWithFormat:@"%ld",(model.sid + 1) * 12] total:@"0"];
                }];
            };
            [LEEAlert alert].config
            .LeeTitle(@"选择选择贷款年限")
            .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
            .LeeCustomView(view)
            .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
            .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
            .LeeClickBackgroundClose(YES)
            .LeeShow();
        }
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = kWhiteColor;
    UILabel * label = [UILabel labelWithFrame:view.frame textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
    label.text = @"*此结果仅供参考";
    [view addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
-(void)getData : (NSString *)period total:(NSString *)total{
    if (self.carcode) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.showView = self.view;
        http.code = @"630428";
        http.parameters[@"carCode"] =self.carcode;
        if (tag == 0) {
            http.parameters[@"isTotal"] = @"0";
            http.parameters[@"period"] = period;
        }else{
            http.parameters[@"isTotal"] = @"1";
            http.parameters[@"period"] = period;
        }
        [http postWithSuccess:^(id responseObject) {
            self.CalculatorModel = [CalculatorModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.leftTable reloadData_tl];
            [self.rightTable reloadData_tl];
            
            [self.leftTable endRefreshHeader];
            [self.rightTable endRefreshHeader];
        } failure:^(NSError *error) {
            [self.leftTable endRefreshHeader];
            [self.rightTable endRefreshHeader];
        }];
    }
    else{
        [self.leftTable endRefreshHeader];
        [self.rightTable endRefreshHeader];
    }
    
}
-(void)getcarname:(NSString *)code{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630427";
    http.parameters[@"code"] = code;
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        self.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self.leftTable reloadData_tl];
        [self.rightTable reloadData_tl];
        
        [self.leftTable endRefreshHeader];
        [self.rightTable endRefreshHeader];
    } failure:^(NSError *error) {
        [self.leftTable endRefreshHeader];
        [self.rightTable endRefreshHeader];
    }];
}
-(NSString *)NumberWithFromatter:(NSString *)moneystr{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:moneystr];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString *string = [formatter stringFromNumber:number];
    
    return string;
}

-(NSMutableAttributedString *)getPriceAttribute:(NSString *)string{
    
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc]initWithString:string];
    //目的是想改变 ‘/’前面的字体的属性，所以找到目标的range
    NSRange range = [string rangeOfString:@"元"];
    NSRange pointRange = NSMakeRange(0, range.location-1);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = Font(40);
    
    NSMutableDictionary * dic1 = [NSMutableDictionary dictionary];
    dic1[NSFontAttributeName] = Font(20);
    NSRange range1 = NSMakeRange(range.location, 1);
    //赋值
    [attribut addAttributes:dic range:pointRange];
    [attribut addAttributes:dic1 range:range1];
    return attribut;
}
@end
