//
//  SearchFlightsTaxResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

// 	费税查询接口

#import <Foundation/Foundation.h>

@interface SearchFlightsTaxRequest : RootRequestModel 

@property(nonatomic, retain) NSString *departure;
@property(nonatomic, retain) NSString *arrival;
@property(nonatomic, retain) NSString *departureDate;
@property(nonatomic, retain) NSString *psgType;
@property(nonatomic, retain) NSString *airline;
@property(nonatomic, retain) NSString *planeType;

@end

@interface FlightsTax : NSObject
// 燃油税  机场费  币种
@property (nonatomic,retain)NSString * fuelTax;
@property (nonatomic,retain)NSString * airportTax;
@property(nonatomic,retain) NSString * currency;
@end

@interface SearchFlightsTaxResponse : NSObject

+(FlightsTax *) searchFlightsTaxResponseWithArray:(NSArray * ) resultArray;
@end
