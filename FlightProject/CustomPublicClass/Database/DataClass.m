//
//  DataClass.m
//  FlightProject
//
//  Created by longcd on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataClass.h"


@implementation DataClass


// 20121008 zxt 重新创建数据库
// --------添加
+(void) insertIntoAirportCityListWithArray:(NSArray *)array
{
//    [DataBaseClass deleteWithTable:@"AirportCityList"];
    NSArray * elem = [NSArray arrayWithObjects:@"city_code", @"city_name", @"ename", @"first_letter", @"jian_pin",@"flag",nil];
    if ([DataBaseClass deleteWithTable:@"AirportCityList"]) {
        [DataBaseClass insertWithTable:@"AirportCityList" WithElem:elem WithData:array];
    }
}
+(void) insertIntoAirportListWithArray:(NSArray *)array
{
    if ([DataBaseClass deleteWithTable:@"AirportList"]) {
        NSArray * elem = [NSArray arrayWithObjects:@"first_letter", @"airport_code", @"airport_name",@"flag", @"jian_pin",@"ename",nil];
        [DataBaseClass insertWithTable:@"AirportList" WithElem:elem WithData:array];
    }
}

+(void) insertIntointernationalAirportCityListWithArray:(NSArray *)array//3.6期
{
    if ([DataBaseClass deleteWithTable:@"IntointernationalAirportCityList"]) {
        NSArray * elem = [NSArray arrayWithObjects:@"city_code", @"city_name", @"ename", @"first_letter", @"jian_pin",@"flag",nil];
        [DataBaseClass insertWithTable:@"IntointernationalAirportCityList" WithElem:elem WithData:array];
    }
    
}

+(void) insertIntoHotelCityListWithArray:(NSArray *)array
{
    if ([DataBaseClass deleteWithTable:@"HotelCityList"]) {
        NSArray * elem = [NSArray arrayWithObjects:@"city_code",@"city_name", @"first_letter",@"flag", @"jian_pin",@"ename",nil];
        [DataBaseClass insertWithTable:@"HotelCityList" WithElem:elem WithData:array];
    }
}
+(void) insertIntoCarRentalListWithArray:(NSArray *)array
{
    if ([DataBaseClass deleteWithTable:@"CarRentalList"]) {
        NSArray * elem = [NSArray arrayWithObjects:@"city_code", @"city_name",@"first_letter",@"flag", @"jian_pin",@"ename",nil];
        [DataBaseClass insertWithTable:@"CarRentalList" WithElem:elem WithData:array];
    }
}
+(void) insertIntoWeatherCitysListWithArray:(NSArray *)array
{
    if ([DataBaseClass deleteWithTable:@"WeatherCityList"]) {
        NSArray * elem = [NSArray arrayWithObjects:@"city_code", @"city_name",@"first_letter",@"flag", @"jian_pin",@"ename",nil];
        [DataBaseClass insertWithTable:@"WeatherCityList" WithElem:elem WithData:array];
    }
}
+(void) insertIntoTrainCitysListWithArray:(NSArray *)array
{
    if ([DataBaseClass deleteWithTable:@"TrainCitysList"]) {
        NSArray * elem = [NSArray arrayWithObjects:@"city_code", @"city_name",@"first_letter",@"flag", @"jian_pin",@"ename",@"isshow",nil];
        [DataBaseClass insertWithTable:@"TrainCitysList" WithElem:elem WithData:array];
    }
}

