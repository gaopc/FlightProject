//
//  QueryCarService.m
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QueryCarService.h"

@implementation QueryCarService
@synthesize _modeCode;
-(void)dealloc
{
    self._modeCode = nil;
    [super dealloc];
}
@end

@implementation CarService

@synthesize _serviceId,_serviceName,_servicePrice,_chooseType;
-(void)dealloc
{
    self._serviceId = nil;
    self._serviceName = nil;
    self._servicePrice = nil;
    self._chooseType = nil;
    [super dealloc];
}
+(CarService *)CarService:(NSDictionary *)resultDic
{
    if (![resultDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    CarService * service = [[CarService alloc] init];
    service._serviceId = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"serviceId"]];
    service._serviceName = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"serviceName"]];
    service._servicePrice = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"servicePrice"]];
    service._chooseType = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"chooseType"]];
    return [service autorelease];
}
@end

@implementation CarActvity
@synthesize _actvityId,_actvityDesc,_selectlimit;
-(void)dealloc
{
    self._actvityId = nil;
    self._actvityDesc = nil;
    self._selectlimit = nil;
    [super dealloc];
}
+(CarActvity *)CarActvity:(NSDictionary *)resultDic
{
    if (![resultDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    CarActvity * activity = [[CarActvity alloc] init];
    activity._actvityId = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"actvityId"]];
    activity._actvityDesc = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"actvityDesc"]];
    activity._selectlimit = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"selectlimit"]];
    return [activity autorelease];
}
@end

@implementation QueryCarServiceResponse

@synthesize _carService,_actvityList;
-(void)dealloc
{
    self._carService = nil;
    self._actvityList = nil;
    [super dealloc];
}
+(QueryCarServiceResponse *)QueryCarServiceResponse:(NSDictionary *)resultDic
{
    if (![resultDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    QueryCarServiceResponse * instance = [[QueryCarServiceResponse alloc] init];
    NSMutableArray * mServiesList = [NSMutableArray array];
    NSMutableArray * mActvityList = [NSMutableArray array];
    NSArray * serviesList = [resultDic objectForKey:@"carService"];
    NSArray * actvityList = [resultDic objectForKey:@"actvityList"];
    
    if (![serviesList isKindOfClass:[NSArray class]]) {
        serviesList = [NSArray array];
    }
    if (![actvityList isKindOfClass:[NSArray class]]) {
        actvityList = [NSArray array];
    }
    for (NSDictionary * elem in serviesList) {
        [mServiesList addObject:[CarService CarService:elem]];
    }
    for (NSDictionary * elem in actvityList) {
        [mActvityList addObject:[CarActvity CarActvity:elem]];
    }
    instance._actvityList = mActvityList;
    instance._carService = mServiesList;
    if ([instance._actvityList count] == 0) {
        instance._actvityList = nil;
    }
    if ([instance._carService count] == 0) {
        instance._carService = nil;
    }
    return [instance autorelease];
}
@end
