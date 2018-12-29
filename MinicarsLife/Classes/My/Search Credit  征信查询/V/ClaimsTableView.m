//
//  ClaimsTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ClaimsTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"

@interface ClaimsTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation ClaimsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];

    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isShe == YES) {
        return 6;
    }
    
    if (self.isBank == YES) {
        return 4;

    }else{
        
        return 2;

    }
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (indexPath.row == 0) {
//        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:TextFiel forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.name = @"匹配客户";
//        cell.xiaImage.image = HGImage(@"you");
//        cell.xiaImage.frame = CGRectMake(SCREEN_WIDTH - 25, 17.5, 7.5, 15);
//        if (self.isList == YES) {
//            UILabel * nameLabel = [UILabel labelWithFrame:CGRectMake(15, 50, 100, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:[UIColor blackColor]];
//             UILabel * carLabel = [UILabel labelWithFrame:CGRectMake(15, 90, 100, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:[UIColor blackColor]];
//             UILabel * numberLabel = [UILabel labelWithFrame:CGRectMake(15, 130, 100, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:[UIColor blackColor]];
//
//            UILabel * name = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH-150, 50, 130, 40) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(13) textColor:[UIColor blackColor]];
//            UILabel * car = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH-150, 90, 130, 40) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(13) textColor:[UIColor blackColor]];
//            UILabel * number = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH-150, 130, 130, 40) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(13) textColor:[UIColor blackColor]];
//            nameLabel.text = @"客户姓名";
//            carLabel.text = @"客户手机号";
//            numberLabel.text = @"车架号";
//            name.text = self.model.applyUserName;
//            car.text = self.model.mobile;
//            number.text = self.model.carFrameNo;
//            [cell addSubview:nameLabel];
//            [cell addSubview:carLabel];
//            [cell addSubview:numberLabel];
//            [cell addSubview:name];
//            [cell addSubview:car];
//            [cell addSubview:number];
//
//        }
//        return cell;
//    }
    if (self.isShe == YES) {
        if (indexPath.row == 0) {
                ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.name = @"请选择地区";
            UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDisTrict)];
            [cell addGestureRecognizer:t];
                cell.xiaImage.image = HGImage(@"you");
                cell.xiaImage.frame = CGRectMake(SCREEN_WIDTH - 25, 17.5, 7.5, 15);
            
            return cell;
        }else
        {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"地址",@"账号",@"密码",@"真实姓名",@"其他信息"];
            NSArray *nameTextArray = @[@"请输入地区",@"请输入账号",@"请输入密码",@"请输入姓名",@"请输入其他"];
            cell.nameTextField.tag = 100 + indexPath.row;
            cell.name = nameArray[indexPath.row-1];
            cell.nameText = nameTextArray[indexPath.row-1];
            
            return cell;

        }
    }
    if (self.isBank == YES) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"银行卡号",@"身份证号",@"手机号",@"姓名"];
        NSArray *nameTextArray = @[@"请输入银行卡号",@"请输入身份证号",@"请输入手机号",@"请输入姓名"];
        cell.nameTextField.tag = 100 + indexPath.row;
        cell.name = nameArray[indexPath.row];
        cell.nameText = nameTextArray[indexPath.row];
        
        return cell;
    }else{
        
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"身份证号",@"姓名"];
        NSArray *nameTextArray = @[@"请输入身份证号",@"请输入姓名"];
        cell.nameTextField.tag = 100 + indexPath.row;
        cell.name = nameArray[indexPath.row];
        cell.nameText = nameTextArray[indexPath.row];
        
        return cell;
    }
   
}

- (void)chooseDisTrict
{
    if (self.ChooseBlock) {
        self.ChooseBlock();
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
      return 50;
    }
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];

    UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    confirmButton.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 50);
    [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
    confirmButton.backgroundColor = MainColor;
    kViewRadius(confirmButton, 5);
    confirmButton.titleLabel.font = HGfont(18);
    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [headView addSubview:confirmButton];

    return headView;
}

-(void)confirmButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}


@end
