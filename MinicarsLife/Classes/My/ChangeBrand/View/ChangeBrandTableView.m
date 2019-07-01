//
//  ChangeBrandTableView.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/6/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ChangeBrandTableView.h"
#import "BrandTableViewCell.h"
@implementation ChangeBrandTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.CarModels.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    
    BrandTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[BrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        
    }
    
    cell.namelab.text = self.CarModels[indexPath.row].brandName;
    
    [cell.logo sd_setImageWithURL:[NSURL URLWithString:[self.CarModels[indexPath.row].brandLogo convertImageUrl]]placeholderImage:kImage(@"default_pic")];
    
    //超出容器范围的切除掉
    //    cell.logo.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}

@end
