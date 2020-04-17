//
//  QueryFlightTicketDetail.h
//  FlightProject
//
//  Created by longcd on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopCityInfo : NSObject
@property (nonatomic,retain)NSString * _name;
@property (nonatomic,retain)NSString * _time;
@end

@interface QueryFlightTicketDetail : NSObject //查询航班详情信息
@property (nonatomic,retain)NSString * _airportTaxForAdult;
@property (nonatomic,retain)NSString * _airportTaxForChild;
@property (nonatomic,retain)NSString * _fuelTaxForAdult;
@property (nonatomic,retain)NSString * _fuelTaxForChild;
@property (nonatomic,retain)NSArray * _stopCityInfo;

+(QueryFlightTicketDetail *)QueryFlightTicketDetail:(NSDictionary *)dic;
@end
