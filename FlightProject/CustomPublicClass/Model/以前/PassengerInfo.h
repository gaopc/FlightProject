//
//  PassengerInfo.h
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PassengerInfomation.h"
@interface PassengerInfo : PassengerInfomation

@property (nonatomic, retain) NSString *airlineMileageCard;
@property (nonatomic, retain) NSString *psgMileageCard;
@property (nonatomic, retain) NSString *totalMoney;
@property (nonatomic, retain) NSString *fuelTax;
@property (nonatomic, retain) NSString *airportTax;
@property (nonatomic, retain) NSString *insuranceCount;
@property (nonatomic, retain) NSString *insuranceMoney;
@property (nonatomic, retain) NSString *returnTotalMoney;
@property (nonatomic, retain) NSString *returnFuelTax;
@property (nonatomic, retain) NSString *returnAirportTax;


@end
