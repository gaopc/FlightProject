//
//  QueryWeatherInfo.m
//  FlightProject
//
//  Created by 月 小 on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QueryWeatherInfo.h"

@implementation AirportWeatherInfo
@synthesize lowTemperature,topTemperature,wind,weather,airQuality,imageUrl;
 
- (void)dealloc
{
    self.lowTemperature = nil;
    self.topTemperature = nil;
    self.wind = nil;
    self.weather = nil;
    self.airQuality = nil;
    self.imageUrl = nil;
    [super dealloc];
}

@end

@implementation QueryWeatherInfo
@synthesize updateDate,info,describe,weatherInfoList;

- (void)dealloc
{
    self.updateDate = nil;
    self.info = nil;
    self.describe = nil;
    self.weatherInfoList = nil;
    [super dealloc];
}

+(QueryWeatherInfo*)GetQueryWeatherInfoByAirportCode:(NSDictionary*)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    QueryWeatherInfo *queryWeatherInfo = [[QueryWeatherInfo alloc] init];
    queryWeatherInfo.updateDate = [NSString stringWithFormat:@"%@",[dic objectForKey:@"updateDate"]];
    queryWeatherInfo.info = [NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
    queryWeatherInfo.describe = [NSString stringWithFormat:@"%@",[dic objectForKey:@"describe"]];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *temp = [dic objectForKey:@"weatherInfoList"];
    if ([temp isKindOfClass:[NSArray class]]) {
        for(id elem in temp)
        {
            AirportWeatherInfo *airportWeatherInfo = [[AirportWeatherInfo alloc] init];
            airportWeatherInfo.lowTemperature = [NSString stringWithFormat:@"%@",[elem objectForKey:@"lowTemperature"]];
            airportWeatherInfo.topTemperature = [NSString stringWithFormat:@"%@",[elem objectForKey:@"topTemperature"]];
            airportWeatherInfo.wind = [NSString stringWithFormat:@"%@",[elem objectForKey:@"wind"]];
            airportWeatherInfo.weather = [NSString stringWithFormat:@"%@",[elem objectForKey:@"weather"]];
            airportWeatherInfo.airQuality = [NSString stringWithFormat:@"%@",[elem objectForKey:@"airQuality"]];
            airportWeatherInfo.imageUrl = [NSString stringWithFormat:@"%@",[elem objectForKey:@"imageUrl"]];
            [array addObject:airportWeatherInfo];
            [airportWeatherInfo release];
        }
    }
   
    queryWeatherInfo.weatherInfoList = array;
    [array release];
    if ([queryWeatherInfo.weatherInfoList count] == 0) {
        queryWeatherInfo.weatherInfoList = nil;
    }
    return [queryWeatherInfo autorelease];
}
@end
