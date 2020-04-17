//
//  TicketAppointmentResponse.h
//  FlightProject
//
//  Created by 崔立东 on 12-9-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  机票预约数据传输模型
//

#import <Foundation/Foundation.h>



@interface TicketAppointment : NSObject

@property (nonatomic,retain) NSString * terminalId; //终端编号
@property (nonatomic,retain) NSString * userId;//用户ID
@property (nonatomic,retain) NSString * cabinDiscount;//仓位折扣
@property (nonatomic,retain) NSString * departure;//出发城市三字码
@property (nonatomic,retain) NSString * arrival;//达到城市三字码
@property (nonatomic,retain) NSDate * starteDate;//开始日期
@property (nonatomic,retain) NSDate * endDate;//结束日期
@property (nonatomic,retain) NSString * flyPeriod;//起飞时段
@property (nonatomic,retain) NSString * endPeriod;//结束时段
@property (nonatomic,retain) NSString * smsTime;//短信接收时段
@property (nonatomic,retain) NSString * endSmsDate;//短信接收结束时段


@end



@interface TicketAppointmentResponse : NSObject

@end
