//
//  HotelQueryCreditCard.h
//  FlightProject
//
//  Created by 月 小 on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelQueryCreditCard : NSObject
@property(nonatomic,retain)NSString *hotelId;
@property(nonatomic,retain)NSString *roomTypeId;
@property(nonatomic,retain)NSString *checkInDate;
@property(nonatomic,retain)NSString *checkOutDate;
@property(nonatomic,retain)NSString *arrivePeriod;
@property(nonatomic,retain)NSString *count;
@property(nonatomic,retain)NSString *rotalPrice;
@property(nonatomic,retain)NSString *totalLcdFee;
@property(nonatomic,retain)NSString *minCheckinRooms;
@property(nonatomic,retain)NSString *firstDayPrice;
@property(nonatomic,retain)NSString *isArriveTimeVouch;
@property(nonatomic,retain)NSString *isRoomCountVouch;
@property(nonatomic,retain)NSString *arriveEndTime;
@property(nonatomic,retain)NSString *arriveStartTime;
@property(nonatomic,retain)NSString *roomCount;
@property(nonatomic,retain)NSString *vouchMoneyType;
@property(nonatomic,retain)NSString *ratePlanId;
@property(nonatomic,retain)NSString *lcdActivityId;
@end


@interface OnHotelQueryCreditCard : NSObject
@property(nonatomic,retain)NSString *vouchSetType;
@property(nonatomic,retain)NSString *money;
@property(nonatomic,retain)NSString *descrip;
@property(nonatomic,retain)NSString *totalPrice;
@property(nonatomic,retain)NSString *lcdCurrency;

+(OnHotelQueryCreditCard*)GetOnHotelQueryCreditCard:(NSDictionary*)dic;
@end
