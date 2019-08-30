//
//  MessageModel.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/13.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject



//@property (nonatomic , copy)NSString *ID;
//@property (nonatomic , copy)NSString *updateDatetime;
//@property (nonatomic , copy)NSString *smsTitle;
//@property (nonatomic , copy)NSString *channelType;
//@property (nonatomic , copy)NSString *smsContent;
//@property (nonatomic , copy)NSString *toKind;
//@property (nonatomic , copy)NSString *fromSystemCode;
//@property (nonatomic , copy)NSString *pushedDatetime;
//@property (nonatomic , copy)NSString *createDatetime;
//@property (nonatomic , copy)NSString *remark;
//@property (nonatomic , copy)NSString *updater;
//@property (nonatomic , copy)NSString *isRead;
//@property (nonatomic , copy)NSString *topushDatetime;
//@property (nonatomic , copy)NSString *smsType;
//@property (nonatomic , copy)NSString *status;
//@property (nonatomic , copy)NSString *pushType;

//"code": "XX201903141638191903004",
//"type": "2",
//"title": "805300",
//"content": "用postman调用接口加",
//"status": "1",
//"createDatetime": "Mar 14, 2019 4:38:19 PM",
//"updater": "tao"
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * refCode;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * createDatetime;
@property (nonatomic,copy) NSString * updater;
@property (nonatomic,copy) NSString * isAlreadyRead;

@end
