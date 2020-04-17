//
//  GetWeatherInfoResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetWeatherInfoResponse.h"

@implementation OtherWeatherInfo

@synthesize situation,temperature,wind,image1,image2;
-(void)dealloc
{
    self.situation = nil;
    self.temperature = nil;
    self.wind = nil;
    self.image1 = nil;
    self.image2 = nil;
    [super dealloc];
}
-(NSString *)description
{
    NSString * str = [NSString stringWithFormat:@"situation=%@,temperature=%@,wind=%@,image1=%@,image2=%@",self.situation,self.temperature,self.wind,self.image1,self.image2];
    return str;
}

@end

@implementation WeatherInfo

@synthesize city,updateDate,liveWeather,airQuality,wind,weather,weatherIndex,temperature,image2,image1,otherWeathers;
-(void)dealloc
{
    self.city = nil;
    self.updateDate = nil;
    self.liveWeather = nil;
    self.airQuality = nil;
    self.image2 = nil;
    self.wind = nil;
    self.weather = nil;
    self.weatherIndex = nil;
    self.temperature = nil;
    self.image2 = nil;
    self.image1 = nil;
    self.otherWeathers = nil;
    [super dealloc];
}
-(NSString *)description
{
    NSString * str = [NSString stringWithFormat:@"city=%@,updateDate=%@,liveWeather=%@,airQuality=%@,wind=%@,weather=%@,weatherIndex=%@,temperature=%@,image2=%@,image1=%@,otherWeathers=%@",self.city,self.updateDate,self.liveWeather,self.airQuality,self.wind,self.weather,self.weatherIndex,self.temperature,self.image2,self.image1,self.otherWeathers];
    return str;
}

@end

@implementation GetWeatherInfoResponse
+(OtherWeatherInfo *) getOtherWeathersWithElem:(NSArray *)elem
{
    OtherWeatherInfo * info = [[OtherWeatherInfo alloc] init];
    info.situation = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    info.temperature = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    info.wind = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    info.image1 = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    info.image2 = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    return [info autorelease];
}
+(WeatherInfo *)GetWeatherInfoResponseWithArray:(NSArray *)resultArray
{
    WeatherInfo * weatherInfo = nil;
    if ([[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:0]] isEqualToString:@"0"]) {
        weatherInfo = [[WeatherInfo alloc] init];
        weatherInfo.city = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
        weatherInfo.updateDate = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:3]];
        weatherInfo.liveWeather = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:4]];
        weatherInfo.airQuality = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:5]];
        weatherInfo.weatherIndex = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:6]];
        weatherInfo.weather = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:7]];
        weatherInfo.temperature = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:8]];
        weatherInfo.wind = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:9]];
        weatherInfo.image1 = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:10]];
        weatherInfo.image2 = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:11]];
        NSArray * otherWeather = [[resultArray objectAtIndex:12] componentsSeparatedByString:@"+"];
        NSMutableArray * tempArray = [[NSMutableArray alloc] init];
        for (NSString * str in otherWeather) {
            NSArray * elem = [str componentsSeparatedByString:@";"];
            [tempArray addObject:[self getOtherWeathersWithElem:elem]];
        }
        weatherInfo.otherWeathers = tempArray;
        [tempArray release];
    }
    else {
        //[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:1]] ];
    }
    //NSLog(@"%@",weatherInfo);
    return [weatherInfo autorelease];

}
@end
