//
//  AddReservationResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
// 2.41	预约接口
#import <Foundation/Foundation.h>

@interface ReservationInfo : NSObject


@property(nonatomic, retain) NSString *dptCity;// 出发城市三字代码
@property(nonatomic, retain) NSString *arrCity;// 到达城市的机场三字代码
@property(nonatomic, retain) NSString *startDate;// 开始日期yyyy-MM-dd
@property(nonatomic, retain) NSString *endDate;// 结束日期yyyy-MM-dd
@property(nonatomic, retain) NSString *flyPeriod;// 起飞时段
@property(nonatomic, retain) NSString *week;// 星期选择
@property(nonatomic, retain) NSString *accept;// 接受方式 “0”为邮件“1”为手机短信 目前只支持短息，传1就行
@property(nonatomic, retain) NSString *SMSTime;// 短信接收 “0”白天（9：00-21:00） “1”全天
@property(nonatomic, retain) NSString *cabinDiscount;// 舱位折扣

@end

@interface ReservationRequstInfo : ReservationInfo
@property(nonatomic, retain) NSString *userID;
@end

@interface AddReservationResponse : NSObject
+(NSString *)addReservationResponseWithArray:(NSArray *)resultArray;
@end
