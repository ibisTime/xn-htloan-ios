//
//  XICarShowCollectionView.h
//  htloan
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "BaseCollectionView.h"
//m

#import "homeCarShowModel.h"
@interface XICarShowCollectionView : BaseCollectionView

@property (nonatomic, strong) NSString *code;

@property (nonatomic, strong) NSArray <homeCarShowModel*> *carShows;

@end
