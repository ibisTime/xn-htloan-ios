//
//  ClassifyInfoVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "ClassifyInfoVC.h"
#import "ClassifyInfoCell.h"
#import "CarInfoVC.h"
@interface ClassifyInfoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) TLTableView * tableview;
@end

@implementation ClassifyInfoVC
-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarHeight)];
        if (self.models.count > 0) {
        _tableview.delegate = self;
        _tableview.dataSource = self;
        }
        [_tableview registerClass:[ClassifyInfoCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    if (self.models.count > 0) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, (440.00/690.00) * (SCREEN_WIDTH - 30))];
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, (440.00/690.00) * (SCREEN_WIDTH - 30))];
        image.image = kImage(@"1");
        
        NSLog(@"%@",self.models);
        
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 160, view.width, 70)];
        v1.backgroundColor = RGB(84, 84, 84);
        v1.alpha = 0.4;
        UILabel * titlelab = [UILabel labelWithFrame:CGRectMake(15, 16.5, view.width - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
        //    titlelab.text = @"中大型车";
        titlelab.text = self.models[0].remark;
        [v1 addSubview:titlelab];
        
        
        UILabel * moneylab = [UILabel labelWithFrame:CGRectMake(15, 36.5, view.width / 2, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16.5) textColor:kWhiteColor];
        //    moneylab.text = @"54.9-210万";
        moneylab.text = [NSString stringWithFormat:@"%.2f-%.2f万",[self.models[0].lowest floatValue]/10000,[self.models[0].highest floatValue]/10000];
        [v1 addSubview:moneylab];
        
        UIView * v2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 55, 32.5, 55, 22)];
        v2.backgroundColor = kHexColor(@"#000000");
        v2.alpha = 0.5;
        kViewRadius(v2, 2);
        
        v2.backgroundColor = RGB(84, 84, 84);
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(9, 5.85, 13, 10.65)];
        img.image = kImage(@"图片");
        [v2 addSubview:img];
        
        UILabel * label = [UILabel labelWithFrame:CGRectMake(img.xx + 4, 0, 30, 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
//        label.text = @"549";
        label.text = self.models[0].picNumber;
        [v2 addSubview:label];
        
        [v1 addSubview:v2];
        
        [image addSubview:v1];
        
        
        [view addSubview:image];
        self.tableview.tableHeaderView = view;
    }
    [self.view addSubview:self.tableview];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models[0].cars.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    
    ClassifyInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[ClassifyInfoCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        
    }
    cell.carmodel = [CarModel mj_objectWithKeyValues: self.models[0].cars[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 185;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CarModel * model = [CarModel mj_objectWithKeyValues: self.models[0].cars[indexPath.row]];
    [self getcarinfo:model.code];
}
-(void)getcarinfo:(NSString *)code{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630427";
    http.parameters[@"code"] = code;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        CarInfoVC * vc = [CarInfoVC new];
        vc.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}
@end
