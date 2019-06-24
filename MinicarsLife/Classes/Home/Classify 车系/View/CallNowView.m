//
//  CallNowView.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CallNowView.h"

@implementation CallNowView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView * topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - (718.00/1334.00)*SCREEN_HEIGHT)];
        topview.alpha = 0.3;
        topview.backgroundColor = kBlackColor;
        [self addSubview:topview];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - ((718.00/1334.00)*SCREEN_HEIGHT), SCREEN_WIDTH, (718.00/1334.00)*SCREEN_HEIGHT)];
        view.backgroundColor = kWhiteColor;
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, 16, 65, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(15) textColor:kBlackColor];
        label.text = @"询价信息";
        [view addSubview:label];
        
        UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [deleteBtn setImage:kImage(@"弹窗-关闭") forState:(UIControlStateNormal)];
        deleteBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 0, 50, 50);
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:deleteBtn];
        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 54.5, 110, 82.5)];
        [view addSubview:img];
        
        self.image = img;
        
        UILabel * title = [UILabel labelWithFrame:CGRectMake(img.xx + 15, 54, SCREEN_WIDTH - 155, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        
        title.numberOfLines = 2;
        [view addSubview:title];
        self.titlelab = title;
        
        UILabel * describe = [UILabel labelWithFrame:CGRectMake(img.xx + 15, title.yy + 5, SCREEN_WIDTH - 120, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor3];
        
        [view addSubview:describe];
        self.describdlab = describe;
        
        UILabel * time = [UILabel labelWithFrame:CGRectMake(img.xx + 15, describe.yy + 5, 74, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor3];
        
        [view addSubview:time];
        self.timelab = time;
        
        UILabel * money = [UILabel labelWithFrame:CGRectMake(time.xx + 15, describe.yy + 5, SCREEN_WIDTH - 15 - 15 - time.xx, 22.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#028EFF")];
        
        [view addSubview:money];
        self.moneylab = money;
        
        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(15, img.yy + 10, SCREEN_WIDTH - 30, 50)];
        UILabel * content = [UILabel labelWithFrame:CGRectMake(7.5, 8.5, view1.width - 15, 33) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
        content.numberOfLines = 2;
        
        view1.backgroundColor = kHexColor(@"#F5F5F5");
        [view1 addSubview:content];
        [view addSubview:view1];
        self.view = view1;
        self.contentlab = content;
        
        
        UILabel * phonelab = [UILabel labelWithFrame:CGRectMake(22.5, view1.yy + 12.5, 45, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        phonelab.text = @"手机号";
        [view addSubview:phonelab];
        
        
        UITextField * phone = [[UITextField alloc]initWithFrame:CGRectMake(phonelab.xx + 33.5, view1.yy + 12.5, SCREEN_WIDTH - 30 - 100, 20)];
        phone.placeholder = @"请输入联系方式";
        phone.font = Font(14);
        [view addSubview:phone];
        self.phone = phone;
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, phone.yy + 12.5, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        [view addSubview:v1];
        
        
        
        UILabel * namelab = [UILabel labelWithFrame:CGRectMake(22.5, v1.yy + 12.5, 45, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        namelab.text = @"姓名";
        [view addSubview:namelab];
        
        
        
        UITextField * name = [[UITextField alloc]initWithFrame:CGRectMake(namelab.xx + 33.5, v1.yy + 12.5, SCREEN_WIDTH - 30 - 100, 20)];
        name.placeholder = @"请输入姓名";
        name.font = Font(14);
        [view addSubview:name];
        self.name = name;
        
        
        UIView * v2 = [[UIView alloc]initWithFrame:CGRectMake(15, namelab.yy + 12.5, SCREEN_WIDTH - 30, 1)];
        v2.backgroundColor = kLineColor;
        [view addSubview:v2];
        
        
        UIButton * askbtn = [UIButton buttonWithTitle:@"立即询价" titleColor:kWhiteColor backgroundColor:MainColor titleFont:16 cornerRadius:2];
        askbtn.frame = CGRectMake(15, v2.yy + 14, SCREEN_WIDTH - 30, 44);
        [askbtn addTarget:self action:@selector(clickask) forControlEvents:(UIControlEventTouchUpInside)];
        
        [view addSubview:askbtn];
        
        [self addSubview:view];
    }
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phone resignFirstResponder];
}
-(void)setCarmodel:(CarModel *)carmodel{
    
    
    
    
    _carmodel = carmodel;
    [self.image sd_setImageWithURL:[NSURL URLWithString:[self.carmodel.pic convertImageUrl]] placeholderImage:kImage(@"default_pic")];
    self.image.contentMode =UIViewContentModeScaleAspectFill;
    //超出容器范围的切除掉
    self.image.clipsToBounds = YES;
    self.titlelab.text = [NSString stringWithFormat:@"%@ ",self.carmodel.name];
    
    self.timelab.text = [self.carmodel.updateDatetime convertToDetailDateWithoutHour];
    self.moneylab.text = [NSString stringWithFormat:@"%.2f万",[self.carmodel.salePrice floatValue]/10000/1000];
    
    
    
    self.describdlab.text = [NSString stringWithFormat:@"%@ 外色:%@ 内色:%@ %@",[USERXX convertNull:carmodel.version] ,[USERXX convertNull: carmodel.outsideColor],[USERXX convertNull: carmodel.insideColor], [USERXX convertNull:carmodel.fromPlace]];
    
    
    self.contentlab.text = @"";
    NSMutableArray <DeployModel *> * model =[DeployModel mj_objectArrayWithKeyValuesArray:carmodel.caonfigList];
    for (int i = 0; i < model.count; i++) {
        self.contentlab.text = [NSString stringWithFormat:@"%@ %@",self.contentlab.text,model[i].config[@"name"]];
    }
}
-(void)clickask{
    
    if([USERXX user].isLogin == NO) {
        
        
        
        UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        [TLAlert alertWithTitle:@"提示" msg:@"您还为登录，是否前去登录" confirmMsg:@"确认" cancleMsg:@"取消" maker:rootViewController cancle:^(UIAlertAction *action) {
            
        } confirm:^(UIAlertAction *action) {
            LoginViewController *vc = [[LoginViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
            [rootViewController presentViewController:nav animated:YES completion:nil];
        }];
        return;
    }
    
    if (self.phone.text.length == 0) {
        [TLProgressHUD showInfoWithStatus:@"请输入手机号!"];
    }else if ([self isMobileNumber:self.phone.text] == NO){
        [TLProgressHUD showInfoWithStatus:@"手机号格式不正确!"];
    }else if (self.name.text.length == 0){
        [TLProgressHUD showInfoWithStatus:@"请输入姓名!"];
    }
    else {
        if (self.delegate) {
            [self.delegate askmoneyWithphone:self.phone.text name:self.name.text];
        }
    }
}

- (BOOL)isMobileNumber:(NSString *)mobileNum {
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178//    虚拟运营商:170
    NSString *phone = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phone];
    return [regextestmobile evaluateWithObject:mobileNum];
    
}
    


-(void)deleteBtnClick
{
    if (self.delegate) {
        [self.delegate deleteBtnClickDelegate];
    }
}

@end
