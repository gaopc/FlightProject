//
//  QueryWeatherInfo.h
//  FlightProject
//
//  Created by 月 小 on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirportWeatherInfo : NSObject

@property(nonatomic,retain)NSString *lowTemperature;
@property(nonatomic,retain)NSString *topTemperature;
@property(nonatomic,retain)NSString *wind;
@property(nonatomic,retain)NSString *weather;
@property(nonatomic,retain)NSString *airQuality;
@property(nonatomic,retain)NSString *imageUrl;

@end


@interface QueryWeatherInfo : NSObject
@property(nonatomic,retain)NSString *updateDate;
@property(nonatomic,retain)NSString *info;
@property(nonatomic,retain)NSString *describe;
@property(nonatomic,retain)NSArray *weatherInfoList;

+(QueryWeatherInfo*)GetQueryWeatherInfoByAirportCode:(NSDictionary*)dic;
@end
