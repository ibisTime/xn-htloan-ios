//
//  ApplyVC.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/6.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ApplyVC.h"
#import "TLUploadManager.h"
#import <UIButton+WebCache.h>
#import "ChooseCarVC.h"
#import "CarModel.h"
@interface ApplyVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSInteger tag;
    NSString *key1;
    NSString *key2;
}
@property (nonatomic , strong)CarModel *model;

@end

@implementation ApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initView];
    if (self.carcode) {
        [self getcarname:self.carcode];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.carcode) {
        [self getcarname:self.carcode];
    }
}

-(void)getcarname:(NSString *)code{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630427";
    http.parameters[@"code"] = code;
    //    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        self.model = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
        NSString * str = [NSString stringWithFormat:@"%@ %@ %@",self.model.brandName,self.model.seriesName,self.model.name];
        UITextField *textField = [self.view viewWithTag:202];
        textField.text = str;
    } failure:^(NSError *error) {
        
    }];
}

-(void)backBtnClick
{
    ChooseCarVC * vc = [ChooseCarVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)initView
{
    
    key1 = @"";
    key2 = @"";
    
    NSArray *nameArray = @[@"姓名",@"手机号",@"车型"];
    NSArray *placAry = @[@"请输入姓名",@"请输入手机号",@"请选择车型"];
    for (int i = 0; i < 3; i ++) {
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15 , i % 3 * 55 + 5, 70, 55) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#999999")];
        nameLbl.text = nameArray[i];
        [self.view addSubview:nameLbl];
        
        UITextField *textTF = [[UITextField alloc]initWithFrame:CGRectMake(90 , i % 3 * 55 + 5, SCREEN_WIDTH - 90 - 15, 55)];
        textTF.placeholder = placAry[i];
        [textTF setValue:Font(16) forKeyPath:@"_placeholderLabel.font"];
        textTF.font = Font(16);
        textTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:textTF];
        textTF.tag = 200 + i;
        if ( i == 2) {
            UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            backBtn.frame = textTF.frame;
            [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
            [self.view addSubview:backBtn];
            
            UIImageView *youImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 21, backBtn.y + 55/2 - 5.5, 6, 11)];
            youImage.image= HGImage(@"more");
            [self.view addSubview:youImage];
        }
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, nameLbl.yy, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self.view addSubview:lineView];
    }
    
    if (![self.title isEqualToString:@"分期申请"]) {
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15 , 170, 100, 55) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#999999")];
        nameLbl.text = @"行驶证上传";
        [self.view addSubview:nameLbl];
        
        UIButton *positiveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        positiveBtn.frame = CGRectMake(15, nameLbl.yy, (SCREEN_WIDTH - 45)/2, 105);
        [positiveBtn setBackgroundImage:kImage(@"正面") forState:(UIControlStateNormal)];
        [positiveBtn setImage:kImage(@"拍摄") forState:(UIControlStateNormal)];
        [positiveBtn addTarget:self action:@selector(photoClick:) forControlEvents:(UIControlEventTouchUpInside)];
        positiveBtn.tag = 100;
        [self.view addSubview:positiveBtn];
        
        UIButton *reverseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        reverseBtn.frame = CGRectMake(positiveBtn.xx + 15, nameLbl.yy, (SCREEN_WIDTH - 45)/2, 105);
        [reverseBtn setBackgroundImage:kImage(@"反面") forState:(UIControlStateNormal)];
        [reverseBtn setImage:kImage(@"拍摄") forState:(UIControlStateNormal)];
        [reverseBtn addTarget:self action:@selector(photoClick:) forControlEvents:(UIControlEventTouchUpInside)];
        reverseBtn.tag = 101;
        [self.view addSubview:reverseBtn];
        
        
        UILabel *positiveLbl = [UILabel labelWithFrame:CGRectMake(15, positiveBtn.yy + 9, (SCREEN_WIDTH - 45)/2, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
        positiveLbl.text = @"行驶证正面";
        [self.view addSubview:positiveLbl];
        
        UILabel *reverseLbl = [UILabel labelWithFrame:CGRectMake(positiveLbl.xx + 15, positiveBtn.yy + 9, (SCREEN_WIDTH - 45)/2, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
        reverseLbl.text = @"行驶证反面";
        [self.view addSubview:reverseLbl];
        
        UIButton *confirmBtn = [UIButton buttonWithTitle:@"确认提交" titleColor:kWhiteColor backgroundColor:MainColor titleFont:16 cornerRadius:4];
        confirmBtn.titleLabel.font = HGboldfont(16);
        [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        confirmBtn.frame = CGRectMake(15, reverseLbl.yy + 100, SCREEN_WIDTH - 30, 45);
        [self.view addSubview:confirmBtn];
    }else
    {
        UIButton *confirmBtn = [UIButton buttonWithTitle:@"确认提交" titleColor:kWhiteColor backgroundColor:MainColor titleFont:16 cornerRadius:4];
        confirmBtn.titleLabel.font = HGboldfont(16);
        [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        confirmBtn.frame = CGRectMake(15, 170 + 100, SCREEN_WIDTH - 30, 45);
        [self.view addSubview:confirmBtn];
    }
    
}

-(void)photoClick:(UIButton *)sender
{
    tag = sender.tag;
    [self seletPhoto];
}

-(void)seletPhoto
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        [action setValue:HGColor(138, 138, 138) forKey:@"titleTextColor"];
    }];
    UIAlertAction* fromPhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {
        
        //创建UIImagePickerController对象，并设置代理和可编辑
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.editing = YES;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        //选择相机时，设置UIImagePickerController对象相关属性
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        //跳转到UIImagePickerController控制器弹出相机
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        
        
    }];
    UIAlertAction* fromPhotoAction1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {
        
        
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.editing = YES;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //跳转到UIImagePickerController控制器弹出相册
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    [cancelAction setValue:GaryTextColor forKey:@"_titleTextColor"];
    [fromPhotoAction setValue:MainColor forKey:@"_titleTextColor"];
    [fromPhotoAction1 setValue:MainColor forKey:@"_titleTextColor"];
    [alertController addAction:cancelAction];
    [alertController addAction:fromPhotoAction];
    [alertController addAction:fromPhotoAction1];
    if ([alertController respondsToSelector:@selector(popoverPresentationController)]) {
        alertController.popoverPresentationController.sourceView = self.view;
        alertController.popoverPresentationController.sourceRect = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -- 获取图片代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    MinicarsLifeWeakSelf;
    //获取到的图片
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *imgData = UIImageJPEGRepresentation(image, 0.1);
    //进行上传
    TLUploadManager *manager = [TLUploadManager manager];
    manager.imgData = imgData;
    manager.image = image;
    [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
        
        [weakSelf changeHeadIconWithKey:key imgData:imgData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)changeHeadIconWithKey:(NSString *)key imgData:(NSData *)imgData {
    
    if (tag == 100) {
        key1 = key;
    }
    else
    {
        key2 = key;
    }
    UIButton *btn = [self.view viewWithTag:tag];
    [btn sd_setImageWithURL:[NSURL URLWithString:[key convertImageUrl]] forState:(UIControlStateNormal)];
    
}

-(void)confirmBtnClick
{
    UITextField *textField0 = [self.view viewWithTag:200];
    UITextField *textField1 = [self.view viewWithTag:201];
    UITextField *textField2 = [self.view viewWithTag:202];
 
    if ([textField0.text isEqualToString:@""]) {
        [TLProgressHUD showInfoWithStatus:@"请输入姓名"];
        return;
    }
    if ([textField1.text isEqualToString:@""]) {
        [TLProgressHUD showInfoWithStatus:@"请输入手机号"];
        return;
    }
    if ([textField2.text isEqualToString:@""]) {
        [TLProgressHUD showInfoWithStatus:@"请选择车型"];
        return;
    }
    
    if ([self.title isEqualToString:@"分期申请"]) {
        
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630430";
        http.parameters[@"name"] = textField0.text;
        http.parameters[@"userMobile"] = textField1.text;
        http.parameters[@"carCode"] = self.carcode;
        http.showView = self.view;
        [http postWithSuccess:^(id responseObject) {
            [TLProgressHUD showSuccessWithStatus:@"申请成功，请耐心等待审核"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });

        } failure:^(NSError *error) {
            
        }];
        
    }else
    {
        
        if ([key1 isEqualToString:@""]) {
            [TLProgressHUD showInfoWithStatus:@"请上传行驶证正面"];
            return;
        }
        if ([key2 isEqualToString:@""]) {
            [TLProgressHUD showInfoWithStatus:@"请上传行驶证反面"];
            return;
        }
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630433";
        http.parameters[@"name"] = textField0.text;
        http.parameters[@"userMobile"] = textField1.text;
        http.parameters[@"carCode"] = self.carcode;
        http.parameters[@"xszFront"] = key1;
        http.parameters[@"xszReverse"] = key2;
        
        http.showView = self.view;
        [http postWithSuccess:^(id responseObject) {
            [TLProgressHUD showSuccessWithStatus:@"申请成功，请耐心等待审核"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        } failure:^(NSError *error) {
            
        }];
    }
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
