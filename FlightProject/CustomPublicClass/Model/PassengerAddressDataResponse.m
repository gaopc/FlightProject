//
//  PassengerAddressDataResponse.m
//  FlightProject
//
//  Created by lidong  cui on 12-10-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PassengerAddressDataResponse.h"

@implementation PassengerAddressDataResponse
@synthesize _passengerAddressArray,_id;
//邮寄地址列表
+ (PassengerAddressDataResponse *)queryPassengerAddressList:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	PassengerAddressDataResponse * passengerAddress = [[[PassengerAddressDataResponse  alloc] init] autorelease];

    int ids = [[NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]]intValue];
    NSArray *passengerInfolist = [dic valueForKey:@"userAddress"];
	NSMutableArray *list = [[NSMutableArray alloc] init];
    if ([passengerInfolist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dicList in passengerInfolist) {
            
            PassengerAddressItem *info = [[[PassengerAddressItem alloc] init]autorelease];
            info._id =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"id"]];
            info._name =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"name"]];
            info._postCode =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"postCode"]];
            info._postAddress = [NSString stringWithFormat:@"%@",[dicList objectForKey:@"postalAddress"]];
            info._mobile =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"mobile"]];
            
            id provinceName = [dicList objectForKey:@"provinceName"];
            if ([provinceName isKindOfClass:[NSString class]]) {
                
                info._province = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"provinceName"]];
                info._city = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"cityName"]];
                info._county = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"areaName"]];
            }
            else {
                info._province = @"";
                info._city = @"";
                info._county = @"";
            }
            
            
            [list addObject: info];
        }
    }
	
    passengerAddress._id =ids;
	passengerAddress._passengerAddressArray=list;
	[list release];
    if ([passengerAddress._passengerAddressArray count]==0) {
        passengerAddress._passengerAddressArray = nil;
    }
	return passengerAddress;
    
}

//添加邮寄地址
+ (int) addPassengerAddress:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return 0;
    }
	//PassengerAddressDataResponse * passengerAddress = [[[PassengerAddressDataResponse  alloc] init] autorelease];

        int ids =  [[NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]]intValue];
	//passengerAddress._id =ids;

	
	return ids;
}

//删除邮寄地址
+ (void) deletePassengerAddress:(NSDictionary *)dic
{
	
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
}

-(void)dealloc
{
    
	self._id = 0;
	[super dealloc];
}

@end

@implementation PassengerAddressItem
@synthesize _id,_name,_postCode,_postAddress,_mobile,_selected;
@synthesize _city, _county, _province;
-(void)dealloc
{
	self._id = nil;
	self._name = nil;
	self._postCode = nil;
	self._postAddress = nil;
	self._mobile = nil;
    self._selected = nil;
    self._province = nil;
    self._city = nil;
    self._county = nil;
	[super dealloc];
}


@end