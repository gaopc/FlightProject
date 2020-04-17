//
//  MapDataResponse.m
//  FlightProject
//
//  Created by admin on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MapDataResponse.h"

//@implementation MapDataCityInfoResponse
//@synthesize _longitude, _latitude, _address;
//
//- (void)dealloc
//{
//    self._longitude = nil;
//    self._latitude = nil;
//    self._address = nil;
//    [super dealloc];
//}
//
//+(MapDataCityInfoResponse *)cityContent:(NSDictionary *)dic
//{
//    MapDataCityInfoResponse * mapInfo = [[MapDataCityInfoResponse alloc] init];
//    mapInfo._longitude = [NSString stringWithFormat:@"%@", [dic objectForKey:@"longitude"]];
//    mapInfo._latitude = [NSString stringWithFormat:@"%@", [dic objectForKey:@"_latitude"]];
//    mapInfo._address = [NSString stringWithFormat:@"%@", [dic objectForKey:@"_address"]];
//    
//    return [mapInfo autorelease];
//}
//
//+(NSArray *)cityInfo:(NSDictionary *)dic
//{
//    NSArray * array = [dic objectForKey:@"terminalList"];
//    if ([array count]==0) {
//        return nil;
//    }
//    NSMutableArray *marray = [NSMutableArray array];
//    for (NSDictionary * elem in array) {
//        [marray addObject:[self cityContent:elem]];
//    }
//    return marray;
//}
//@end
//
//@implementation MapDataProvinceListResponse
//@synthesize _name, _citys;
//
//- (void)dealloc
//{
//    self._name = nil;
//    self._citys = nil;
//    [super dealloc];
//}
//
//+(MapDataProvinceListResponse *)cityContent:(NSDictionary *)dic
//{
//    MapDataProvinceListResponse * mapInfo = [[MapDataProvinceListResponse alloc] init];
//    mapInfo._name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
//    mapInfo._citys = [MapDataCityListResponse citysList:dic];
//    
//    return [mapInfo autorelease];
//}
//
//+(NSArray *)provincesList:(NSDictionary *)dic
//{
//    NSArray * array = [dic objectForKey:@"provinces"];
//    if ([array count]==0) {
//        return nil;
//    }
//    NSMutableArray *marray = [NSMutableArray array];
//    for (NSDictionary * elem in array) {
//        [marray addObject:[self cityContent:elem]];
//    }
//    return marray;
//}
//@end
//
////@implementation MapDataCityListResponse
////@synthesize _cityCode, _cityName;
////
////- (void)dealloc
////{
////    self._cityCode = nil;
////    self._cityName = nil;
////    [super dealloc];
////}
////
////+(MapDataCityListResponse *)cityContent:(NSDictionary *)dic
////{
////    MapDataCityListResponse * mapInfo = [[MapDataCityListResponse alloc] init];
////    mapInfo._cityCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"cityCode"]];
////    mapInfo._cityName = [NSString stringWithFormat:@"%@", [dic objectForKey:@"cityName"]];
////    
////    return [mapInfo autorelease];
////}
////
////+(NSArray *)citysList:(NSDictionary *)dic
////{
////    NSArray * array = [dic objectForKey:@"citys"];
////    if ([array count]==0) {
////        return nil;
////    }
////    NSMutableArray *marray = [NSMutableArray array];
////    for (NSDictionary * elem in array) {
////        [marray addObject:[self cityContent:elem]];
////    }
////    return marray;
////}
////@end


@implementation TerminalCity

@synthesize _cityName,_cityCode;
-(void)dealloc
{
    self._cityCode = nil;
    self._cityName = nil;
    [super dealloc];
}
+(TerminalCity *)TerminalCity:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    TerminalCity * city = [[TerminalCity alloc] init];
    city._cityName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cityName"]];
    city._cityCode = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cityCode"]];
    return [city autorelease];
}
@end

@implementation TerminalProvince

@synthesize _citys,_provinceName;
-(void)dealloc
{
    self._provinceName = nil;
    self._citys = nil;
    [super dealloc];
}
+(NSArray *) TerminalProvince:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray * array = [dic objectForKey:@"provinces"];
    NSMutableArray * mArray = nil;
    TerminalProvince * beijingProvince = nil;
    if ([array isKindOfClass:[NSArray class]] && [array count] > 0) {
        mArray = [NSMutableArray array];
        for (NSDictionary * elem in array) {
            TerminalProvince * province = [[TerminalProvince alloc]init];
            province._provinceName = [NSString stringWithFormat:@"%@",[elem objectForKey:@"name"]];
            province._citys = [NSMutableArray array];
            NSArray * citys = [elem objectForKey:@"citys"];
            if ([citys isKindOfClass:[NSArray class]]) {
                for (NSDictionary * cityElem in citys) {
                    [province._citys addObject:[TerminalCity TerminalCity:cityElem]];
                }
            }
            
            if ([province._provinceName isEqualToString:@"北京"]) {
                beijingProvince = [province retain];
            }
            else{
                [mArray addObject:province];
                [province release];
            }
        }
        
        if (beijingProvince) {
            [mArray insertObject:beijingProvince atIndex:0];
            [beijingProvince release];
        }
    }
    return mArray;
}
@end

@implementation TerminalInfo

@synthesize _address,_latitude,_longitude;
-(void)dealloc
{
    self._address = nil;
    self._latitude = nil;
    self._longitude = nil;
    [super dealloc];
}
+(NSArray *)TerminalInfo:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSMutableArray * mArray = nil;
    NSArray * array = [dic objectForKey:@"terminalList"];

    if ([array isKindOfClass:[NSArray class]] && [array count] > 0 ) {
        mArray = [NSMutableArray array];
        for (NSDictionary * elem in array) {
            TerminalInfo * info = [[TerminalInfo alloc] init];
            info._address =  [NSString stringWithFormat:@"%@",[elem objectForKey:@"address"]];
            info._latitude =  [NSString stringWithFormat:@"%@",[elem objectForKey:@"latitude"]];
            info._longitude =  [NSString stringWithFormat:@"%@",[elem objectForKey:@"longitude"]];
            [mArray addObject:info];
            [info release];
        }
    }
    return mArray;
}
@end


