//
//  PassengerInfoDataResponse.m
//  FlightProject
//
//  Created by green kevin on 12-9-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PassengerInfoDataResponse.h"

@implementation PassengerInfoDataResponse
@synthesize _passengerInfoArray,_id,_maximum,_pickPersonInfoArray,_total;

+ (NSMutableArray *)queryPassengerInfoList:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	//PassengerInfoDataResponse * passengerInfo = [[[PassengerInfoDataResponse  alloc] init] autorelease];
	NSArray *passengerInfolist =[dic valueForKey:@"passengerList"];
	NSMutableArray *list = [NSMutableArray array];
    if ([passengerInfolist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dicList in passengerInfolist) {
            PassengerInfoItem *info = [[[PassengerInfoItem alloc] init]autorelease];
            info._id =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"id"]];
            info._name = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"name"]];
            info._type =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"type"]];
            info._certType =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"certType"]];
            info._certNum =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"certNum"]];
            info._birthday = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"birthday"]];
            [list addObject: info];
        }
    }
	
	//passengerInfo._passengerInfoArray=list;
	if ([list count]==0) {
        return nil;
    }
	return list;
	
}

- (void)queryPickPersonInfoList:(NSDictionary *)dic
{
	
	self._maximum = [NSString stringWithFormat:@"%@", [dic objectForKey:@"maximum"]];
	self._total = [NSString stringWithFormat:@"%@", [dic objectForKey:@"total"]];
	NSArray *passengerInfolist =[dic valueForKey:@"pickList"];
	NSMutableArray *list = [NSMutableArray array];
	if ([passengerInfolist isKindOfClass:[NSArray class]]) {
		for (NSDictionary *dicList in passengerInfolist) {
			PickPersonInfoItem *info = [[[PickPersonInfoItem alloc] init]autorelease];
			info._id =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"id"]];
			info._name = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"name"]];
			info._phone =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"phone"]];
			info._selected = @"0";
			[list addObject: info];
		}
	}

	self._pickPersonInfoArray = list;	
}

//提交乘机人信息
+ (int) addPassenger:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return 0;
    }
//	PassengerInfoDataResponse * passengerInfo = [[[PassengerInfoDataResponse  alloc] init] autorelease];
        int ids =  [[NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]]intValue ];
//	passengerInfo._id =ids;

	
	return ids;
}


//提交接机人信息
+ (int) addPickPerson:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
		return 0;
	}
	//	PassengerInfoDataResponse * passengerInfo = [[[PassengerInfoDataResponse  alloc] init] autorelease];
        int ids =  [[NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]]intValue ];
	//	passengerInfo._id =ids;
	
	
	return ids;
}

-(void)dealloc
{
	self._id = 0;
	self._maximum = nil;
	self._total = nil;
	[super dealloc];
}

@end

@implementation PassengerInfoItem
@synthesize _id,_name,_type,_certType,_certNum,_birthday;
-(void)dealloc
{
	self._id = nil;
	self._name = nil;
	self._type = nil;
	self._certType = nil;
	self._certNum = nil;
	self._birthday = nil;
	
	[super dealloc];
}

@end

@implementation PickPersonInfoItem
@synthesize _id,_name,_phone,_selected;
-(void)dealloc
{
	self._id = nil;
	self._name = nil;
	self._phone = nil;
	self._selected = nil;
	[super dealloc];
}

@end