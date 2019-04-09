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
@interface ClassifyInfoVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property (nonatomic,strong) TLTableView * tableview;
@end

@implementation ClassifyInfoVC
-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarHeight)];
//        if (self.models.count > 0) {
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.refreshDelegate = self;
//        }
        [_tableview registerClass:[ClassifyInfoCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getClassifyData];
   
    
    MinicarsLifeWeakSelf;
    [self.view addSubview:self.tableview];
    [self.tableview addRefreshAction:^{
        [weakSelf getClassifyData];
    }];
    [self.tableview beginRefreshing];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.models.count>0) {
        return self.models[0].cars.count;
    }
    return 0;
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
-(void)getClassifyData{
    //列表查询车型
    if (self.seriesCode) {
        TLNetworking * http2 = [[TLNetworking alloc]init];
        http2.showView = self.view;
        http2.code = @"630426";
        http2.parameters[@"status"] = @"1";
        http2.parameters[@"seriesCode"] = self.seriesCode;
        [http2 postWithSuccess:^(id responseObject) {
            self.models = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self TopView];
            [self.tableview reloadData];
            
            [self.tableview endRefreshHeader];
        } failure:^(NSError *error) {
            [self.tableview endRefreshHeader];
        }];
    }
}

-(void)TopView
{
    if (self.models.count > 0) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, (440.00/690.00) * (SCREEN_WIDTH - 30) + 30)];
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, (440.00/690.00) * (SCREEN_WIDTH - 30))];
        [image sd_setImageWithURL:[NSURL URLWithString:[self.models[0].advPic convertImageUrl]] placeholderImage:kImage(@"default_pic")];
        [view addSubview:image];
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, image.height - 70, image.width, 70)];
        v1.backgroundColor = RGB(84, 84, 84);
        v1.alpha = 0.4;
        [image addSubview:v1];
        
        UILabel * titlelab = [UILabel labelWithFrame:CGRectMake(15, image.height - 70 + 16.5, view.width - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
        int level = [self.models[0].level intValue];
        switch (level) {
            case 0:
                titlelab.text = @"SUV";
                break;
            case 1:
                titlelab.text = @"轿车";
                break;
            case 2:
                titlelab.text = @"MPV";
                break;
            case 3:
                titlelab.text = @"跑车";
                break;
            case 4:
                titlelab.text = @"皮卡";
                break;
            case 5:
                titlelab.text = @"房车";
                break;
                
            default:
                break;
        }
        [image addSubview:titlelab];
        
        UILabel * moneylab = [UILabel labelWithFrame:CGRectMake(15, image.height - 70 + 36.5, view.width / 2, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16.5) textColor:kWhiteColor];
        moneylab.text = [NSString stringWithFormat:@"%.2f-%.2f万",[self.models[0].lowest floatValue]/10000,[self.models[0].highest floatValue]/10000];
        [image addSubview:moneylab];

        UILabel * numberLabel = [UILabel labelWithFrame:CGRectMake( 4, 0, 30, 22) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
        numberLabel.text = self.models[0].picNumber;
        [numberLabel sizeToFit];
        numberLabel.frame = CGRectMake(view.width - 15 - numberLabel.width, image.height - 70 + 36.5, numberLabel.width, 22);
        [image addSubview:numberLabel];
        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(view.width - 15 - numberLabel.width - 13-5, image.height - 70 + 36.5 + 6, 13, 10.65)];
        img.image = kImage(@"图片");
        [image addSubview:img];
        self.tableview.tableHeaderView = view;
    }
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