+(BOOL) insertIntoFlight_City_HistortyWithArray:(NSArray *)array
{
    // 先删除，再添加，保持六条记录
    
    NSString *where = [NSString stringWithFormat:@"  start_city_code = '%@' and end_city_code = '%@' ",[[array objectAtIndex:0] objectAtIndex:0],[[array objectAtIndex:0] objectAtIndex:2]];
    [DataBaseClass deleteWithTable:@" Flight_City_History " WithARecord:where];
    
    NSArray *elem = [NSArray arrayWithObjects:@"start_city_code", @"start_city",@"end_city_code", @"end_city",nil];
    NSString * conditions =[NSString stringWithFormat:@" Flight_City_History  "];
    NSUInteger count = [[DataBaseClass selectWithElem:elem WithTablename:@"Flight_City_History" WithConditions:conditions] count];
    if(count < 6)
    {
    return [DataBaseClass insertWithTable:@"Flight_City_History" WithElem:elem WithData:array];
    }
    else {
        NSString *where = [NSString stringWithFormat:@"  id = (  select min(id) from Flight_City_History ) "];
        
        
        if ([DataBaseClass deleteWithTable:@" Flight_City_History " WithARecord:where]) {
            NSArray * elem = [NSArray arrayWithObjects:@"start_city_code", @"start_city",@"end_city_code", @"end_city",nil];
            return [DataBaseClass insertWithTable:@"Flight_City_History" WithElem:elem WithData:array];
        } 
        else {
            return NO;
        }
    }
}
+(BOOL) insertIntoFlight_Num_HistortyWithArray:(NSArray *)array
{
    // 先删除，再添加，保持六条记录
    
    NSString *where = [NSString stringWithFormat:@"  flight_no = '%@' ",[[array objectAtIndex:0] objectAtIndex:0]];
    [DataBaseClass deleteWithTable:@" Flight_Num_History " WithARecord:where];
    
//    NSArray *elem = [NSArray arrayWithObjects:@"count()", nil];
    NSArray *elem = [NSArray arrayWithObjects:@"flight_no", @"start_city",@"end_city",nil];
    NSString * conditions =[NSString stringWithFormat:@" Flight_Num_History  "];
    NSUInteger count = [[DataBaseClass selectWithElem:elem WithTablename:@"Flight_Num_History" WithConditions:conditions] count];
    
    if (count < 6) {
        return [DataBaseClass insertWithTable:@"Flight_Num_History" WithElem:elem WithData:array];
    }
    else {
        NSString *where = [NSString stringWithFormat:@"  id = (  select min(id) from Flight_Num_History ) "];
        
        if ([DataBaseClass deleteWithTable:@" Flight_Num_History " WithARecord:where]) {
            NSArray * elem = [NSArray arrayWithObjects:@"flight_no",@"start_city",@"end_city",nil];
            return [DataBaseClass insertWithTable:@"Flight_Num_History" WithElem:elem WithData:array];
        }
        else {
            return NO;
        }
    }
}
+(void) insertIntoFlight_City_HotWithArray:(NSArray *)array
{
    [DataBaseClass deleteWithTable:@"Flight_Search_History"];
    NSArray * elem = [NSArray arrayWithObjects:@"start_city_code", @"start_city",@"end_city_code", @"end_city",nil];
    [DataBaseClass insertWithTable:@"Flight_Search_History" WithElem:elem WithData:array];
}
+(BOOL) insertIntoFlight_Search_HistoryWithArray:(NSArray *)array
{
    // 先删除，再添加，保持四条记录
    NSString *where = [NSString stringWithFormat:@"  start_city_code = '%@' and end_city_code = '%@' ",[[array objectAtIndex:0] objectAtIndex:0],[[array objectAtIndex:0] objectAtIndex:2]];
    [DataBaseClass deleteWithTable:@" Flight_Search_History " WithARecord:where];
    
    NSArray *elem = [NSArray arrayWithObjects:@"start_city_code", @"start_city",@"end_city_code", @"end_city",nil];
    NSString * conditions =[NSString stringWithFormat:@" Flight_Search_History  "];
    NSUInteger count = [[DataBaseClass selectWithElem:elem WithTablename:@"Flight_Search_History" WithConditions:conditions] count];
    
    if(count < 4)
    {
        return [DataBaseClass insertWithTable:@"Flight_Search_History" WithElem:elem WithData:array];
    }
    else {
        NSString *where = [NSString stringWithFormat:@"  id = (  select min(id) from Flight_Search_History ) "];
        
        
        if ([DataBaseClass deleteWithTable:@" Flight_Search_History " WithARecord:where]) {
            NSArray * elem = [NSArray arrayWithObjects:@"start_city_code", @"start_city",@"end_city_code", @"end_city",nil];
            return [DataBaseClass insertWithTable:@"Flight_Search_History" WithElem:elem WithData:array];
        } 
        else {
            return NO;
        }
    }
}
+(BOOL) insertIntoTrain_Num_HistoryWithArray:(NSArray *)array
{
    // 先删除，再添加，保持六条记录
    
    NSString *where = [NSString stringWithFormat:@"  trainNumber = '%@' ",[[array objectAtIndex:0] objectAtIndex:2]];
    [DataBaseClass deleteWithTable:@" Train_Num_History " WithARecord:where];
 
    NSArray *elem = [NSArray arrayWithObjects:@"startStation",@"endStation",@"trainNumber",nil];
    NSString * conditions =[NSString stringWithFormat:@" Train_Num_History  "];
    NSUInteger count = [[DataBaseClass selectWithElem:elem WithTablename:@"Train_Num_History" WithConditions:conditions] count];
    
    if (count < 4) {
        return [DataBaseClass insertWithTable:@"Train_Num_History" WithElem:elem WithData:array];
    }
    else {
        NSString *where = [NSString stringWithFormat:@"  id = (  select min(id) from Train_Num_History ) "];
        
        if ([DataBaseClass deleteWithTable:@" Train_Num_History " WithARecord:where]) {
            NSArray * elem = [NSArray arrayWithObjects:@"startStation",@"endStation",@"trainNumber",nil];
            return [DataBaseClass insertWithTable:@"Train_Num_History" WithElem:elem WithData:array];
        }
        else {
            return NO;
        }
    }
}

