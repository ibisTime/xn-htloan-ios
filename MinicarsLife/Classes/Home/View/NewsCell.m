//
//  NewsCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "NewsCell.h"
@interface NewsCell()
@property (nonatomic,strong) UIImageView * photo;
@property (nonatomic,strong) UILabel * titlelab;
@property (nonatomic,strong) UILabel * statuslab;
@property (nonatomic,strong) UILabel * newsfrom;
@property (nonatomic,strong) UILabel * looknum;
@end

@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.photo = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120 - 15, 10, 120, 85)];
//        self.photo.image = kImage(@"2");
        [self addSubview:self.photo];
        
        self.titlelab = [UILabel labelWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 120 - 15 - 15, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        self.titlelab.numberOfLines = 3;
        self.titlelab.text = @"雷克萨斯LX570正在优惠降价，点击立即询价";
        [self addSubview:self.titlelab];
        
        self.statuslab = [UILabel labelWithFrame:CGRectMake(15, 80, 30, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(10) textColor:kHexColor(@"#FF5E5E")];
        kViewBorderRadius(self.statuslab, 3, 1, kHexColor(@"#FF5E5E"));
        self.statuslab.text = @"原创";
        [self addSubview:self.statuslab];
        
        self.newsfrom = [UILabel labelWithFrame:CGRectMake(55, 80, 50, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
        self.newsfrom.text = @"微车生活";
        [self addSubview:self.newsfrom];
        
        self.looknum = [UILabel labelWithFrame:CGRectMake(self.photo.x - 60 - 70, 80, 70, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
        self.looknum.text = @"1.5万次浏览";
        [self addSubview:self.looknum];
        
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 104, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        [self addSubview:v1];
    }
    return self;
}

-(void)setModel:(NewsModel *)model{
    [self.photo sd_setImageWithURL:[NSURL URLWithString:[model.pic convertImageUrl]] placeholderImage:kImage(@"default_pic")];
    self.photo.contentMode =UIViewContentModeScaleAspectFill;
    //超出容器范围的切除掉
    self.photo.clipsToBounds = YES;
    self.titlelab.text = model.title;
    self.titlelab.frame = CGRectMake(15, 10, SCREEN_WIDTH - 120 - 15 - 15, 0);
    [self.titlelab sizeToFit];
    
    self.newsfrom.text = model.author;
    self.statuslab.text = model.tag;
    [self.statuslab sizeToFit];
    self.statuslab.frame = CGRectMake(15, 80, self.statuslab.width + 10, 15);
    
    [self.newsfrom sizeToFit];
    
    if (self.newsfrom.width >  100)
    {
        self.newsfrom.frame = CGRectMake(self.statuslab.xx + 10, 80, 100, 15);
    }
    else
    {
        self.newsfrom.frame = CGRectMake(self.statuslab.xx + 10, 80, self.newsfrom.width, 15);
    }
    
    self.looknum.frame = CGRectMake(self.newsfrom.xx + 10, 80, SCREEN_WIDTH - self.newsfrom.xx - 10 - 120 - 25, 15);
    
    float count = [model.readCount floatValue];
    NSString * str;
    if (count > 10000) {
        count = count / 10000.00;
        str = [NSString stringWithFormat:@"%.2f万",count];
        self.looknum.text = [NSString stringWithFormat:@"%@次浏览",str];
    }
    else
        self.looknum.text = [NSString stringWithFormat:@"%@次浏览",model.readCount];
    
}
@end
