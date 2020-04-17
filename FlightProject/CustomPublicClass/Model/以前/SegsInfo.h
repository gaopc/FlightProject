//
//  SegsInfo.h
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
// 航段信息
@interface SegsInfo : NSObject
@property (nonatomic, retain) NSString *departure;
@property (nonatomic, retain) NSString *arrival;
@property (nonatomic, retain) NSString *departureDate;
@property (nonatomic, retain) NSString *cabin;
@property (nonatomic, retain) NSString *baseCabin;
@property (nonatomic, retain) NSString *airLine;
@property (nonatomic, retain) NSString *flightNo;
@property (nonatomic, retain) NSString *specialFlightNum;
@property (nonatomic, retain) NSString *arriveDate;
@property (nonatomic, retain) NSString *cabinDiscount;
@property (nonatomic, retain) NSString *planeType;

@end
