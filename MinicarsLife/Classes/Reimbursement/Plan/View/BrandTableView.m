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
    NSArray *array = self.normalArray[section];
//    NSArray <CarModel *>*model = [CarModel mj_objectArrayWithKeyValuesArray:self.NormalCarBrands[section]];
    return array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    
    BrandTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[BrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        
    }
//    cell.namelab.text = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

//-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    self.indexArray = [NSMutableArray arrayWithObjects:@"#",nil];
//    
//    for (int i = 0; i < self.normalArray.count; i ++) {
////        char ch =
//        [self.indexArray addObject:[NSString stringWithFormat:@"%c",[self.normalArray[i][0][@"letter"] charValue]]];
//    }
//    return self.normalArray;
//}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.normalArray[section][0][@"letter"];
}
@end