+(BOOL) insertIntoTrain_Station_HistoryWithArray:(NSArray *)array
{
    // 先删除，再添加，保持六条记录
    
    NSString *where = [NSString stringWithFormat:@"  startStation = '%@' and endStation = '%@' ",[[array objectAtIndex:0] objectAtIndex:0],[[array objectAtIndex:0] objectAtIndex:1]];
    [DataBaseClass deleteWithTable:@" Train_Station_History " WithARecord:where];
    
    NSArray *elem = [NSArray arrayWithObjects:@"startStation",@"endStation",@"trainNumber",nil];
    NSString * conditions =[NSString stringWithFormat:@" Train_Station_History  "];
    NSUInteger count = [[DataBaseClass selectWithElem:elem WithTablename:@"Train_Station_History" WithConditions:conditions] count];
    if(count < 4)
    {
        return [DataBaseClass insertWithTable:@"Train_Station_History" WithElem:elem WithData:array];
    }
    else {
        NSString *where = [NSString stringWithFormat:@"  id = (  select min(id) from Train_Station_History ) "];
        
        
        if ([DataBaseClass deleteWithTable:@" Train_Station_History " WithARecord:where]) {
            NSArray * elem = [NSArray arrayWithObjects:@"startStation",@"endStation",@"trainNumber",nil];
            return [DataBaseClass insertWithTable:@"Train_Station_History" WithElem:elem WithData:array];
        }
        else {
            return NO;
        }
    }
}

+ (BOOL) insertIntoTrain_Searth_HistoryWithArray:(NSArray *)array
{
    // 先删除，再添加，保持四条记录
    NSString *where = [NSString stringWithFormat:@"  startStation_code = '%@' and endStation_code = '%@' ",[[array objectAtIndex:0] objectAtIndex:1],[[array objectAtIndex:0] objectAtIndex:3]];
    [DataBaseClass deleteWithTable:@" Train_Search_History " WithARecord:where];
    
    NSArray *elem = [NSArray arrayWithObjects:@"startStation", @"startStation_code",@"endStation", @"endStation_code",nil];
    NSString * conditions =[NSString stringWithFormat:@" Train_Search_History  "];
    NSUInteger count = [[DataBaseClass selectWithElem:elem WithTablename:@"Train_Search_History" WithConditions:conditions] count];
    
    if(count < 4)
    {
        return [DataBaseClass insertWithTable:@"Train_Search_History" WithElem:elem WithData:array];
    }
    else {
        NSString *where = [NSString stringWithFormat:@"  id = (  select min(id) from Train_Search_History ) "];
        
        
        if ([DataBaseClass deleteWithTable:@" Train_Search_History " WithARecord:where]) {
            NSArray * elem = [NSArray arrayWithObjects:@"startStation", @"startStation_code",@"endStation", @"endStation_code",nil];
            return [DataBaseClass insertWithTable:@"Train_Search_History" WithElem:elem WithData:array];
        }
        else {
            return NO;
        }
    }
}

