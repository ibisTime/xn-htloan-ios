//
//  CarsTableView.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/4.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CarsTableView.h"
#import "HomeTableHeadCell.h"
#import "PopularBrandCell.h"
#import "BrandTableViewCell.h"
@interface CarsTableView()<UITableViewDelegate, UITableViewDataSource,PopularBrandCellClick,ClickBtn>


@end

@implementation CarsTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[HomeTableHeadCell class] forCellReuseIdentifier:@"HomeTableHeadCell"];
        [self registerClass:[PopularBrandCell class] forCellReuseIdentifier:@"PopularBrandCell"];
        self.estimatedSectionHeaderHeight = 30;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2 + self.normalArray.count;
}

#pragma mark - UITableViewDataSource;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }
    NSArray<CarModel *> *array =[CarModel mj_objectArrayWithKeyValuesArray:self.normalArray[section - 2]];
    //    NSArray <CarModel *>*model = [CarModel mj_objectArrayWithKeyValuesArray:self.NormalCarBrands[section]];
    return array.count;
//    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        HomeTableHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableHeadCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.CarStyleModels = self.carsModels;
        cell.delegate = self;
        return cell;
    }
    
    if (indexPath.section == 1) {
        PopularBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PopularBrandCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.HotCarBrands = self.HotCarBrands;
        cell.delegate = self;
        return cell;
    }
    
    static NSString *rid=@"cell";
    
    BrandTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[BrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    NSMutableArray<CarModel *> *carmodel = [CarModel mj_objectArrayWithKeyValuesArray:self.normalArray[indexPath.section - 2]];
    cell.namelab.text = carmodel[indexPath.row].name;
    [cell.logo sd_setImageWithURL:[NSURL URLWithString:[carmodel[indexPath.row].logo convertImageUrl]]];
    //超出容器范围的切除掉
    if (indexPath.row == carmodel.count - 1 ) {
        cell.v1.hidden = YES;
    }else
    {
        cell.v1.hidden = NO;
    }
    //    cell.logo.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)ClickCollection:(NSInteger)index
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:index selectRowState:@"精选车源"];
}

-(void)PopularBrandCellClickCollection:(NSInteger)index
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:index selectRowState:@"热门品牌"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 190;
    }
    if (indexPath.section == 1) {
        float numberToRound;
        int result;
        CGFloat width = (SCREEN_WIDTH - 60.00)/5;
        numberToRound = (self.HotCarBrands.count)/5.0;
        result = (int)ceilf(numberToRound);
        return width *result + 40 + 20;
    }
    return 55;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    for (UIView *view in [tableView subviews]) {
        if ([[[view class] description] isEqualToString:@"UITableViewIndex"]) {
            UILabel *desLbl = (UILabel *)view;
            desLbl.height = 20;
            desLbl.frame = CGRectMake(15, 0, SCREEN_WIDTH - 30, 20);\
            desLbl.font = Font(12);
        }
    }
    NSMutableArray<CarModel *> *carmodel = [CarModel mj_objectArrayWithKeyValuesArray:self.normalArray[section - 2]];
    return carmodel[0].letter;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0 || section == 1) {
        return 50;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0 || section == 1) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        view.backgroundColor = kWhiteColor;
        
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, 10, 70, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(16) textColor:kBlackColor];
        
        [view addSubview:label];
        
        UIButton * button = [UIButton buttonWithTitle:@"全部" titleColor:kTextColor2 backgroundColor:kClearColor titleFont:12 cornerRadius:0];
        [button addTarget:self action:@selector(morenews:) forControlEvents:(UIControlEventTouchUpInside)];
        button.frame = CGRectMake(SCREEN_WIDTH - 15 - 50, 10, 50, 30);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        button.tag = section;
        [view addSubview:button];
        
        if (section  == 0) {
            label.text = @"精选车源";
            
        }else
        {
            label.text = @"热门品牌";
            [button setTitle:@"更多" forState:(UIControlStateNormal)];
        }
        
        return view;
    }
//    return nil;
    
    UIView *view = [UIView new];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    backView.backgroundColor = kHexColor(@"#F5F5F5");
    [view addSubview:backView];
    
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kBlackColor];
    NSMutableArray<CarModel *> *carmodel = [CarModel mj_objectArrayWithKeyValuesArray:self.normalArray[section - 2]];
    nameLbl.text = carmodel[0].letter;
    [view addSubview:nameLbl];
    
    return view;
}



-(void)morenews:(UIButton *)sender
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"all"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

@end
