//
//  SearchTicketInfosByNoResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//2.64	查询票号信息接口 （低价推送得到的票）
#import <Foundation/Foundation.h>
#import "SegsInfo.h"
#import "PassengerInfomation.h"
#import "GetOrderInfoDetailResponse.h"

@interface SubSegsInfo : SegsInfo
@property (nonatomic,retain) NSString * totalMoney;  //  票面价格  价格以元为单位
@property (nonatomic,retain) NSString * fuelTax;  //  燃油税  价格以元为单位
@property (nonatomic,retain) NSString * airportTax;  //  机场  价格以元为单位
@end

@interface FareMovement : NSObject
@property (nonatomic,retain) NSString * movemengtDate;
@property (nonatomic,retain) NSString * movemengtPrice;
@end

@interface SearchTicketInfosByNoResponse : NSObject
@property (nonatomic,retain) SubSegsInfo * segsInfos;  //  航班信息
@property (nonatomic,retain) PassengerInfomation * psgInfos;  //  旅客信息
@property (nonatomic,retain) LtineraryMailInfo * ltineraryMailInfos;  //  行程单信息
@property (nonatomic,retain) NSString * isInsure;  //  是否购买保险
@property (nonatomic,retain) NSArray * fareMovements;  //  趋势图信息

+(SearchTicketInfosByNoResponse *) searchTicketInfosByNoResponseWithDic:(NSDictionary * ) resultDic;
@end
