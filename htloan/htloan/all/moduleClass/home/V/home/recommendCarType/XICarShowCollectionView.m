//
//  XICarShowCollectionView.m
//  htloan
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "XICarShowCollectionView.h"

//cell
#import "XICarShowCell.h"
@interface XICarShowCollectionView()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation XICarShowCollectionView
static NSString * const reuseIdentifier = @"cell" ;
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
       
    //注册cell
        [self registerClass:[XICarShowCell class] forCellWithReuseIdentifier:reuseIdentifier];
        
       
        
    }
    return self;
}



#pragma mark - 数据源
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
   XICarShowCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (cell == nil){
        cell = [[XICarShowCell alloc] init];
    }
//    cell.backgroundColor = [UIColor blueColor];
    return cell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
