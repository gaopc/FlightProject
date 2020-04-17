//
//  GetFlightDynamicByFlightNo.h
//  FlightProject
//
//  Created by 月 小 on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeInfo : NSObject
@property(nonatomic,retain)NSString *plan;
@property(nonatomic,retain)NSString *forecast;
@property(nonatomic,retain)NSString *actual;
@end

@interface StopoverInfo : NSObject
@property(nonatomic,retain)NSString *departure;
@property(nonatomic,retain)NSString *arrival;
@property(nonatomic,retain)NSString *departureCode;
@property(nonatomic,retain)NSString *arrivalCode;
@property(nonatomic,retain)NSString *statusCode;
@property(nonatomic,retain)NSString *startAirport;
@property(nonatomic,retain)NSString *startTerminal;
@property(nonatomic,retain)NSString *endAirport;
@property(nonatomic,retain)NSString *endTerminal;
@property(nonatomic,retain)NSString *date;
@property(nonatomic,retain)TimeInfo *takeOffTime;
@property(nonatomic,retain)TimeInfo *reachTime;
@end

@interface GetFlightDynamicByFlightNo : NSObject
@property(nonatomic,retain)NSString *attentionId;
@property(nonatomic,retain)NSString *flightCompany;
@property(nonatomic,retain)NSArray *stopoverInfos;
@property(nonatomic,retain)NSString *agoFlightNo;//3.6期添加
@property(nonatomic,retain)NSString *agoFlightDesc;//3.6期添加
+(GetFlightDynamicByFlightNo *)GetFlightDynamicByFlightNo:(NSDictionary *)dic;
@end
