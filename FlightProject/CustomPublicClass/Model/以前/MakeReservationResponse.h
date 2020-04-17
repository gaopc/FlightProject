//
//  MakeReservationResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//                                                                                                                                                                      

#import <Foundation/Foundation.h>
#import "MailPsgInfo.h"
#import "ContactorInfo.h"
// 机票预定接口

@interface MakeReservationRequst : RootRequestModel

@property (nonatomic, retain) NSArray *passengers;          // 旅客信息
@property (nonatomic, retain) NSArray *segsInfo;               // 航程信息
@property (nonatomic, retain) NSString *outTimeLimit;       // 出票时限
@property (nonatomic, retain) NSString *flightType;            // 航程类型
@property (nonatomic, retain) NSString *isSpecialFlight;    //  特价
 @property (nonatomic, retain) MailPsgInfo* mailinfo;                       //  邮寄地址信息
@property (nonatomic, retain) ContactorInfo *contactorInfo;              // 联系人信息
@property (nonatomic, retain) NSString *isAcceptSevice;         // 是否接受低价推送服务
@property (nonatomic, retain) NSString *userID;                       // 会员id
@property (nonatomic, retain) NSString *getItinerary;                // 行程单获取方式

@end

@interface PNRInfo : NSObject

@property (nonatomic,retain) NSString * pnrID;
@property (nonatomic,retain) NSString * pnrNo;
@property (nonatomic,retain) NSString * pnrType;
@property (nonatomic,retain) NSString * orderind;

@end

@interface MakeReservationResponse : NSObject

@property (nonatomic,retain) NSString * shengPZ;
@property (nonatomic,retain) NSString * flowNo;
@property (nonatomic,retain) PNRInfo * pnrInfo;

+(MakeReservationResponse *)makeReservationResponseWithArray:(NSArray *)resultArray;

@end
