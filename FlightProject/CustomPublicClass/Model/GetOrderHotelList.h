//
//  GetOrderHotelList.h
//  FlightProject
//
//  Created by 月 小 on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelModel : NSObject
@property(nonatomic,retain)NSString* orderNo;
@property(nonatomic,retain)NSString* scheduleDate;
@property(nonatomic,retain)NSString* totelMoney;
@property(nonatomic,retain)NSString* checkInDate;
@property(nonatomic,retain)NSString* checkOutDate;
@property(nonatomic,retain)NSString* hotelName;
@property(nonatomic,retain)NSString* hotelAddress;
@property(nonatomic,retain)NSString* roomTypeName;
@property(nonatomic,retain)NSString* stateCode;
@property(nonatomic,retain)NSString* peopleName;
@property(nonatomic,retain)NSString* lcdCurrency;
@property(nonatomic,retain)NSString* breakfast;
@property(nonatomic,retain)NSString* stateString;

+ (HotelModel*)GetOrderHotelDetail:(NSDictionary*)dic;
@end


@interface GetOrderHotelList : NSObject
@property(nonatomic,retain)NSMutableArray *hotelList;
@property(nonatomic,retain)NSString *totalPage;

+(GetOrderHotelList*)GetOrderHotelList:(NSDictionary*)dic;
@end
