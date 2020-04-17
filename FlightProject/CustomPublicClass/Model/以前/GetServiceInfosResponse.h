//
//  GetServiceInfosResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//2.32	最低价推送信息查询接口
#import <Foundation/Foundation.h>
@interface TicketPrice:NSObject
@property (nonatomic,retain)NSString * ticketDate;
@property (nonatomic,retain)NSString * ticketPrice;
@end

@interface ServiceInfo : NSObject
@property (nonatomic,retain)NSString * ticketNo;
@property (nonatomic,retain)NSString * price;
@property (nonatomic,retain)NSArray * ticketPriceArray;
@end

@interface GetServiceInfosResponse : NSObject

+(ServiceInfo *)getServiceInfosResponseWithArray:(NSArray *)resultArray;

@end
