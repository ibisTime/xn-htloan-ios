//
//  XICarShowCell.h
//  htloan
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class homeCarShowModel;
@interface XICarShowCell : UICollectionViewCell

@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) homeCarShowModel *carShowModel;

@end
