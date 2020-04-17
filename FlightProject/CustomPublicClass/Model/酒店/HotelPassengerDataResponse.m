//
//  HotelPassengerDataResponse.m
//  FlightProject
//
//  Created by green kevin on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelPassengerDataResponse.h"

@implementation HotelPassengerDataResponse
@synthesize _hotelPassengerArray,_creditCardArray,_id;

//旅馆入住人列表
+ (NSMutableArray *)checkPersonnelList:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray *autoInfolist = [dic valueForKey:@"personnelList"];
	NSMutableArray *list = [NSMutableArray array];
    if ([autoInfolist isKindOfClass:[NSArray class]]) {
		for (NSDictionary *dicList in autoInfolist) {
			HotelPersonnelInfo *personnelInfo = [[HotelPersonnelInfo alloc] init];
			personnelInfo._id =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"id"]];
			personnelInfo._name =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"name"]];
			
			[list addObject: personnelInfo];
			[personnelInfo release];
		}
	}
    if ([list count] ==0) {
        return nil;
    }
	return list;
	
}

//提交入住人信息
+ (int) addCheckPersonnel:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return 0;
    }
	int ids =  [[NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]]intValue];
	return ids;
}


//信用卡列表
+ (HotelPassengerDataResponse *)creditCardList:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	HotelPassengerDataResponse * hotelPassengerDR = [[[HotelPassengerDataResponse  alloc] init] autorelease];
	
	NSArray *autoInfolist = [dic valueForKey:@"creditCardModel"];
    NSMutableArray *list = [[NSMutableArray alloc] init];
	if ([autoInfolist isKindOfClass:[NSArray class]]) {
		for (NSDictionary *dicList in autoInfolist) {
			HotelCreditCardInfo *creditCardInfo = [[HotelCreditCardInfo alloc] init];
			creditCardInfo._id =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"id"]];
			creditCardInfo._userName =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"userName"]];
			creditCardInfo._idCard =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"idCard"]];
			creditCardInfo._bank =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"bank"]];
			
			creditCardInfo._bankId =  [[NSString stringWithFormat:@"%@",[dicList objectForKey:@"bankId"]] intValue];
			creditCardInfo._bankIdCard =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"bankIdCard"]];
			creditCardInfo._validityDate =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"validityDate"]];
			
			[list addObject: creditCardInfo];
			
			[creditCardInfo release];
		}
	}
	NSLog(@"list %d",list.count);
	
	hotelPassengerDR._creditCardArray=list;
	[list release];
    if ([hotelPassengerDR._creditCardArray count] == 0) {
        hotelPassengerDR._creditCardArray = nil;
    }
	return hotelPassengerDR;
}

//提交信用卡
+ (HotelPassengerDataResponse *) addCreditCard:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	
	HotelPassengerDataResponse * passengerInfo = [[[HotelPassengerDataResponse  alloc] init] autorelease];
        passengerInfo._id =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]];
	return passengerInfo;
}

//编辑信用卡
+ (HotelPassengerDataResponse *) updateCreditCard:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	HotelPassengerDataResponse * passengerInfo = [[[HotelPassengerDataResponse  alloc] init] autorelease];
	
	return passengerInfo;
}

//删除信用卡
+ (HotelPassengerDataResponse *) deleteCreditCard:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	HotelPassengerDataResponse * passengerInfo = [[[HotelPassengerDataResponse  alloc] init] autorelease];
	return passengerInfo;
}

-(void)dealloc
{
	self._id = nil;
	[super dealloc];
}
@end



@implementation HotelPersonnelInfo
@synthesize _id,_name;

-(void)dealloc
{
	self._id = nil;
	self._name = nil;
	[super dealloc];
}
@end

@implementation HotelCreditCardInfo
@synthesize _id,_userName,_idCard,_bank,_bankId,_bankIdCard,_validityDate;

-(void)dealloc
{
	self._id = nil;
	self._userName = nil;
	self._idCard = nil;
	self._bank = nil;
	self._bankId = 0;
	self._bankIdCard = nil;
	self._validityDate = nil;
	[super dealloc];
}
@end






