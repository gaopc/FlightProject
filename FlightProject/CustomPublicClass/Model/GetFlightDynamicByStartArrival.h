//
//  GetFlightDynamicByStartArrival.h
//  FlightProject
//
//  Created by 月 小 on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetFlightDynamicByFlightNo.h"

@interface FlightDynamic3 : NSObject
@property(nonatomic,retain)NSString *flightCompang;
@property(nonatomic,retain)NSString *flightLogo;
@property(nonatomic,retain)NSString *flightNo;
@property(nonatomic,retain)NSString *departure;
@property(nonatomic,retain)NSString *arrival;
@property(nonatomic,retain)NSString *statusName;
@property(nonatomic,retain)NSString *startAirport;
@property(nonatomic,retain)NSString *startTerminal;
@property(nonatomic,retain)NSString *endAirport;
@property(nonatomic,retain)NSString *endTerminal;
@property(nonatomic,retain)TimeInfo *takeOffTime;
@property(nonatomic,retain)TimeInfo *reachTime;
@end

@interface GetFlightDynamicByStartArrival : NSObject
@property(nonatomic,retain)NSArray *flightDynamicAry;

+(NSArray *)getFlightDynamicByStartArrival:(NSDictionary *)dic;
@end
