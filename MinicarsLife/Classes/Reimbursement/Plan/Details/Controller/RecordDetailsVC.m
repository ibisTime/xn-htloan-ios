//
//  RecordDetailsVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "RecordDetailsVC.h"
#import "RecordDetailsCell.h"
#import "RecordDetailsHeadCell.h"
#import "RecordPlanCell.h"
#define RecordDetails @"RecordDetailsCell"
#define RecordDetailsHead @"RecordDetailsHeadCell"
#define RecordPlan @"RecordPlanCell"

#import "PrepaymentVC.h"

#import "RepaymentPlanVC.h"

#import "TLUploadManager.h"

@interface RecordDetailsVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIButton *confirmButton;
}
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong) UIImageView *footView;

@end

@implementation RecordDetailsVC

-(UITableView *)tableView{
    if (_tableView == nil) {
        CGRect tableView_frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70);
        _tableView = [[UITableView alloc] initWithFrame:tableView_frame style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=BackColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
       
        [_tableView registerClass:[RecordDetailsCell class] forCellReuseIdentifier:RecordDetails];
        [_tableView registerClass:[RecordDetailsHeadCell class] forCellReuseIdentifier:RecordDetailsHead];
        [_tableView registerClass:[RecordPlanCell class] forCellReuseIdentifier:RecordPlan];

        
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"车贷详情";

//    confirmButton = [UIButton buttonWithTitle:@"打款截图" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18 cornerRadius:5];
//    confirmButton.frame = CGRectMake(20, SCREEN_HEIGHT - 60 - kNavigationBarHeight, SCREEN_WIDTH - 40, 50);
//    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:confirmButton];
    [self loadData];
    if (_model.restAmount/1000 == 0) {
        confirmButton.hidden = YES;
        _tableView.frame =  CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);

    }
}

//630047   tq_service

-(void)confirmButtonClick
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
    
//    PrepaymentVC *vc = [[PrepaymentVC alloc]init];
//    vc.model = self.model;
//    [self.navigationController pushViewController:vc animated:YES];
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
    [manager getTokenShowViewimage:weakSelf.view succes:^(NSString *key) {
        
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = NO;
        http.code = @"630544";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"prepayPhoto"] = [USERDEFAULTS objectForKey:USER_ID];
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"上传成功"];
        } failure:^(NSError *error) {
            
        }];
//        [weakSelf changeHeadIconWithKey:key imgData:imgData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_model.prepayPhoto) {
        [self.footView sd_setImageWithURL:[NSURL URLWithString:[_model.prepayPhoto convertImageUrl]]];
    }
    if (indexPath.section == 0)
    {
        RecordDetailsHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordDetailsHead forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _model;
        return cell;
    }
    if (indexPath.section == 1)
    {
        RecordDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordDetails forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _model;
        return cell;
    }
    RecordPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordPlan forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
   

}

-(void)loadData
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = NO;
    http.code = @"630147";
    [http postWithSuccess:^(id responseObject) {
        NSArray *array =  responseObject[@"data"];

        for (int i = 0 ; i < array.count; i ++) {
            if ([_model.curNodeCode isEqualToString:array[i][@"code"]]) {
                UILabel *label = [self.view viewWithTag:1005];
                label.text = [NSString stringWithFormat:@"%@",array[i][@"name"]];
            }
        }
        [self.tableView reloadData];

    } failure:^(NSError *error) {

    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        RepaymentPlanVC *vc = [[RepaymentPlanVC alloc]init];
        vc.model = _model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 125;
    }
    if (indexPath.section == 1)
    {
        return 35 * 6 + 8;
    }
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section == 0)
    {
        return 0.01;
    }
    return 10;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
