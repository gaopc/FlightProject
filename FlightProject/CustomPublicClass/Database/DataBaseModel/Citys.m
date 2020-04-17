//
//  Citys.m
//  FlightProject
//
//  Created by longcd on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Citys.h"

@implementation Citys

@synthesize _city_code,_city_name,_ename,_first_letter,_jian_pin,_flag;
-(void)dealloc
{
    self._city_code = nil;
    self._city_name = nil;
    self._ename = nil;
    self._first_letter = nil;
    self._jian_pin = nil;
    self._flag = nil;
    [super dealloc];
}
+(Citys *) cityFromElem:(NSArray *)array
{
    Citys * city = [[Citys alloc] init];
    city._city_code = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    city._city_name = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    city._ename = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    city._first_letter = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
    city._jian_pin = [NSString stringWithFormat:@"%@",[array objectAtIndex:4]];
    city._flag = [NSString stringWithFormat:@"%@",[array objectAtIndex:5]];
    return [city autorelease];
}
+(NSDictionary *) AirportCitysDicFromArray:(NSArray *)array  hotName:(NSString *)hotName
{
    if ([array count] == 0) {
        return nil;
    }
    NSMutableDictionary * mDic = [[NSMutableDictionary alloc] init];
    for (Citys * city in array) 
    { 
        if ([[mDic allKeys] indexOfObject:city._first_letter] == NSNotFound) {
            [mDic setValue:[NSMutableArray arrayWithObjects:city, nil] forKey:city._first_letter];
        }
        else {
            NSMutableArray * valueArray = [mDic objectForKey:city._first_letter];
            [valueArray addObject:city];
        }
        if ([city._flag intValue] >0) {
            NSMutableArray * valueArray = [mDic objectForKey:hotName];
            if (valueArray) {
                [valueArray addObject:city];
            }
            else {
                [mDic setValue:[NSMutableArray arrayWithObjects:city, nil] forKey:hotName];
            }
        }
    }
    return [mDic autorelease];
}
+(Citys*) citysWithNameCode:(NSString*)name code:(NSString*)code
{
    Citys * city = [[Citys alloc] init];
    city._city_code = code;
    city._city_name = name;
    return [city autorelease];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@",self._city_code,self._city_name];
}
@end

// 酒店城市
@implementation HotelCitys
//@synthesize _city_code,_city_name,_first_letter,_flag,_ename,_jian_pin;
//-(void)dealloc
//{
//    self._first_letter = nil;
//    self._city_name = nil;
//    self._city_code = nil;
//    self._flag = nil;
//    self._ename = nil;
//    self._jian_pin = nil;
//    [super dealloc];
//}
+(HotelCitys *) cityFromElem:(NSArray *)array
{
    HotelCitys * city = [[HotelCitys alloc] init];
    city._city_code = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    city._city_name = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    city._first_letter = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    city._flag = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
    city._jian_pin = [NSString stringWithFormat:@"%@",[array objectAtIndex:4]];
    city._ename = [NSString stringWithFormat:@"%@",[array objectAtIndex:5]];
    return [city autorelease];
}

@end

// 租车城市

@implementation CarCitys

//@synthesize _city_name,_first_letter,_city_code,_flag,_ename,_jian_pin;
//-(void)dealloc
//{
//    self._city_code = nil;
//    self._city_name = nil;
//    self._first_letter = nil;
//    self._flag = nil;
//    self._ename = nil;
//    self._jian_pin = nil;
//    [super dealloc];
//}
+(CarCitys *) cityFromElem:(NSArray *)array
{
    CarCitys * city = [[CarCitys alloc] init];
    city._city_code = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    city._city_name = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    city._first_letter = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    city._flag = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
    city._jian_pin = [NSString stringWithFormat:@"%@",[array objectAtIndex:4]];
    city._ename = [NSString stringWithFormat:@"%@",[array objectAtIndex:5]];
    return [city autorelease];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@",self._city_code,self._city_name];
}
@end

@implementation AirportList
//@synthesize _airport_code,_first_letter,_airport_name,_flag,_ename,_jian_pin;
//-(void)dealloc
//{
//    self._airport_code = nil;
//    self._airport_name = nil;
//    self._first_letter = nil;
//    self._flag = nil;
//    self._ename = nil;
//    self._jian_pin = nil;
//    [super dealloc];
//}
+(AirportList *) airportFromElem:(NSArray *)array
{
    AirportList * airport = [[AirportList alloc] init];
    airport._city_code = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    airport._city_name = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    airport._first_letter = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    airport._flag = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
    airport._jian_pin = [NSString stringWithFormat:@"%@",[array objectAtIndex:4]];
    airport._ename = [NSString stringWithFormat:@"%@",[array objectAtIndex:5]];
    return [airport autorelease];
}
@end

@implementation TrainCitysList
//@synthesize _airport_code,_first_letter,_airport_name,_flag,_ename,_jian_pin;
//-(void)dealloc
//{
//    self._airport_code = nil;
//    self._airport_name = nil;
//    self._first_letter = nil;
//    self._flag = nil;
//    self._ename = nil;
//    self._jian_pin = nil;
//    [super dealloc];
//}
+(TrainCitysList *) airportFromElem:(NSArray *)array
{
    TrainCitysList * airport = [[TrainCitysList alloc] init];
    airport._city_code = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    airport._city_name = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    airport._first_letter = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    airport._flag = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
    airport._jian_pin = [NSString stringWithFormat:@"%@",[array objectAtIndex:4]];
    airport._ename = [NSString stringWithFormat:@"%@",[array objectAtIndex:5]];
    return [airport autorelease];
}
@end

