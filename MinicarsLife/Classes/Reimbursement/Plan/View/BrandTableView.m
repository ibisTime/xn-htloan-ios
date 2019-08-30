//
//  BrandTableView.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/18.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BrandTableView.h"
//#import "BrandCell.h"
#import "BrandTableViewCell.h"
@implementation BrandTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[BrandTableViewCell class] forCellReuseIdentifier:@"cell"];
        self.estimatedSectionHeaderHeight = 30;
        //索引数组

//        ／／ 设置默认时，索引的背景颜色
//        for (char ch='A'; ch<='Z'; ch++) {
//            [self.indexArray addObject:[NSString stringWithFormat:@"%c",ch]];
//        }
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.normalArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
    NSArray<CarModel *> *array =[CarModel mj_objectArrayWithKeyValuesArray:self.normalArray[section]];
//    NSArray <CarModel *>*model = [CarModel mj_objectArrayWithKeyValuesArray:self.NormalCarBrands[section]];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    
    BrandTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[BrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        
    }
    NSMutableArray<CarModel *> *carmodel = [CarModel mj_objectArrayWithKeyValuesArray:self.normalArray[indexPath.section]];
    cell.namelab.text = carmodel[indexPath.row].name;
    
    [cell.logo sd_setImageWithURL:[NSURL URLWithString:[carmodel[indexPath.row].logo convertImageUrl]]];
    
    //超出容器范围的切除掉
//    cell.logo.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return self.indexArray;
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    for (UIView *view in [tableView subviews]) {
//        if ([[[view class] description] isEqualToString:@"UITableViewIndex"]) {
//            UILabel *desLbl = (UILabel *)view;
//            desLbl.height = 20;
//            desLbl.font = Font(14);
//        }
//    }
//    return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] count];
//
//}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    for (UIView *view in [tableView subviews]) {
        if ([[[view class] description] isEqualToString:@"UITableViewIndex"]) {
            UILabel *desLbl = (UILabel *)view;
            desLbl.height = 35;
            desLbl.font = Font(16);
        }
    }
    NSMutableArray<CarModel *> *carmodel = [CarModel mj_objectArrayWithKeyValuesArray:self.normalArray[section] ];
    return carmodel[0].letter;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}
@end
