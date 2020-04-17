//
//  GetOrderCarInformation.h
//  FlightProject
//
//  Created by 月 小 on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetOrderCarInformation : NSObject
@property(nonatomic,retain)NSString *_orderNumber;
@property(nonatomic,retain)NSString *_orderStatus;
@property(nonatomic,retain)NSString *_orderType;
@property(nonatomic,retain)NSString *_takeShop;
@property(nonatomic,retain)NSString *_returnShop;
@property(nonatomic,retain)NSString *_bussinessTime;
@property(nonatomic,retain)NSString *_typeName;
@property(nonatomic,retain)NSString *_typeDesc;
@property(nonatomic,retain)NSString *_service;
@property(nonatomic,retain)NSString *_preAuthorization;
@property(nonatomic,retain)NSString *_rent;
@property(nonatomic,retain)NSString *_insuranceAmount;
@property(nonatomic,retain)NSArray *_selectedService;
@property(nonatomic,retain)NSString *_totalCarRentMoney;
@property(nonatomic,retain)NSString *_lcdFee;
@property(nonatomic,retain)NSString *_serviceFee;
@property(nonatomic,retain)NSString *_fromDate;
@property(nonatomic,retain)NSString *_toDate;
@property(nonatomic,retain)NSString *_submitDate;
@property(nonatomic,retain)NSString *_name;
@property(nonatomic,retain)NSString *_identityNumber;
@property(nonatomic,retain)NSString *_mobileNumber;

+(GetOrderCarInformation*)GetOrderCarInformation:(NSDictionary*)dic;
@end
