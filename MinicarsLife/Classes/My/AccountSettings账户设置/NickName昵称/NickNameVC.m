//
//  NickNameVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "NickNameVC.h"
#import "AddressPickerView.h"
@interface NickNameVC ()<AddressPickerViewDelegate>
{
    NSString *_province;
    NSString *_city;
    NSString *_area;
    NSDictionary *dataDic;
}

@property (nonatomic , strong)UITextField *nickNameTextField;
@property (nonatomic , strong)UILabel *textLabel;
@property (nonatomic , strong)AddressPickerView *pickerView;
@property (nonatomic ,strong) UIButton          * addressBtn;
@end

@implementation NickNameVC

- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, 300)];
        _pickerView.delegate = self;
        // 关闭默认支持打开上次的结果
        //        _pickerView.isAutoOpenLast = NO;
    }
    return _pickerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    dataDic = [USERDEFAULTS objectForKey:@"USERXX"];
    _province = [USERXX convertNull:dataDic[@"province"]];
    _city = [USERXX convertNull:dataDic[@"city"]];
    _area = [USERXX convertNull:dataDic[@"area"]];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"确认" forState:(UIControlStateNormal)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self TheInterfaceDisplayView];
    [self.view addSubview:self.pickerView];
    
    
}

-(void)rightButtonClick
{
    
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"805084";
    http.showView = self.view;
//    nickname        昵称
//    photo    头像
//    idNo        证件号
//    realName    真实姓名
//    province        省
//    city        市
//    area        区
//    address        详细地址
    UITextField *textFid1 = [self.view viewWithTag:100];
    UITextField *textFid2 = [self.view viewWithTag:101];
    UITextField *textFid3 = [self.view viewWithTag:102];
    UITextField *textFid4 = [self.view viewWithTag:104];
    
    http.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    http.parameters[@"nickname"] = textFid1.text;
    http.parameters[@"realName"] = textFid2.text;
    http.parameters[@"idNo"] = textFid3.text;
    http.parameters[@"province"] = _province;
    http.parameters[@"city"] = _city;
    http.parameters[@"area"] = _area;
    http.parameters[@"address"] = textFid4.text;
    [http postWithSuccess:^(id responseObject) {
        WGLog(@"%@",responseObject);
        [TLAlert alertWithSucces:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)backBtnClick
{
    [self.view endEditing:YES];
    [self.pickerView show];
}



- (void)btnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.pickerView show];
    }else{
        [self.pickerView hide];
    }
}

#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClick{
    NSLog(@"点击了取消按钮");
    [self btnClick:_addressBtn];
}

- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area{
    UITextField *textField = [self.view viewWithTag:103];
    textField.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
    _province = province;
    _city = city;
    _area = area;
}

-(void)TheInterfaceDisplayView
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];

    
    NSArray *nameAry = @[@"昵称",@"真实姓名",@"身份证号",@"省市区",@"详细地址"];
    NSArray *placAry = @[@"请输入昵称",@"请输入真实姓名",@"请输入身份证号",@"请选择省市区",@"请输入详细地址"];
    NSArray *textAry = @[[USERXX convertNull:[USERDEFAULTS objectForKey:NICKNAME]],
                         [USERXX convertNull:dataDic[@"realName"]],
                         [USERXX convertNull:dataDic[@"idNo"]],
                         [NSString stringWithFormat:@"%@%@%@",_province,_city,_area],
                         [USERXX convertNull:dataDic[@"address"]]];
    for (int i = 0; i < 5; i ++) {
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0 + i % 5 * 60, 80, 60) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        nameLbl.text = nameAry[i];
        [self.view addSubview:nameLbl];
        
        
        
        _nickNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(nameLbl.xx + 10, 0 +  i % 5 * 60, SCREEN_WIDTH -nameLbl.xx- 25, 60)];
        //    [_nickNameTextField setValue:[UIColor blackColor]  forKeyPath:@"_placeholderLabel.textColor"];
        _nickNameTextField.placeholder = placAry[i];
        _nickNameTextField.text = textAry[i];
        
        _nickNameTextField.tag = 100 + i;
        
        _nickNameTextField.font = HGfont(14);
        [_nickNameTextField setValue:[UIFont systemFontOfSize:14.0] forKeyPath:@"_placeholderLabel.font"];
        [self.view addSubview:_nickNameTextField];
        
        if (i == 3) {
            UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            backBtn.frame = _nickNameTextField.frame;
            [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
            [self.view addSubview:backBtn];
        }
        
        
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 60 + i % 5 * 60, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kLineColor;
        [self.view addSubview:lineView];
    }
    
    
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
