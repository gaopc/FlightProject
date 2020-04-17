//
//  GetConfiguration.m
//  FlightProject
//
//  Created by longcd on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetConfiguration.h"
#import "MobClick.h"

@implementation Version

@synthesize _url,_code,_desc,_name,_mandatoryCode;
-(void)dealloc
{
    self._url = nil;
    self._code = nil;
    self._desc = nil;
    self._name = nil;
    self._mandatoryCode = nil;
    [super dealloc];
}
+(Version *)version:(NSDictionary *)resultDic
{
    if (![resultDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    Version * ver = [[Version alloc] init];
    ver._code = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"code"]] ;
     ver._url = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"url"]] ;
     ver._name = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"name"]] ;
     ver._desc = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"desc"]] ;
    ver._mandatoryCode = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"mandatoryCode"]] ;
    return [ver autorelease];
}

@end

@implementation GetConfiguration

@synthesize _umeng,_isFirst,_unPayOrders,_insurance,_airportVersion,_airportCItyVersion,_hotelCityVersion,_carRentalVersion,_trainCityVersion,_weatherCithVersion;
@synthesize _version;
@synthesize _messageArray;
@synthesize needUpdateAirportInfo,needUpdateAirportCityInfo,needUpdateHotelCityList,needUpdateCarRentalList,needUpdateTrainCitysList,needUpdateWeatherCitysList;
@synthesize _advertisingImg, _advertisingImgBig;
-(void)dealloc
{
    self._umeng = nil;
    self._isFirst = nil;
    self._unPayOrders = nil;
    self._insurance = nil;
    self._airportVersion = nil;
    self._airportCItyVersion = nil;
    self._hotelCityVersion = nil;
    self._carRentalVersion = nil;
    self._trainCityVersion = nil;
    self._weatherCithVersion = nil;
    self._version = nil;
    self._messageArray = nil;
    self._advertisingImgBig = nil;
    self._advertisingImg = nil;
    
    [super dealloc];
}

+(GetConfiguration *) shareGetConfiguration
{
    static GetConfiguration * configuration = nil;
    if (configuration == nil) {
        configuration = [[GetConfiguration alloc] init];
        configuration.needUpdateAirportInfo = TRUE;
        configuration.needUpdateAirportCityInfo = TRUE;
        configuration.needUpdateHotelCityList = TRUE;
        configuration.needUpdateCarRentalList = TRUE;
        configuration.needUpdateTrainCitysList = TRUE;
        configuration.needUpdateWeatherCitysList = TRUE;
    }
    return configuration;
}
+(GetConfiguration * )shareGetConfiguration : (NSDictionary *)resultDic
{
    if (![resultDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSLog(@"是否注册：%@", [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"first"]]);
    GetConfiguration * configuration = [GetConfiguration shareGetConfiguration];
    if (resultDic == nil || [[resultDic objectForKey:@"statusCode"] intValue] != 0) {
        configuration._umeng = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"umeng"]] ;
        configuration._isFirst = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"first"]] ;
        configuration._unPayOrders = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"unpaidOrders"]] ;
        configuration._insurance = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"insurance"]] ;
        configuration._airportVersion = @"0";
        configuration._airportCItyVersion = @"0";
        configuration._hotelCityVersion = @"0";
        configuration._carRentalVersion = @"0";
        configuration._trainCityVersion = @"0";
        configuration._weatherCithVersion = @"0";
        configuration._advertisingImg = [NSString stringWithFormat:@"%@", [resultDic objectForKey:@"advertisingImg"]];
        configuration._advertisingImgBig = [NSString stringWithFormat:@"%@", [resultDic objectForKey:@"advertisingImgBig"]];
        configuration._version = [Version version:[resultDic objectForKey:@"version"]];
        configuration._messageArray = [NSArray arrayWithObjects:@"请稍等，正在为您加载...", nil];
    }
    else {
        configuration._umeng = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"umeng"]] ;
        configuration._isFirst = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"first"]] ;
        configuration._unPayOrders = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"unpaidOrders"]] ;
        configuration._insurance = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"insurance"]] ;
        configuration._airportVersion = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"airportVersion"]] ;
        configuration._airportCItyVersion = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"airportCityVersion"]] ;
        configuration._hotelCityVersion = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"hotelCityVersion"]] ;
        configuration._carRentalVersion = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"carRentalVersion"]] ;
        configuration._trainCityVersion = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"trainStationVersion"]] ;
        configuration._weatherCithVersion = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"weatherCityVersion"]] ;
        configuration._advertisingImg = [NSString stringWithFormat:@"%@", [resultDic objectForKey:@"advertisingImg"]];
        configuration._advertisingImgBig = [NSString stringWithFormat:@"%@", [resultDic objectForKey:@"advertisingImgBig"]];
        configuration._version = [Version version:[resultDic objectForKey:@"version"]];
        NSString * messageStr = [NSString stringWithFormat:@"%@",[[resultDic objectForKey:@"news"] isKindOfClass:[NSNull class]]?[resultDic objectForKey:@"news"]:@""] ;
        if ([messageStr isEqualToString:@""]) {
            configuration._messageArray = [NSArray arrayWithObjects:@"请稍等，正在为您加载...", nil];
        }
        else {
            configuration._messageArray = [messageStr componentsSeparatedByString:@"&"];
            if ([configuration._messageArray count] == 0) {
                configuration._messageArray = [NSArray arrayWithObjects:@"请稍等，正在为您加载...", nil];
            }
        }

        if ([configuration._umeng boolValue]) {
            // 友盟统计
            // [MobClick setLogEnabled:YES];
            [MobClick setAppVersion:[NSString stringWithFormat:@"%@",MyVersion]]; 
            [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:REALTIME channelId:channelNo];
            [MobClick updateOnlineConfig];
            [MobClick setCrashReportEnabled:YES];
        }
        else {
        }
    }
    return configuration ;
}

@end
