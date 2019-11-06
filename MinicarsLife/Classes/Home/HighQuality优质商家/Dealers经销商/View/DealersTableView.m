//
//  DealersTableView.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/8/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "DealersTableView.h"
#import "MainProductsCell.h"
#import "HomeTableHeadCell.h"
#import "NewsCell.h"
@interface DealersTableView()<UITableViewDelegate, UITableViewDataSource,ClickBtn,MainProductsSelectRowDelegate>
{
    NSMutableArray *arr;
}

@end

@implementation DealersTableView

static NSString *MyAsstes = @"MyAsstesCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MainProductsCell class] forCellReuseIdentifier:MyAsstes];
        [self registerClass:[HomeTableHeadCell class] forCellReuseIdentifier:@"HomeTableHeadCell"];
        [self registerClass:[NewsCell class] forCellReuseIdentifier:@"NewsCell"];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark - UITableViewDataSource;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.NewsModels.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MainProductsCell *cell = [tableView dequeueReusableCellWithIdentifier:MyAsstes forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dealersModel = self.dealersModel;
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        HomeTableHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableHeadCell" forIndexPath:indexPath];
        cell.CarStyleModels = self.CarModelsCars;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    NewsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.NewsModels[indexPath.row];
    cell.newstagDataAry = self.newstagDataAry;
    return cell;
}

- (void)MainProductsSelectRow:(NSInteger)index
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:index selectRowState:@""];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.refreshDelegate refreshTableView:self scrollView:scrollView];
}

-(void)ClickCollection:(NSInteger)index
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:index];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 200;
    }
    if (indexPath.section == 2) {
        return 105;
    }
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    NSArray *ary = @[@"店内主营",@"经典车型",@"店铺动态"];
    UILabel * label = [UILabel labelWithFrame:CGRectMake(15, 0, 70, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(16) textColor:kBlackColor];
    label.text = ary[section];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section != 2) {
        return 10;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section != 2) {
        UIView * view = [[UIView alloc]init];
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        v1.backgroundColor = kBackgroundColor;
        [view addSubview:v1];
        return view;
    }
    return nil;
}

@end