// --------查询
+(NSArray *) selectFromAirportList
{
    NSArray *elem = [NSArray arrayWithObjects: @"airport_code", @"airport_name",@"first_letter",@"flag",  @"jian_pin",@"ename",nil];
    NSString * conditions =[NSString stringWithFormat:@" AirportList order by cast(flag as int) ,first_letter,ename  "];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"AirportList" WithConditions:conditions];
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSArray * elem in array ) {
        [mArray addObject:[AirportList airportFromElem:elem ]];
    }
    return mArray;
}
+(NSArray *) selectFromAirportCityList
{
    NSArray *elem = [NSArray arrayWithObjects:@"city_code", @"city_name", @"ename", @"first_letter", @"jian_pin",@"flag", nil];
    NSString * conditions =[NSString stringWithFormat:@" AirportCityList   order by cast(flag as int),first_letter,ename  "];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"AirportCityList" WithConditions:conditions];
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSArray * elem in array ) {
        [mArray addObject:[Citys cityFromElem:elem ]];
    }
    return mArray;
}
+(NSArray *) selectFromWeatherCityList
{
    NSArray *elem = [NSArray arrayWithObjects:@"city_code", @"city_name", @"ename", @"first_letter", @"jian_pin",@"flag", nil];
    NSString * conditions =[NSString stringWithFormat:@" WeatherCityList   order by cast(flag as int),first_letter,ename  "];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"WeatherCityList" WithConditions:conditions];
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSArray * elem in array ) {
        [mArray addObject:[Citys cityFromElem:elem ]];
    }
    return mArray;
}
+(NSArray *) selectFromIntointernationalAirportCityList
{
    NSArray *elem = [NSArray arrayWithObjects:@"city_code", @"city_name", @"ename", @"first_letter", @"jian_pin",@"flag", nil];
    NSString * conditions =[NSString stringWithFormat:@" IntointernationalAirportCityList   order by cast(flag as int),first_letter,ename  "];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"IntointernationalAirportCityList" WithConditions:conditions];
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSArray * elem in array ) {
        [mArray addObject:[Citys cityFromElem:elem ]];
    }
    return mArray;
}
+(NSArray *) selectFromHotelCityList
{
    NSArray *elem = [NSArray arrayWithObjects:@"city_code",@"city_name", @"first_letter",  @"flag",  @"jian_pin",@"ename",nil];
    NSString * conditions =[NSString stringWithFormat:@" HotelCityList order by cast(flag as int) ,first_letter,ename  "];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"HotelCityList" WithConditions:conditions];
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSArray * elem in array ) {
        [mArray addObject:[HotelCitys cityFromElem:elem ]];
    }
    return mArray;
}
+(NSArray *) selectFromCarRentalList
{
    NSArray *elem = [NSArray arrayWithObjects:@"city_code", @"city_name",@"first_letter",@"flag",  @"jian_pin",@"ename", nil];
    NSString * conditions =[NSString stringWithFormat:@" CarRentalList order by cast(flag as int) ,first_letter,ename  "];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"CarRentalList" WithConditions:conditions];
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSArray * elem in array ) {
        [mArray addObject:[CarCitys cityFromElem:elem ]];
    }
    return mArray;
}
+(NSArray *) selectFromTrainCitysList
{
    NSArray *elem = [NSArray arrayWithObjects:@"city_code", @"city_name",@"first_letter",@"flag",  @"jian_pin",@"ename", nil];
    NSString * conditions =[NSString stringWithFormat:@" TrainCitysList   order by cast(flag as int) ,first_letter,ename "];
    
//    NSString * conditions =[NSString stringWithFormat:@" TrainCitysList where isshow = '1'  order by cast(flag as int) ,first_letter,ename "];
    
//     NSString * conditions =[NSString stringWithFormat:@" TrainCitysList where isshow = '1' "];
    
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"TrainCitysList" WithConditions:conditions];
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSArray * elem in array ) {
        [mArray addObject:[TrainCitysList airportFromElem:elem ]];
    }
    return mArray;
}

+ (NSArray *) selectAllFromTrainCitysList
{
    NSArray *elem = [NSArray arrayWithObjects:@"city_code", @"city_name",@"first_letter",@"flag",  @"jian_pin",@"ename", nil];
    NSString * conditions =[NSString stringWithFormat:@" TrainCitysList   "];
//    NSString * conditions =[NSString stringWithFormat:@" TrainCitysList   order by cast(flag as int) ,first_letter,ename "];
//    NSString * conditions =[NSString stringWithFormat:@" TrainCitysList where isshow = '1'  order by cast(flag as int) ,first_letter,ename "];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"TrainCitysList" WithConditions:conditions];
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSArray * elem in array ) {
        [mArray addObject:[TrainCitysList airportFromElem:elem ]];
    }
    return mArray;
}

+(NSArray *) selectFromFlight_City_Historty
{
    NSArray *elem = [NSArray arrayWithObjects:@"start_city_code", @"start_city",@"end_city_code", @"end_city", nil];
    NSString * conditions =[NSString stringWithFormat:@" Flight_City_History order by id desc"];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Flight_City_History" WithConditions:conditions];
    return array;
}
+(NSArray *) selectFromFlight_Num_Historty
{
    NSArray *elem = [NSArray arrayWithObjects:@"flight_no", @"start_city",@"end_city",nil];
    NSString * conditions =[NSString stringWithFormat:@" Flight_Num_History order by id desc"];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Flight_Num_History" WithConditions:conditions];
    return array;
}
+(NSArray *) selectFromFlight_Search_History
{
    NSArray *elem = [NSArray arrayWithObjects:@"start_city_code", @"start_city",@"end_city_code", @"end_city", nil];
    NSString * conditions =[NSString stringWithFormat:@" Flight_Search_History order by id desc"];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Flight_Search_History" WithConditions:conditions];
    return array;
}
+(NSArray *) selectFromVersions
{
    NSArray *elem = [NSArray arrayWithObjects:@"table_name", @"version", nil];
    NSString * conditions =[NSString stringWithFormat:@" Versions "];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Versions" WithConditions:conditions];
    return array;
}

+(NSArray *) selectFromTrain_Num_History
{
    NSArray *elem = [NSArray arrayWithObjects:@"startStation", @"endStation",@"trainNumber",nil];
    NSString * conditions =[NSString stringWithFormat:@" Train_Num_History order by id desc"];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Train_Num_History" WithConditions:conditions];
    return array;
}
+(NSArray *) selectFromTrain_Station_History
{
    NSArray *elem = [NSArray arrayWithObjects:@"startStation", @"endStation",nil];
    NSString * conditions =[NSString stringWithFormat:@" Train_Station_History order by id desc"];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Train_Station_History" WithConditions:conditions];
    return array;
}

