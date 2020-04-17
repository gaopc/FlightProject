//
//  GetWeatherInfoResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OtherWeatherInfo : NSObject
@property  (nonatomic,retain) NSString * situation; //概况
@property (nonatomic,retain) NSString * temperature;//气温
@property (nonatomic,retain) NSString * wind;//风力/风向
@property (nonatomic,retain) NSString * image1;//天气图标1
@property (nonatomic,retain) NSString * image2;//天气图标2
@end

@interface WeatherInfo : NSObject
@property  (nonatomic,retain) NSString * city;
@property (nonatomic,retain) NSString * updateDate;
@property (nonatomic,retain) NSString * liveWeather;
@property (nonatomic,retain) NSString * airQuality;
@property (nonatomic,retain) NSString * weatherIndex;
@property  (nonatomic,retain) NSString * weather;
@property (nonatomic,retain) NSString * temperature;
@property (nonatomic,retain) NSString * wind;
@property (nonatomic,retain) NSString * image1;
@property (nonatomic,retain) NSString * image2;
@property (nonatomic,retain) NSArray * otherWeathers;
@end

@interface GetWeatherInfoResponse : NSObject


+(WeatherInfo *)GetWeatherInfoResponseWithArray:(NSArray *)resultArray;

@end
