//
//  ModifyPhoneVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ModifyPhoneVC.h"
#import "CustomTextFieldView.h"
#import "SendCodeView.h"
@interface ModifyPhoneVC ()
{
    CustomTextFieldView *tfView;
    SendCodeView *codeView;
    CustomTextFieldView *tfView1;
    SendCodeView *codeView1;
}
@end

@implementation ModifyPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackColor;
    [self TheInterfaceDisplayView];
    self.title = @"修改手机号";
}

-(void)TheInterfaceDisplayView
{
    tfView1 = [[CustomTextFieldView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 60)];
    tfView1.nameLabel.text = @"手机号";
    tfView1.nameTextField.placeholder = @"请输入手机号";
    tfView1.nameTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:tfView1];
    
    codeView1 = [[SendCodeView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 60)];
    codeView1.nameLabel.text = @"验证码";
    codeView1.nameTextField.placeholder = @"请输入验证码";
    codeView1.nameTextField.keyboardType = UIKeyboardTypePhonePad;
    [codeView1.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:codeView1];
    
    tfView = [[CustomTextFieldView alloc]initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, 60)];
    tfView.nameLabel.text = @"新手机号";
    tfView.nameTextField.placeholder = @"请输入手机号";
    tfView.nameTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:tfView];

    codeView = [[SendCodeView alloc]initWithFrame:CGRectMake(0, 190, SCREEN_WIDTH, 60)];
    codeView.nameLabel.text = @"验证码";
    codeView.nameTextField.placeholder = @"请输入验证码";
    codeView.nameTextField.keyboardType = UIKeyboardTypePhonePad;
    [codeView.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:codeView];
    
    
    

    UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    confirmButton.frame = CGRectMake(20, 290, SCREEN_WIDTH - 40, 50);
    [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
    confirmButton.backgroundColor = MainColor;
    kViewRadius(confirmButton, 5);
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    confirmButton.titleLabel.font = HGfont(18);
    [self.view addSubview:confirmButton];
}

-(void)sendButtonClick:(UIButton *)sender
{
    //发送验证码
    TLNetworking *http = [TLNetworking new];
    http.code = VERIFICATION_CODE_CODE;
    http.showView = self.view;
    http.parameters[@"kind"] = @"C";
    http.parameters[@"mobile"] = tfView.nameTextField.text;
    http.parameters[@"bizType"] = ModifyPhoneNumberURL;

    [http postWithSuccess:^(id responseObject) {
        WGLog(@"%@",responseObject);
        [self SendVerificationCode:sender];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

-(void)SendVerificationCode:(UIButton *)sender
{
    NSLog(@"123");

    __block NSInteger time = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{

                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
                sender.backgroundColor = MainColor;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{

                [sender setTitle:[NSString stringWithFormat:@"%.2d后重发", seconds] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
                sender.backgroundColor = [UIColor grayColor];
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

-(void)confirmButtonClick
{
    if ([tfView.nameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入手机号"];
        return;
    }
    if ([codeView.nameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入验证码"];
        return;
    }
    if ([tfView1.nameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入手机号"];
        return;
    }
    if ([codeView1.nameTextField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入验证码"];
        return;
    }
    //发送验证码
    TLNetworking *http = [TLNetworking new];
    http.code = ModifyPhoneNumberURL;
    http.showView = self.view;
    http.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    http.parameters[@"newMobile"] = tfView.nameTextField.text;
    http.parameters[@"newCaptcha"] = codeView.nameTextField.text;
    http.parameters[@"oldMobile"] = tfView1.nameTextField.text;
    http.parameters[@"oldCaptcha"] = codeView1.nameTextField.text;
    [http postWithSuccess:^(id responseObject) {
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