+ (NSArray *) selectFromTrain_Search_History //火车查询历史记录
{
    NSArray *elem = [NSArray arrayWithObjects:@"startStation", @"startStation_code",@"endStation", @"endStation_code", nil];
    NSString * conditions =[NSString stringWithFormat:@" Train_Search_History order by id desc"];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Train_Search_History" WithConditions:conditions];
    return array;
}

+(NSString * ) selectFromAirportCityListWithCityName:(NSString *)cityName
{
    NSArray *elem = [NSArray arrayWithObjects:@"city_code", @"city_name", @"ename", @"first_letter", @"jian_pin",@"flag", nil];
    NSString * conditions =[NSString stringWithFormat:@" AirportCityList   where city_name = '%@' ",cityName];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"AirportCityList" WithConditions:conditions];
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSArray * elem in array ) {
        [mArray addObject:[Citys cityFromElem:elem ]];
    }
    Citys * city = nil;
    if ([mArray count] > 0) {
        city = [mArray objectAtIndex:0];
    }
    return city._city_code;

}
+(NSString * ) selectFromAirportCityListWithCityCode:(NSString *)cityCode
{
    NSArray *elem = [NSArray arrayWithObjects:@"city_code", @"city_name", @"ename", @"first_letter", @"jian_pin",@"flag", nil];
    NSString * conditions =[NSString stringWithFormat:@" AirportCityList   where city_code = '%@' ",cityCode];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"AirportCityList" WithConditions:conditions];
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSArray * elem in array ) {
        [mArray addObject:[Citys cityFromElem:elem ]];
    }
    Citys * city = nil;
    if ([mArray count] > 0) {
        city = [mArray objectAtIndex:0];
    }
    return city._city_name;
    
}
+(NSString *  ) selectFromHotelCityListWithCityName:(NSString *)cityName
{
    NSArray *elem = [NSArray arrayWithObjects:@"city_code", @"city_name", @"first_letter",@"flag",  @"jian_pin",@"ename", nil];
    NSString * conditions =[NSString stringWithFormat:@" HotelCityList  where city_name = '%@' ",cityName];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"HotelCityList" WithConditions:conditions];
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSArray * elem in array ) {
        [mArray addObject:[HotelCitys cityFromElem:elem ]];
    }
    HotelCitys * city = nil;
    if ([mArray count] >0) {
        city = [mArray objectAtIndex:0];
    }
    return city._city_code;

}
+(NSString *  ) selectFromCarRentalListWithCityName:(NSString *)cityName
{
    NSArray *elem = [NSArray arrayWithObjects:@"city_code", @"city_name",@"first_letter", @"flag",  @"jian_pin",@"ename",nil];
    NSString * conditions =[NSString stringWithFormat:@" CarRentalList where city_name = '%@' ",cityName];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"CarRentalList" WithConditions:conditions];
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSArray * elem in array ) {
        [mArray addObject:[CarCitys cityFromElem:elem ]];
    }
    CarCitys * city = nil;
    if ([mArray count] >0) {
        city = [mArray objectAtIndex:0];
    }
    return city._city_code;
}

+(NSString *  ) selectFromCarRentalListWithCityCode:(NSString *)cityCode
{
    NSArray *elem = [NSArray arrayWithObjects:@"city_code", @"city_name",@"first_letter",@"flag",  @"jian_pin",@"ename", nil];
    NSString * conditions =[NSString stringWithFormat:@" CarRentalList where city_code = '%@' ",cityCode];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"CarRentalList" WithConditions:conditions];
    NSMutableArray * mArray = [NSMutableArray array];
    for (NSArray * elem in array ) {
        [mArray addObject:[CarCitys cityFromElem:elem ]];
    }
    CarCitys * city = nil;
    if ([mArray count] >0) {
        city = [mArray objectAtIndex:0];
    }
    return city._city_name;
}

// --------删除
// 20121008 zxt 重新创建数据库



+(void)insertIntoCitysWithArray:(NSArray *)array
{
    NSArray * elem = [NSArray arrayWithObjects:@"city_class", @"city_code", @"airport_name", @"city_name", @"city_spell",@"city_abbreviation", @"city_hot",@"isShowInCityList",nil];
    [DataBaseClass insertWithTable:@"Citys" WithElem:elem WithData:array];
}
+(void)insertIntoDeviceAddressWithArray:(NSArray *)array
{
    NSArray * elem = [NSArray arrayWithObjects:@"city_name", @"longitude",@"latitude",@"address",nil];
    [DataBaseClass insertWithTable:@"DeviceAddress" WithElem:elem WithData:array];
}

