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
@interface CalculatorVC ()<UITableViewDelegate,UITableViewDataSource>{
    int tag;
}
@property (nonatomic,strong) TLTableView * leftTable;
@property (nonatomic,strong) TLTableView * rightTable;
@end

@implementation CalculatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    tag = 0;
    [self createSegMentController];
    
    self.leftTable = [[TLTableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-kNavigationBarHeight) style:UITableViewStylePlain];
    self.leftTable.delegate = self;
    self.leftTable.dataSource = self;
    self.leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.leftTable];
    
    self.rightTable = [[TLTableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-kNavigationBarHeight) style:UITableViewStylePlain];
    self.rightTable.delegate = self;
    self.rightTable.dataSource = self;
    self.rightTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
            [self.leftTable reloadData];
            break;
            
        case 1:
            self.leftTable.hidden = YES;
            self.rightTable.hidden = NO;
            sender.selectedSegmentIndex = 1;
            tag=1;
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
            return cell;
        }
        
        static NSString *rid=leftfoot;
        LeftFootCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[LeftFootCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 5) {
        static NSString *rid=leftfoot;
        LeftFootCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[LeftFootCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tag == 0) {
        if (indexPath.row == 0) {
            return 100;
        }
        else if (indexPath.row == 1||indexPath.row == 2){
            return 50;
        }
        else
            return 81;
    }
    if (indexPath.row == 0) {
        return 171+30;
    }
    else if (indexPath.row == 5){
        return 81;
    }
    
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = kWhiteColor;
    UILabel * label = [UILabel labelWithFrame:view.frame textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kBlackColor];
    label.text = @"*此结果仅供参考";
    [view addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
@end
