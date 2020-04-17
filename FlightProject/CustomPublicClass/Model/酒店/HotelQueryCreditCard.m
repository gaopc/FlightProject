//
//  HotelQueryCreditCard.m
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelQueryCreditCard.h"

@implementation HotelQueryCreditCard
@synthesize hotelId,roomTypeId,checkInDate,checkOutDate,arrivePeriod,count,rotalPrice,totalLcdFee,minCheckinRooms,firstDayPrice,isArriveTimeVouch,isRoomCountVouch,arriveStartTime,arriveEndTime,roomCount,vouchMoneyType,ratePlanId,lcdActivityId;

- (void)dealloc
{
    self.hotelId = nil;
    self.roomTypeId = nil;
    self.checkInDate = nil;
    self.checkOutDate = nil;
    self.arrivePeriod = nil;
    self.count = nil;
    self.rotalPrice = nil;
    self.totalLcdFee = nil;
    self.minCheckinRooms = nil;
    self.firstDayPrice = nil;
    self.isArriveTimeVouch = nil;
    self.isRoomCountVouch = nil;
    self.arriveStartTime = nil;
    self.arriveEndTime = nil;
    self.roomCount = nil;
    self.vouchMoneyType = nil;
    self.ratePlanId = nil;
    self.lcdActivityId = nil;
    [super dealloc];
}
@end


@implementation OnHotelQueryCreditCard
@synthesize vouchSetType,money,descrip,totalPrice,lcdCurrency;

- (void)dealloc
{
    self.vouchSetType = nil;
    self.money = nil;
    self.descrip = nil;
    self.totalPrice = nil;
    self.lcdCurrency = nil;
    [super dealloc];
}

+(OnHotelQueryCreditCard*)GetOnHotelQueryCreditCard:(NSDictionary*)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    OnHotelQueryCreditCard *aModel = [[OnHotelQueryCreditCard alloc] init];
    
    ([dic objectForKey:@"vouchSetType"]==NULL)?(aModel.vouchSetType=@""):( aModel.vouchSetType = [NSString stringWithFormat:@"%@",[dic objectForKey:@"vouchSetType"]]);
    ([dic objectForKey:@"money"]==NULL)?(aModel.money=@""):(aModel.money = [NSString stringWithFormat:@"%@",[dic objectForKey:@"money"]]);
    ([dic objectForKey:@"descrip"]==NULL)?(aModel.descrip=@""):( aModel.descrip = [NSString stringWithFormat:@"%@",[dic objectForKey:@"descrip"]]);
    ([dic objectForKey:@"totalPrice"] == NULL)?(aModel.totalPrice = @""):(aModel.totalPrice = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalPrice"]]);
    ([dic objectForKey:@"lcdCurrency"]==NULL)?(aModel.lcdCurrency=@""):(aModel.lcdCurrency = [NSString stringWithFormat:@"%@",[dic objectForKey:@"lcdCurrency"]]);
   
    return [aModel autorelease];
}
@end