+ (NSArray *)selectDeviceAddress:(NSString *) cityName
{
    NSArray *elem = [NSArray arrayWithObjects:@"city_name", @"longitude", @"latitude", @"address", nil];
    NSString * conditions =[NSString stringWithFormat:@" DeviceAddress where city_name = '%@'",cityName];
    
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"DeviceAddress" WithConditions:conditions];
    return array;
}
+ (NSArray *)selectDeviceAddressCitys
{
    NSArray *elem = [NSArray arrayWithObjects:@" distinct city_name", nil];
    
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"DeviceAddress" WithConditions:@" DeviceAddress "];
    return array;
}



+(void) insertintoBunk_infoWithArray:(NSArray *)array
{
    NSString * tableName = @"BunkInfo";
    NSArray * elem = [NSArray arrayWithObjects:@"airport_code",@"cabin_code",@"cabin_name",@"standard_cabin_code", nil];
    if ([DataBaseClass insertWithTable:tableName WithElem:elem WithData:array]) {
        NSDateFormatter* format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString* time = [format stringFromDate: [NSDate date]];
        [format release];
        
        [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"BunkInfo",time, nil], nil]];
    };
    
}
+(NSString *)selectBunkInfoVersion
{
    NSString * table = @"Versions";
    NSArray *elem = [NSArray arrayWithObjects:@"version", nil];
    NSString * conditions = @"Versions where table_name = 'BunkInfo'";
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:table WithConditions:conditions];
    if ([array count] == 0) {
        return @"0000-00-00 00:00:00";
    }
    return [[array objectAtIndex:0] objectAtIndex:0];
}
+(void) insertintoDirectCityWithArray:(NSArray *)array
{
    NSString * tableName = @"DirectCity";
    NSArray * elem = [NSArray arrayWithObjects:@"fromcity_code",@"arrcity_code", nil];
    if ([DataBaseClass insertWithTable:tableName WithElem:elem WithData:array]) {
        
        NSDateFormatter* format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString* time = [format stringFromDate: [NSDate date]];
        [format release];
        
        [DataBaseClass insertWithTable:@"Versions" WithElem:[NSArray arrayWithObjects:@"table_name",@"version", nil] WithData:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"DirectCity",time, nil], nil]];
    };
    
}
+(NSString *)selectDirectCityVersion
{
    NSString * table = @"Versions";
    NSArray *elem = [NSArray arrayWithObjects:@"version", nil];
    NSString * conditions = @" Versions where table_name = 'DirectCity'";
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:table WithConditions:conditions];
    if ([array count] == 0) {
        return nil;
    }
    return [[array objectAtIndex:0] objectAtIndex:0];
    
}

+(void)insertIntoAirlinesWithArray:(NSArray *)array
{
    NSArray * elem = [NSArray arrayWithObjects:@"airline_code", @"airline_name",@"airline_name_abbreviation",@"airline_telephone",nil];
    [DataBaseClass insertWithTable:@"Airlines" WithElem:elem WithData:array];
}
+(NSArray *)selectAirlines
{
    NSArray * elem = [NSArray arrayWithObjects:@"airline_code", @"airline_name",@"airline_name_abbreviation",@"airline_telephone",nil];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Airlines" WithConditions:@"Airlines"];
    return [Airlines AirlinesWithArray:array];
}
+(NSString *)selectFromAirlinesWithCode:(NSString *)code
{
    NSArray * elem = [NSArray arrayWithObjects :@"airline_name_abbreviation",nil];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Airlines" WithConditions:[NSString stringWithFormat:@"Airlines where airline_code = '%@'",code] ];
    if ([array count] == 0) {
        return nil;
    }
    return [[array objectAtIndex : 0] objectAtIndex:0];
}
+(NSString *)selectFromCitysWithCode:(NSString *)code
{
    NSArray * elem = [NSArray arrayWithObjects :@"airport_name",nil];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Citys" WithConditions:[NSString stringWithFormat:@"Citys where city_code = '%@'",code]];
    if ([array count] == 0) {
        return nil;
    }
    return [[array objectAtIndex : 0] objectAtIndex:0];
}
+(NSString *)selectCityNameFromCitysWithCode:(NSString *)code
{
    NSArray * elem = [NSArray arrayWithObjects :@"city_name",nil];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Citys" WithConditions:[NSString stringWithFormat:@"Citys where city_code = '%@'",code]];
    if ([array count] == 0) {
        return nil;
    }
    return [[array objectAtIndex : 0] objectAtIndex:0];
    
}
+(NSString *) selectFromBunkInfoWithCode:(NSString *)code
{
    NSArray * elem = [NSArray arrayWithObjects :@"cabin_name",nil];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"BunkInfo" WithConditions:[NSString stringWithFormat:@"(select airport_code||cabin_code as key,cabin_name from BunkInfo) where key = '%@'",code]];
    if ([array count] == 0) {
        return nil;
    }
    return [[array objectAtIndex : 0] objectAtIndex:0];
}
+(bool)selectFormDirectCityWithFrom:(NSString *)fromCity addArr:(NSString*)arrCity
{
    NSArray * elem = [NSArray arrayWithObjects :@"fromcity_code",@"arrcity_code",nil];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"DirectCity" WithConditions:[NSString stringWithFormat:@" DirectCity where fromcity_code = '%@' and arrcity_code = '%@'",fromCity,arrCity]];
    if ([array count]==0) {
        return NO;
    }
    return YES;
}
+(NSArray *)selectConnectCitysFormDirectCityWithFrom:(NSString *)fromCity addArr:(NSString*)arrCity
{
    NSArray * elem = [NSArray arrayWithObjects :@"distinct A.arrcity_code",nil];
    //select A.arrcity_code from (select fromcity_code,arrcity_code from DirectCity where fromcity_code = 'PEK' ) A ,  (select fromcity_code,arrcity_code from DirectCity where  arrcity_code = 'HAK') B  where A.arrcity_code = B.fromcity_code
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"DirectCity" WithConditions:[NSString stringWithFormat:@" (select fromcity_code,arrcity_code from DirectCity where fromcity_code = '%@' ) A ,  (select fromcity_code,arrcity_code from DirectCity where  arrcity_code = '%@') B  where A.arrcity_code = B.fromcity_code",fromCity,arrCity]];
    return array;
}

