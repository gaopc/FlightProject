//
//  SearchFlightsBriefInfoResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootRequestModel.h"
#import "CabinItem.h"
#import "DataClass.h"
#import "GetWeatherInfoResponse.h"
#import "SearchFlightsTaxResponse.h"

@interface SearchFlightsBriefInfoRequest :  RootRequestModel
@property(nonatomic, retain) NSString *flightType;
@property(nonatomic, retain) NSString *dptCity;
@property(nonatomic, retain) NSString *dstCity;
@property(nonatomic, retain) NSString *departureDate;
@property(nonatomic, retain) NSString *returnDate;
@property(nonatomic, retain) NSString *airLine;
@property(nonatomic, retain) NSString *isDirect;
@end

@interface FlightsBriefInfo : NSObject
@property(nonatomic, retain) NSString *airLine;
@property(nonatomic, retain) NSString *flightNo;
@property(nonatomic, retain) NSString *startAirPort;
@property(nonatomic, retain) NSString *departureTime;
@property(nonatomic, retain) NSString *endAirPort;
@property(nonatomic, retain) NSString *arrivalTime;
@property(nonatomic, retain) NSString *stopNo;
@property(nonatomic, retain) NSString *stopCity;
@property(nonatomic, retain) NSString *isFood;
@property(nonatomic, retain) NSString *isCodeShare;
@property(nonatomic, retain) NSString *carrier;
@property(nonatomic, retain) NSString *planeType;
@property(nonatomic, retain) NSString *fullPrice;
@property(nonatomic, retain) NSMutableArray *cabinItems;
@property(nonatomic, retain) NSString *flightDelay;
@property(nonatomic, retain) NSString *SflightTerminal;  // 出发机场航站楼
@property(nonatomic, retain) NSString *EflightTerminal;  // 到达机场航站楼
@property(nonatomic, retain) CabinItem * cabin;

@property(nonatomic, retain) FlightsTax * adultTax;
@property(nonatomic, retain) FlightsTax * childTax;
@end

@interface SearchFlightsBriefInfoResponse : NSObject

@property(nonatomic, retain) WeatherInfo *startWeather;
@property(nonatomic, retain) WeatherInfo *arrivaWeather;
@property(nonatomic, retain) NSArray *flightsBriefInfo;

+(SearchFlightsBriefInfoResponse *)searchFlightsBriefInfoResponseWithArray:(NSArray *)resultArray;

+(FlightsBriefInfo *)searchFlightsBriefInfoWithBriefInfo : (FlightsBriefInfo *)briefInfo; // 方便给cell赋值
+(CabinItem *)cabinItemWithCabin:(CabinItem *)cabin addAirportCode:(NSString *)airport_code;// 方便给cell赋值

@end
