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
    if (self.isCode == YES) {
        return 1;
    }
    if (self.isShe == YES) {
        return 5;
    }
    if (self.isDian == YES) {
        return 3;
    }
    if (self.isCoin == YES) {
        return 5;
    }
    if (self.isTD == YES) {
        return 3;
    }
    if (self.isPlace == YES) {
        if (self.isPhoneShow == YES) {
            return 3;
        }else{
            return 1;
        }
     
    }
    if (self.isMobleInformation == YES) {
        return 19;
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
    
    if (self.isDian == YES) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
        if (indexPath.row == 0) {
            cell.name = @"身份证号";
            cell.nameText = @"请输入身份证号";
            NSString *no = [USERDEFAULTS objectForKey:IDNO];
            
            if (no.length>0) {
                cell.nameTextField.text = no;
            }
        }
        if (indexPath.row == 1) {
            cell.name = @"姓名";
            cell.nameText = @"请输入姓名";
        }
        if (indexPath.row == 2) {
            cell.name = @"手机号";
            cell.nameText = @"请输入手机号";
        }
       
        cell.nameTextField.tag = 100 + indexPath.row;

        
        return cell;
        
    }
    
    if (self.isCoin == YES) {
        if (indexPath.row == 0) {
            ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"请选择地区";
            cell.details = self.chooseText;
            
            UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDisTrict)];
            [cell addGestureRecognizer:t];
            cell.xiaImage.image = HGImage(@"you");
            cell.xiaImage.frame = CGRectMake(SCREEN_WIDTH - 25, 17.5, 7.5, 15);
            
            return cell;
        }else
        {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"账号",@"密码",@"真实姓名",@"其他信息"];
            NSArray *nameTextArray = @[@"请输入账号",@"请输入密码",@"请输入姓名",@"请输入其他"];
            cell.nameTextField.tag = 100 + indexPath.row;
            cell.name = nameArray[indexPath.row-1];
            cell.nameText = nameTextArray[indexPath.row-1];
            
            return cell;
            
        }
    }
   
    
    
    if (self.isShe == YES) {
        if (indexPath.row == 0) {
                ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.name = @"请选择地区";
            cell.details = self.chooseText;
            
            UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDisTrict)];
            [cell addGestureRecognizer:t];
                cell.xiaImage.image = HGImage(@"you");
                cell.xiaImage.frame = CGRectMake(SCREEN_WIDTH - 25, 17.5, 7.5, 15);
            
            return cell;
        }else
        {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"账号",@"密码",@"真实姓名",@"其他信息"];
            NSArray *nameTextArray = @[@"请输入账号",@"请输入密码",@"请输入姓名",@"请输入其他"];
            cell.nameTextField.tag = 100 + indexPath.row;
            cell.name = nameArray[indexPath.row-1];
            cell.nameText = nameTextArray[indexPath.row-1];
            
            return cell;

        }
    }
    if (self.isTD == YES) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"账号",@"密码",@"登录类型"];
        NSArray *nameTextArray = @[@"请输入账号",@"请输入密码",@"登录类型(选填)"];
        cell.nameTextField.tag = 100 + indexPath.row;
        cell.name = nameArray[indexPath.row];
        cell.nameText = nameTextArray[indexPath.row];
        
        return cell;
    }
    if (self.isCode == YES) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.nameTextField.tag = 100 + indexPath.row;
        cell.name = @"验证码";
        cell.nameText = @"请输入验证码";
        
        return cell;
    }
    if (self.isPlace == YES) {
        if (self.isPhoneShow == YES) {
        if (indexPath.row == 0) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.nameTextField.tag = 100 + indexPath.row;
            cell.name = @"手机号";
            cell.nameText = @"请输入手机号";
            
            return cell;
        }else if (indexPath.row == 1)
        {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.nameTextField.tag = 100 + indexPath.row;
            cell.name = @"运营商";
            cell.nameText = self.city;
            [cell.nameTextField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];

            cell.nameTextField.enabled = NO;

            return cell;
        }else{
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.nameTextField.tag = 100 + indexPath.row;
            cell.name = @"归属地";
            cell.nameText = self.type;
            [cell.nameTextField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];

            cell.nameTextField.enabled = NO;
            return cell;
        }
      
        }else{
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.nameTextField.tag = 100 + indexPath.row;
            cell.name = @"手机号";
            cell.nameText = @"请输入手机号";
            
            return cell;
            }
    }
    if (self.isMobleInformation == YES) {
//        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
//        if (cell == nil) {
//            cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextField];
//        }
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
             // 通过不同标识创建cell实例
             TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
             // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
             if (!cell) {
                     cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                 }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"身份证号",@"姓名",@"手机号",@"手机服务密码",@"第一联系人",@"身份证号",@"手机号",@"姓名",@"与第一联系人关系",@"第二联系人",@"身份证号",@"手机号",@"姓名",@"与第二联系人关系",@"第三联系人",@"身份证号",@"手机号",@"姓名",@"与第三联系人关系"];
        NSArray *nameTextArray = @[@"必填",@"必填",@"必填",@"必填",@"",@"选填",@"选填",@"选填",@"选填",@"",@"选填",@"选填",@"选填",@"选填",@"",@"选填",@"选填",@"选填",@"选填"];
        if (indexPath.row == 4 ||  indexPath.row == 9  ||  indexPath.row == 14  ) {
            cell.backgroundColor = kLineColor;
        }else{
            cell.backgroundColor = kClearColor;

        }
        if (indexPath.row == 3) {
            cell.nameTextField.secureTextEntry = YES;
        }
        if (indexPath.row == 0) {
            NSString *no = [USERDEFAULTS objectForKey:IDNO];

            if (no.length>0) {
                cell.nameTextField.text = no;
            }
        }
        cell.nameTextField.tag = 100 + indexPath.row;
        cell.name = nameArray[indexPath.row];
        cell.nameText = nameTextArray[indexPath.row];
        
        return cell;
    }
    
    if (self.isBank == YES) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"银行卡号",@"身份证号",@"手机号",@"姓名"];
        NSString *no = [USERDEFAULTS objectForKey:IDNO];
       
        NSArray *nameTextArray = @[@"请输入银行卡号",@"请输入身份证号",@"请输入手机号",@"请输入姓名"];
        cell.nameTextField.tag = 100 + indexPath.row;
        cell.name = nameArray[indexPath.row];
        cell.nameText = nameTextArray[indexPath.row];
        if (indexPath.row == 1) {
            if (no.length>0) {
                cell.nameTextField.text = no;
            }
        }
        
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.isMobleInformation == YES) {
        if (section == 4 || section == 8 || section == 12 ) {
            UIView *headView = [[UIView alloc]init];
            headView.backgroundColor = [UIColor whiteColor];
            
            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kLineColor font:HGfont(12) textColor:GaryTextColor];
            
            nameLbl.text = @"第一联系人";
            [headView addSubview:nameLbl];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 29, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = LineBackColor;
            [headView addSubview:lineView];
            
            return headView;
            
        }
        else
    {
        return [UIView new];
        }
    }else{
        return [UIView new];

        }
}

-(void)confirmButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.ScrolleWBlock) {
        self.ScrolleWBlock();
    }
    
}

@end
