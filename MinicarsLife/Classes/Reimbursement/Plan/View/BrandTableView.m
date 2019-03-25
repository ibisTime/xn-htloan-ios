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
        
        //索引数组
        
        
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
    [cell.logo sd_setImageWithURL:[NSURL URLWithString:[carmodel[indexPath.row].logo convertImageUrl]]placeholderImage:kImage(@"default_pic")];
    cell.logo.contentMode =UIViewContentModeScaleAspectFill;
    //超出容器范围的切除掉
    cell.logo.clipsToBounds = YES;
//    [cell.logo sizeToFit];
//    cell.logo.frame = CGRectMake(65 - cell.logo.width, 15, cell.logo.width, 25);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    self.indexArray = [NSMutableArray arrayWithObjects:@"#",nil];
//    self.indexArray = [NSMutableArray array];
    

    return self.indexArray;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSMutableArray<CarModel *> *carmodel = [CarModel mj_objectArrayWithKeyValuesArray:self.normalArray[section] ];
    return carmodel[0].letter;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}
@end