+(NSString *)selectAirlineNameFromAirlinesWithCode:(NSString *)code
{
    NSArray * elem = [NSArray arrayWithObjects :@"airline_name",nil];
    NSArray * array = [DataBaseClass selectWithElem:elem WithTablename:@"Airlines" WithConditions:[NSString stringWithFormat:@"Airlines where airline_code = '%@'",code] ];
    if ([array count] == 0) {
        return nil;
    }
    return [[array objectAtIndex : 0] objectAtIndex:0];
}
/*
 +(NSArray *) selectFromFlightquery
 {
 NSArray * elem = [NSArray arrayWithObjects:@"from_city", @"to_city", @"search_time",@"seqid", nil];
 NSString * conditions = @"flightquery order by search_time desc";
 
 NSArray * dataArray = [DataBaseClass selectWithElem:elem WithTablename:@"flightquery" WithConditions:conditions];
 
 return dataArray;
 }
 
 +(void) deleteFlightqueryWithMinseqid:(NSString *)seqid
 {
 NSString * tableName = @"flightquery";
 NSString * conditionSeqid = [NSString stringWithFormat:@"seqid<%@",seqid];
 [DataBaseClass deleteWithTable:tableName WithARecord:conditionSeqid];
 }
 +(void) deleteFlightquery:(NSString *)fromC second:(NSString *)toC
 {
 NSString * tableName = @"flightquery";
 NSString * conditions = [NSString stringWithFormat:@"from_city='%@' and to_city='%@'",fromC,toC];
 [DataBaseClass deleteWithTable:tableName WithARecord:conditions];
 }
 +(NSArray *) selectFromLandingGround
 {
 NSArray * elem = [NSArray arrayWithObjects:@"dptCity", @"arrCity", nil];
 NSString * conditions = @"LandingGround order by seqid desc";
 
 NSArray * dataArray = [DataBaseClass selectWithElem:elem WithTablename:@"LandingGround" WithConditions:conditions];
 
 return dataArray;
 }
 +(NSArray *) selectDptCityFromLandingGround:(NSString * )fromCity add:(NSString *)toCity
 {
 NSArray * elem = [NSArray arrayWithObjects:@"dptCity", nil];
 NSString * conditions = [NSString stringWithFormat:@" LandingGround where dptCity=%@ and arrCity=%@ ",fromCity,toCity];
 
 NSArray * dataArray = [DataBaseClass selectWithElem:elem  WithTablename:@"LandingGround" WithConditions:conditions];
 
 return dataArray;
 
 }
 +(NSArray *) selectFromFlightnumtable
 {
 NSArray * elem = [NSArray arrayWithObjects:@"flight_num", nil];
 NSString * conditions = @"flightnumtable order by seqid desc";
 
 NSArray * dataArray = [DataBaseClass selectWithElem:elem  WithTablename:@"flightnumtable" WithConditions:conditions];
 
 return dataArray;
 
 }
 +(void) insertintoFlightnumtableWithNum:(NSString *)num
 {
 //@"insert or replace into flightnumtable(flight_num) values ('%@');", number
 NSString * tableName = @"flightnumtable";
 NSArray * elem = [NSArray arrayWithObjects:@"flight_num", nil];
 NSArray * dataArray = [NSArray arrayWithObjects:[NSArray arrayWithObjects:num, nil], nil];
 [DataBaseClass insertWithTable:tableName WithElem:elem WithData:dataArray];
 }
 +(NSArray *) selectFromFlightnumtableWithNum:(NSString * )num
 {
 //@"select flight_num from flightnumtable where flight_num='%@';", value
 NSArray * elem = [NSArray arrayWithObjects:@"flight_num", nil];
 NSString * conditions = [NSString stringWithFormat:@" flightnumtable where flight_num=%@",num];
 NSArray * dataArray = [DataBaseClass selectWithElem:elem  WithTablename:@"flightnumtable" WithConditions:conditions];
 return dataArray;
 }
 +(void) deleteFlightnumtable
 {
 [DataBaseClass deleteWithTable:@"flightnumtable"];
 }
 +(void) deleteLandingGround
 {
 [DataBaseClass deleteWithTable:@"LandingGround"];
 }
 +(void) deleteBunkInfo
 {
 [DataBaseClass deleteWithTable:@"bunk_info"];
 }
 +(void) insertintoLogtableWithText:(NSString *)text
 {
 NSString * tableName = @"logtable";
 NSArray * elem = [NSArray arrayWithObjects:@"logString", nil];
 NSArray * dataArray = [NSArray arrayWithObjects:[NSArray arrayWithObjects:text, nil], nil];
 [DataBaseClass insertWithTable:tableName WithElem:elem WithData:dataArray];
 }
 +(NSArray *)selectBunkinfoWithKey:(NSString *)key
 {
 //@"select cabin_name from (select airport_code||cabin_code as key,cabin_name from bunk_info) where key = '%@'",key
 NSArray * elem = [NSArray arrayWithObjects:@"cabin_name", nil];
 NSString * conditions = [NSString stringWithFormat:@" (select airport_code||cabin_code as key,cabin_name from bunk_info) where key = %@",key];
 NSArray * array =  [DataBaseClass selectWithElem:elem  WithTablename:@"bunk_info"  WithConditions:conditions];
 return array;
 }
 +(NSArray *) selectRoutemaptable
 {
 //@"select arrcity from routemaptable where dptcity='0'"
 NSArray * elem = [NSArray arrayWithObjects:@"arrcity", nil];
 NSString * conditions = @" routemaptable where dptcity='0' ";
 NSArray * array =  [DataBaseClass selectWithElem:elem  WithTablename:@"routemaptable"  WithConditions:conditions];
 return array;
 }
 +(void) insertintoRoutemapTableWithArray:(NSArray *)dataArray
 {
 NSString * tableName = @"routemaptable";
 NSArray * elem = [NSArray arrayWithObjects:@"dptcity",@"arrcity", nil];
 [DataBaseClass insertWithTable:tableName WithElem:elem WithData:dataArray];
 }
 +(NSArray *) selectDirectRoute:(NSString *)fromCity second:(NSString *)toCity
 {
 //@"select dptcity from routemaptable where dptcity='%@' and arrcity='%@'", dptCity, arrCity
 
 NSArray * elem = [NSArray arrayWithObjects:@"dptcity", nil];
 NSString * conditions = [NSString stringWithFormat:@" routemaptable where dptcity=%@ and arrcity=%@ ",fromCity,toCity];
 NSArray * array =  [DataBaseClass selectWithElem:elem  WithTablename:@"routemaptable"  WithConditions:conditions];
 return array;
 }
 +(NSArray *) selectTransitRoute:(NSString *)fromCity second:(NSString *)toCity
 {
 //@"select distinct A.arrcity from routemaptable A, routemaptable B where A.dptcity='%@' and B.arrcity='%@' and A.arrcity=B.dptcity", dptCity, arrCity
 
 NSArray * elem = [NSArray arrayWithObjects:@"distinct A.arrcity", nil];
 NSString * conditions = [NSString stringWithFormat:@" routemaptable A, routemaptable B where A.dptcity=%@ and B.arrcity=%@ and A.arrcity=B.dptcity ",fromCity,toCity];
 NSArray * array =  [DataBaseClass selectWithElem:elem  WithTablename:@"routemaptable"  WithConditions:conditions];
 return array;
 }
 +(void) insertintoFlightquery:(NSString *)fromCity add:(NSString *) toCity
 {
 //@"insert or replace into flightquery(from_city, to_city, search_time) values ('%@', '%@', datetime('now'));", fromCity, toCity
 NSString * tableName = @"flightquery";
 NSArray * elem = [NSArray arrayWithObjects:@"from_city",@"to_city",@"search_time", nil];
 NSArray * dataArray = [NSArray arrayWithObjects:[NSArray arrayWithObjects:fromCity,toCity,@"datetime('now')", nil], nil];
 [DataBaseClass insertWithTable:tableName WithElem:elem WithData:dataArray];
 }
 */ 
@end
