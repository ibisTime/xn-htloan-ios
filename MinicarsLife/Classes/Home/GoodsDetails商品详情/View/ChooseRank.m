
#import "ChooseRank.h"
#define screen_Width [UIScreen mainScreen].bounds.size.width
#define screen_Height [UIScreen mainScreen].bounds.size.height
@implementation ChooseRank


-(instancetype)initWithTitle:(NSString *)title titleArr:(NSArray *)titleArr andFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {

        self.frame = frame;
        self.title = title;

        self.rankArray = [NSArray arrayWithArray:titleArr];

        [self rankView];
    }
    return self;
}


-(void)rankView{

    self.packView = [[UIView alloc] initWithFrame:self.frame];
    self.packView.y = 0;
    

//    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 0.5)];
//    line.backgroundColor = LineBackColor;
//    [self.packView addSubview:line];

    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, screen_Width, 25)];
    titleLB.text = self.title;
    titleLB.font = HGfont(15);
    [self.packView addSubview:titleLB];

    self.btnView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(titleLB.frame), screen_Width, 40)];
    [self.packView addSubview:self.btnView];

    int count = 0;
    float btnWidth = 0;
    float viewHeight = 0;
    for (int i = 0; i < self.rankArray.count; i++) {

        NSString *btnName = self.rankArray[i];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setBackgroundColor:BackColor];
        [btn setTitleColor:GaryTextColor forState:UIControlStateNormal];
        
        kViewBorderRadius(btn, 5, 0.5, GaryTextColor);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundColor:kWhiteColor forState:UIControlStateNormal];
        [btn setBackgroundColor:MainColor forState:UIControlStateSelected];

        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:btnName forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;

        NSDictionary *dict = [NSDictionary dictionaryWithObject:HGfont(13) forKey:NSFontAttributeName];
        CGSize btnSize = [btnName sizeWithAttributes:dict];

        btn.width = btnSize.width + 15;
        btn.height = btnSize.height + 12;

        if (i==0)
        {

            btn.x = 20;
            btnWidth += CGRectGetMaxX(btn.frame);
            
        }
        else{
            btnWidth += CGRectGetMaxX(btn.frame)+20;
            if (btnWidth > screen_Width) {
                count++;
                btn.x = 20;
                btnWidth = CGRectGetMaxX(btn.frame);
            }
            else{

                btn.x += btnWidth - btn.width;
            }
        }
        btn.y += count * (btn.height+10)+10;

        viewHeight = CGRectGetMaxY(btn.frame)+10;

        [self.btnView addSubview:btn];

        btn.tag = 10000+i;


        //        if ([btnName isEqualToString:self.selectStr])
        //        {
        //            self.selectBtn = btn;
        //            self.selectBtn.selected = YES;
        //            self.selectBtn.backgroundColor = [UIColor greenColor];
        //        }

        if (i == 0) {
            [self btnClick:btn];
        }
    }
    self.btnView.height = viewHeight;
    self.packView.height = self.btnView.height+CGRectGetMaxY(titleLB.frame);

    self.height = self.packView.height;

    [self addSubview:self.packView];
   
}


-(void)btnClick:(UIButton *)btn{


    if (![self.selectBtn isEqual:btn]) {

        self.selectBtn.backgroundColor = kWhiteColor;
        self.selectBtn.selected = NO;
        kViewBorderRadius(btn, 5, 0.5, GaryTextColor);

        //        NSLog(@"%@-----%@",btn.titleLabel.text,[self.rankArray[btn.tag-10000] sequence]);
    }
    else{
        btn.backgroundColor = MainColor;
        kViewBorderRadius(btn, 5, 0.5, MainColor);
    }
    btn.backgroundColor = MainColor;
    btn.selected = YES;

    self.selectBtn = btn;

    if ([self.delegate respondsToSelector:@selector(selectBtnTitle:andBtn:)]) {

        [self.delegate selectBtnTitle:btn.titleLabel.text andBtn:self.selectBtn];
    }
}


@end







