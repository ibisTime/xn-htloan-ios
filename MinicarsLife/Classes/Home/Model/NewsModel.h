//
//  NewsModel.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsModel : NSObject

/**
 "code": "CN201903151515439626742",
 "title": "无奈",
 "author": "大侠",
 "advPic": "图片",
 "picNumber": 3,
 "pic": "图片 必填",
 "readCount": 0,
 "context": "据台湾媒体报道，梅艳芳于2003年因子宫颈癌并发肺衰竭而逝世，她无论是在音乐、电影及戏剧都有卓越成就，遗产庞大，为防止母兄滥用遗产成立信托基金，不过梅妈覃美金仍在她死后被申请2次破产。\n梅妈上月由律师向法庭申请，从遗产信托拨款20多万元港币作为95岁摆寿宴使用，法官同意拨出25万元寿宴费。\n据香港媒体报道，梅妈寿宴摆了20几桌，至于最喜欢哪份礼物，则说每一样都喜欢，但不愿透露到底花多少钱过生日。\n梅艳芳于2003年去世后，留下破亿元遗产，她没有直接给予母亲，而是委托（汇）丰国际信托有限公司成立遗产管理，每月拨给梅妈妈生活费。但梅妈与长子梅启明不满足，多次争产，曾向法院申请把生活费提高至20万元港币，甚至想一次领走梅艳芳7100万元港币的遗产。\n据了解，梅母只要有机会，就会在媒体面前说自己生活费不够用，这次的95岁大宴也是年前向法院提出申请的，有网友就认为梅母太过贪婪，但也有一部分的人表示能明白梅母，女儿这么早离开，自己想要有一个幸福的晚年，是可以理解的",
 "tag": "0",
 "status": "1",
 "updater": "U201806131315524345485",
 "updateDatetime": "Mar 15, 2019 3:15:43 PM",
 "remark": "remark"
 */
@property (nonatomic,copy) NSString *  code;
@property (nonatomic,copy) NSString *  title;
@property (nonatomic,copy) NSString *  author;
@property (nonatomic,copy) NSString * advPic ;
@property (nonatomic,copy) NSString * picNumber ;
@property (nonatomic,copy) NSString * pic ;
@property (nonatomic,copy) NSString * readCount ;
@property (nonatomic,copy) NSString * context ;
@property (nonatomic,copy) NSString * tag ;
@property (nonatomic,copy) NSString * status ;
@property (nonatomic,copy) NSString * updater ;
@property (nonatomic,copy) NSString * updateDatetime ;
@property (nonatomic,copy) NSString * remark ;
@end

NS_ASSUME_NONNULL_END
