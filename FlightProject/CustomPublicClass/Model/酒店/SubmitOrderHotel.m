//
//  SubmitOrderHotel.m
//  FlightProject
//
//  Created by longcd on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SubmitOrderHotel.h"

@implementation SubmitOrderHotel
@synthesize _userId,_roomCount,_guestType,_guestNames,_connectorMobile,_arriveTimeLate,_arriveTimeEarly,_roomTypeId,_hotelId,_checkInDate,_checkOutDate,_totalPrice,_username,_idCard,_bankIdCard,_bankId,_validityDate,_vouchMoney,_cVV2Code,_vouchSetType,_ratePlanId,_breakfast,_userType,_lcdRate,_lcdValue,_lcdCurrency,_lcdActivityId;
-(void)dealloc
{
    self._userId = nil;
    self._roomCount = nil;
    self._guestType = nil;
    self._guestNames = nil;
    self._connectorMobile = nil;
    self._arriveTimeLate = nil;
    self._arriveTimeEarly = nil;
    self._roomTypeId = nil;
    self._hotelId = nil;
    self._checkInDate = nil;
    self._checkOutDate = nil;
    self._totalPrice = nil;
    self._username = nil;
    self._bankIdCard = nil;
    self._bankId = nil;
    self._vouchMoney = nil;
    self._cVV2Code = nil;
    self._vouchSetType = nil;
    self._validityDate = nil;
    self._idCard = nil;
    self._ratePlanId = nil;
    self._breakfast = nil;
    self._userType = nil;
    self._lcdRate = nil;
    self._lcdValue = nil;
    self._lcdCurrency = nil;
    self._lcdActivityId = nil;
    [super dealloc];
}
@end
