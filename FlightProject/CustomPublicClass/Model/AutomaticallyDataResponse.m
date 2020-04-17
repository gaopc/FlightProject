//
//  AutoDepreciateDataResponse.m
//  FlightProject
//
//  Created by 崔立东 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  自动降价数据响应
//

#import "AutomaticallyDataResponse.h"

@implementation AutomaticallyDataResponse
@synthesize _cumulationPrice,_autoMaticallyArray,_automaticallyInfo,_pushDetailArray;
//自劢降价列表查询
+ (AutomaticallyDataResponse *)queryAutomaticallyDroppedList:(NSDictionary *)dic
{

	if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	AutomaticallyDataResponse * automatically = [[[AutomaticallyDataResponse  alloc] init] autorelease];
    int price= [[dic objectForKey:@"price"] intValue];
    NSArray *autoInfolist = [dic valueForKey:@"info"];
	NSMutableArray *list = [[NSMutableArray alloc] init];
    if ([autoInfolist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dicList in autoInfolist) {
            AutomaticallyInfo *info = [[[AutomaticallyInfo alloc] init]autorelease];
            info._ticketNo = [NSString stringWithFormat:@"%@",[dicList objectForKey:@"ticketNo"]];
            info._flightNo = [NSString stringWithFormat:@"%@",[dicList objectForKey:@"flightNo"]];
            info._startDate =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"startDate"]];
            info._departure =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"departure"]];
            info._arrival =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"arrival"]];
            info._pushTime =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"pushTime"]];
            info._createDate =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"createDate"]];
            [list addObject: info];
        }
    }
    if ([list count] == 0) {
        [list release];
        list = nil;
        automatically._autoMaticallyArray=list;
    }
    else
    {
        automatically._autoMaticallyArray=list;
        [list release];
    }
	automatically._cumulationPrice = price;
	return automatically;
}

//自动降价推荐内容
+ (AutomaticallyDataResponse *)queryAutomaticallyDroppedDetail:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	AutomaticallyDataResponse * automatically = [[[AutomaticallyDataResponse  alloc] init] autorelease];	
	AutomaticallyInfo *info = [[[AutomaticallyInfo alloc] init]autorelease];
	info._airline =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"airline"]];
	info._planeType =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"planeType"]];
	info._cabin =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"cabin"]];
	info._cabinCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"cabinCode"]];
	info._startTime =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"startTime"]];
	info._endTime =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"endTime"]];
	info._startAirport = [NSString stringWithFormat:@"%@", [dic objectForKey:@"startAirport"]];
	
	info._startTerminal =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"startTerminal"]];
	info._endAirport =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"endAirport"]];
	info._endTime =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"endTime"]];
	info._endTerminal =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"endTerminal"]];
	info._ticketPrice =   [NSString stringWithFormat:@"%@", [dic objectForKey:@"ticketPrice"]];
	info._discount =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"discount"]];
	info._type =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"type"]];

	info._pushCabinCode =   [NSString stringWithFormat:@"%@", [dic objectForKey:@"pushCabinCode"]];
	info._pushPrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"pushPrice"]]; 
	info._pushDiscount =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"pushDiscount"]]; 
	info._pushCabin =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"pushCabin"]]; 
	
	info._savingPrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"savingPrice"]]; 
	
	NSArray *autoInfolist = [dic valueForKey:@"pushDetail"];
	NSMutableArray *list = [[NSMutableArray alloc] init];
    
	if ([autoInfolist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dicList in autoInfolist) {
            PushDetailInfo *push = [[[PushDetailInfo alloc] init]autorelease];
            push._date =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"date"]]; 
            push._price =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"price"]];
            push._discount = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"discount"]]; 
            push._savingPrice = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"savingPrice"]]; 
            [list addObject: push];
        }
	}


	automatically._automaticallyInfo = info;
	automatically._pushDetailArray = list;
	[list release];
	return automatically;
}

@end


@implementation AutomaticallyInfo

@synthesize _ticketNo,_flightNo,_startDate,_departure,_arrival,_pushTime,_createDate;
@synthesize _airline,_planeType,_cabin,_cabinCode,_startTime,_endTime,_startAirport,_startTerminal,_endAirport,_endTerminal,_ticketPrice,_discount,_pushDiscount,_type,_pushPrice,_savingPrice,_pushCabin,_pushCabinCode;
-(void)dealloc
{
	self._ticketNo = nil;
	self._flightNo = nil;
	self._startDate = nil;
	self._departure = nil;
	self._arrival = nil;
	self._pushTime = nil;
	self._createDate = nil;
	
	self._airline = nil;
	self._planeType = nil;
	self._cabin = nil;
	self._cabinCode = nil;
	self._startTime = nil;
	self._endTime = nil;
	self._startAirport = nil;
	self._startTerminal = nil;
	self._endAirport = nil;
	self._endTerminal = nil;
	self._ticketPrice = nil;
	self._discount = nil;
	self._pushDiscount = nil;
	self._pushCabin = nil;
	self._pushCabinCode = nil;
	self._savingPrice = nil;
	
	self._type = nil;
	
	[super dealloc];
}
@end

@implementation PushDetailInfo

@synthesize _date,_price,_discount,_savingPrice;
-(void)dealloc
{
	self._date = nil;
	self._price = nil;
	self._discount = nil;
	self._savingPrice = nil;
	[super dealloc];
}

@end
