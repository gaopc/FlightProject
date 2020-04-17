//
//  TicketAppointmentDataResponse.h
//  FlightProject
//
//  Created by green kevin on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketAppointmentDataResponse : NSObject
@property (nonatomic,retain)NSString * _id; //主键
@property (nonatomic,retain)NSString * _message; 

@property (nonatomic,retain)NSMutableArray * _ticketAppointmentDescArray; //机票预约信息描述
//查询机票预约列表
+ (NSMutableArray *)queryReservationList:(NSDictionary *)dic;
//添加机票预约
+ (TicketAppointmentDataResponse *)addReservation:(NSDictionary *)dic;
//查询机票预约详情
+ (NSMutableArray *)queryReservationDetail:(NSDictionary *)dic;

@end


@interface TicketAppointmentInfo : NSObject
@property (nonatomic,retain)NSString * _id; //主键
@property (nonatomic,retain)NSString * _departure; //出发城市(汉字)
@property (nonatomic,retain)NSString * _arrival;//到大城市(汉字)
@property (nonatomic,retain)NSString * _starteDate;//开始日期 yyyy-MM-dd
@property (nonatomic,retain)NSString * _endDate;//开始日期 yyyy-MM-dd
@property (nonatomic,assign)int _cabinDiscount;// 舱位折扣,折扣选择只包含整数折扣(3-9和、全价共计7个)价格应低于全价,此处5表示5折以下
@property (nonatomic,retain)NSString * _createTime;//提交日期 yyyy-MM-dd
@end


@interface TicketAppointmentDesc : NSObject
@property (nonatomic,retain)NSString * _date;//日期
@property (nonatomic,retain)NSString * _describe;//// 描述
@end