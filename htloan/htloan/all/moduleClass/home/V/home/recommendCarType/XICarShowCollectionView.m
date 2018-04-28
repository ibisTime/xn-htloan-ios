//
//  XICarShowCollectionView.m
//  htloan
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "XICarShowCollectionView.h"

//C
#import "detailsOfCarVC.h"
//Category 响应者链
#import "UIView+Responder.h"

//cell
#import "XICarShowCell.h"
@interface XICarShowCollectionView()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
//v
@property (nonatomic, strong) XICarShowCell *cell;
//vc
//@property (nonatomic, strong) detailsOfCarVC *detOfCarVC;

@end

@implementation XICarShowCollectionView
static NSString * const reuseIdentifier = @"cell" ;
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource =self;
        self.delegate =self;
    //注册cell
        [self registerClass:[XICarShowCell class] forCellWithReuseIdentifier:reuseIdentifier];
        
       
        
    }
    return self;
}



#pragma mark - 数据源
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//    return self.carShows.count;

    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return self.carShows.count;
//    NSLog(@"§§§§§%lu",self.carShows.count);
//    return 1;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
   self.cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
  
    
    homeCarShowModel *car = self.carShows[indexPath.item];
   
    
    self.cell.carShowModel = car;
    
   
    return self.cell;
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    

    
//    if (self.carShows[indexPath.item]) {
    

//        NSLog(@"汽车详情");
    
   detailsOfCarVC* detOfCarVC = [[detailsOfCarVC alloc ] init ];
    
    detOfCarVC.code = self.cell.carShowModel.code;
    [self.viewController.navigationController pushViewController:detOfCarVC animated:YES];
    
    
//    }

}







@end
