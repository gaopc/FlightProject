//
//  MemberOrderDetailResponse.h
//  FlightProject
//
//  Created by admin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MemberOrderDetailFlightAdultResponse;
@class MemberOrderDetailFlightChildResponse;
@class PassengerAddressItem;

@interface MemberOrderDetailResponse : NSObject
@property (nonatomic, retain) NSString *_orderId;
@property (nonatomic, retain) NSString *_ticketPrice;
@property (nonatomic, retain) NSString *_isBuyInsurance;
@property (nonatomic, retain) NSString *_telephone;
@property (nonatomic, retain) NSString *_getItineraryType;
@property (nonatomic, retain) NSString *_postCode;
@property (nonatomic, retain) NSString *_postAddress;
@property (nonatomic, retain) PassengerAddressItem *_postAddressInfo;
@property (nonatomic, retain) NSString *_autoPrint;
@property (nonatomic, retain) NSString *_isAcceptService;
@property (nonatomic, retain) NSString *_returnLcdCurrency;
@property (nonatomic, retain) NSString *_flightType;
@property (nonatomic, retain) NSString *_state;
@property (nonatomic, retain) NSString *_payment;
@property (nonatomic, retain) NSString *_availableLcdCurrency;
@property (nonatomic, retain) NSMutableArray *_flightInfo;
@property (nonatomic, retain) NSMutableArray *_ticketInfo;
@property (nonatomic, retain) NSMutableArray *_passengersInfo;
@property (nonatomic, retain) NSString *_paymentInfo;
@property (nonatomic, retain) NSMutableArray *_pickInfo;

+ (MemberOrderDetailResponse *)setOrderDetail:(NSDictionary *)dic;
@end


@interface MemberOrderDetailPassengersInfoResponse : NSObject
@property (nonatomic, retain) NSString *_userId;
@property (nonatomic, retain) NSString *_name;
@property (nonatomic, retain) NSString *_certType;
@property (nonatomic, retain) NSString *_type;
@property (nonatomic, retain) NSString *_certNum;
@property (nonatomic, retain) NSString *_birthday;

+ (MemberOrderDetailPassengersInfoResponse *)setOrderDetailPassenger:(NSDictionary *)dic;
@end


@interface MemberOrderDetailTicketNumberResponse : NSObject
@property (nonatomic, retain) NSString *_name;
@property (nonatomic, retain) NSArray  *_number;
@property (nonatomic, retain) NSArray  *_state;
@property (nonatomic, retain) NSString *_certType;
@property (nonatomic, retain) NSString *_type;
@property (nonatomic, retain) NSString *_certNum;
@property (nonatomic, retain) NSString *_birthday;

+(MemberOrderDetailTicketNumberResponse *)setOrderDetailTicke:(NSDictionary *)dic;
@end


@interface MemberOrderDetailFlightInfoResponse : NSObject
@property (nonatomic, retain) NSString *_departure;
@property (nonatomic, retain) NSString *_arrival;
@property (nonatomic, retain) NSString *_departureDate;
@property (nonatomic, retain) NSString *_arrivalDate;
@property (nonatomic, retain) NSString *_flightNo;
@property (nonatomic, retain) NSString *_airline;
@property (nonatomic, retain) NSString *_planeType;
@property (nonatomic, retain) NSString *_cabinCode;
@property (nonatomic, retain) NSString *_cabinType;
@property (nonatomic, retain) NSString *_startTime;
@property (nonatomic, retain) NSString *_endTime;
@property (nonatomic, retain) NSString *_startAirport;
@property (nonatomic, retain) NSString *_startTerminal;
@property (nonatomic, retain) NSString *_endAirport;
@property (nonatomic, retain) NSString *_endTerminal;
@property (nonatomic, retain) NSString *_rules;

@property (nonatomic, retain) MemberOrderDetailFlightAdultResponse *_adultInfo;
@property (nonatomic, retain) MemberOrderDetailFlightChildResponse *_childInfo;

+ (MemberOrderDetailFlightInfoResponse *)setOrderDetailFlight:(NSDictionary *)dic;
@end


@interface MemberOrderDetailFlightAdultResponse : NSObject
@property (nonatomic, retain) NSString *_ticketPrice;
@property (nonatomic, retain) NSString *_airportTax;
@property (nonatomic, retain) NSString *_fuelTax;

+ (MemberOrderDetailFlightAdultResponse *)setOrderDetailTickeAdult:(NSDictionary *)dic;
@end


@interface MemberOrderDetailFlightChildResponse : NSObject
@property (nonatomic, retain) NSString *_ticketPrice;
@property (nonatomic, retain) NSString *_airportTax;
@property (nonatomic, retain) NSString *_fuelTax;

+ (MemberOrderDetailFlightChildResponse *)setOrderDetailTickeChild:(NSDictionary *)dic;
@end

@interface MemberOrderDetailFlightPickResponse : NSObject
@property (nonatomic, retain) NSString *_pickName;
@property (nonatomic, retain) NSString *_pickPhone;
@property (nonatomic, retain) NSString *_pickType;

+ (MemberOrderDetailFlightPickResponse *)setOrderDetailTickePick:(NSDictionary *)dic;
@end