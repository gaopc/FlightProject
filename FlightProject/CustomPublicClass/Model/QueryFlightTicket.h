//
//  QueryFlightTicket.h
//  FlightProject
//
//  Created by longcd on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransitCity : NSObject
@property (nonatomic,retain)NSString * _code;
@property (nonatomic,retain)NSString * _name;
@end

@interface CabinInfo : NSObject
@property (nonatomic,retain)NSString * _cabinCode;
@property (nonatomic,retain)NSString * _baseCabin;
@property (nonatomic,retain)NSString * _cabinType;
@property (nonatomic,retain)NSString * _cabinTypeName;
@property (nonatomic,retain)NSString * _ticketPrice;
@property (nonatomic,retain)NSString * _ticketCount;
@property (nonatomic,retain)NSString * _discount;
@property (nonatomic,retain)NSString * _returnLcdFee;
@property (nonatomic,retain)NSString * _specialFlightNum;

@property (nonatomic,retain)NSString * _dropFee; //
@property (nonatomic,retain)NSString * _returnLcdFeeRatio; //

@property (nonatomic,retain) NSString * _rule;
@property (nonatomic,retain) NSString * _source;
@end

@interface FlightInfo : NSObject
@property (nonatomic,retain)NSString * _startDate;
@property (nonatomic,retain)NSString * _flightNo;
@property (nonatomic,retain)NSString * _airline;
@property (nonatomic,retain)NSString * _planeType;
@property (nonatomic,retain)NSString * _planeTypeName; //
@property (nonatomic,retain)NSString * _ticketCount;
@property (nonatomic,retain)NSString * _ticketPrice;
@property (nonatomic,retain)NSString * _discount;
@property (nonatomic,retain)NSString * _endTime;
@property (nonatomic,retain)NSString * _startAirport;
@property (nonatomic,retain)NSString * _startTerminal;
@property (nonatomic,retain)NSString * _endAirport;
@property (nonatomic,retain)NSString * _endTerminal;
@property (nonatomic,retain)NSString * _stopNum;
@property (nonatomic,retain)NSString * _returnLcdFee;
@property (nonatomic,retain)NSString * _dropFee; //
@property (nonatomic,retain)NSString * _soldout; //
@property (nonatomic,retain)NSArray * _cabinInfo;

@property (nonatomic,assign)BOOL  _isdrop; //

@property (nonatomic,retain) CabinInfo * _selectedCabin;

@property (nonatomic,retain)NSString * _airportTaxForAdult;
@property (nonatomic,retain)NSString * _airportTaxForChild;
@property (nonatomic,retain)NSString * _fuelTaxForAdult;
@property (nonatomic,retain)NSString * _fuelTaxForChild;
@property (nonatomic,retain)NSArray * _stopCityInfo;

@property (nonatomic,retain) NSString * _startAirportCode;
@property (nonatomic,retain) NSString * _endAirportCode;
@property (nonatomic,retain) NSMutableArray * _cabinCountZeroArray;

@property (nonatomic,retain)NSString * _suggestionMsg;


@end

@interface QueryFlightTicket : NSObject // 机票查询
@property (nonatomic,retain)NSString * _isDirect;
@property (nonatomic,retain) NSString * _departureCity;
@property (nonatomic,retain) NSString * _arrivalCity;
@property (nonatomic,retain)NSString * _departureWeather;
@property (nonatomic,retain)NSString * _arrivalWeather;
@property (nonatomic,retain)NSArray * _transitCity;
@property (nonatomic,retain)NSArray * _firstFlightInfo;
@property (nonatomic,retain)NSArray * _secondFlightInfo;

+(QueryFlightTicket *)QueryFlightTicket:(NSDictionary *)dic;

@end
