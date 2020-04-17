//
//  MemberOrderDetailResponse.m
//  FlightProject
//
//  Created by admin on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MemberOrderDetailResponse.h"
#import "PassengerAddressDataResponse.h"

@implementation MemberOrderDetailResponse
@synthesize _ticketPrice, _isBuyInsurance, _getItineraryType, _postCode, _postAddress, _autoPrint, _isAcceptService, _returnLcdCurrency, _flightType, _state, _telephone, _payment, _availableLcdCurrency, _orderId;
@synthesize _passengersInfo, _flightInfo, _ticketInfo;
@synthesize _postAddressInfo;
@synthesize _paymentInfo;
@synthesize _pickInfo;

- (void)dealloc
{
    self._orderId = nil;
    self._payment = nil;
    self._availableLcdCurrency = nil;
    self._ticketPrice = nil;
    self._isBuyInsurance = nil;
    self._getItineraryType = nil;
    self._postCode = nil;
    self._postAddress = nil;
    self._autoPrint = nil;
    self._isAcceptService = nil;
    self._returnLcdCurrency = nil;
    self._flightType = nil;
    self._state = nil;
    self._flightInfo = nil;
    self._ticketInfo = nil;
    self._telephone = nil;
    self._passengersInfo = nil;
    self._postAddressInfo = nil;
    self._paymentInfo = nil;
    self._pickInfo = nil;
    [super dealloc];
}


+ (MemberOrderDetailResponse *)setOrderDetail:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    MemberOrderDetailResponse * orderDetail = [[MemberOrderDetailResponse alloc] init];
    orderDetail._ticketPrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"ticketPrice"]];
    orderDetail._isBuyInsurance = [NSString stringWithFormat:@"%@", [dic objectForKey:@"isBuyInsurance"]];
    orderDetail._telephone = [NSString stringWithFormat:@"%@", [dic objectForKey:@"telephone"]];
    orderDetail._getItineraryType = [NSString stringWithFormat:@"%@", [dic objectForKey:@"getItineraryType"]];
    orderDetail._postCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"postCode"]];
    orderDetail._postAddress = [NSString stringWithFormat:@"%@", [dic objectForKey:@"postalAddress"]];
    
    PassengerAddressItem *addressItem = [[PassengerAddressItem alloc] init];
    addressItem._postCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"postCode"]];
    addressItem._postAddress = [NSString stringWithFormat:@"%@", [dic objectForKey:@"postalAddress"]];
    addressItem._id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"postalId"]];
    orderDetail._postAddressInfo = addressItem;
    [addressItem release];
    
//    orderDetail._postAddressInfo = [[PassengerAddressItem alloc] init];
//    orderDetail._postAddressInfo._postCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"postCode"]];
//    orderDetail._postAddressInfo._postAddress = [NSString stringWithFormat:@"%@", [dic objectForKey:@"postalAddress"]];
    
    orderDetail._isAcceptService = [NSString stringWithFormat:@"%@", [dic objectForKey:@"isAcceptService"]];
    orderDetail._returnLcdCurrency = [NSString stringWithFormat:@"%@", [dic objectForKey:@"returnLcdCurrency"]];
    orderDetail._flightType = [NSString stringWithFormat:@"%@", [dic objectForKey:@"flightType"]];
    orderDetail._state = [NSString stringWithFormat:@"%@", [dic objectForKey:@"state"]];
    orderDetail._autoPrint = [NSString stringWithFormat:@"%@", [dic objectForKey:@"autoPrint"]];
    orderDetail._availableLcdCurrency = [NSString stringWithFormat:@"%@", [dic objectForKey:@"availableLcdCurrency"]];
    orderDetail._payment = [NSString stringWithFormat:@"%@", [dic objectForKey:@"payment"]];
    orderDetail._paymentInfo = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"paymentInfo"] isKindOfClass:[NSNull class]]?@"":[dic objectForKey:@"paymentInfo"]];

    orderDetail._flightInfo = [NSMutableArray array];
    orderDetail._passengersInfo = [NSMutableArray array];
    orderDetail._ticketInfo = [NSMutableArray array];
    orderDetail._pickInfo = [NSMutableArray array];
    
    NSArray * flightArray = [dic objectForKey:@"flightInfo"];
    if (![flightArray isKindOfClass:[NSArray class]]) {
        orderDetail._flightInfo = nil;
    }
    else {
        for (NSDictionary * elem in flightArray) {
            [orderDetail._flightInfo addObject:[MemberOrderDetailFlightInfoResponse setOrderDetailFlight:elem]];
        }
    }
    
    NSArray * passengersArray = [dic objectForKey:@"passengersInfo"];
    if (![passengersArray isKindOfClass:[NSArray class]]) {
        orderDetail._passengersInfo = nil;
    }
    else {
        for (NSDictionary * elem in passengersArray) {
            [orderDetail._passengersInfo addObject:[MemberOrderDetailPassengersInfoResponse setOrderDetailPassenger:elem]];
        }
    }
    
    NSArray * ticketArray = [dic objectForKey:@"ticketNumber"];
    if (![ticketArray isKindOfClass:[NSArray class]]) {
        orderDetail._ticketInfo = nil;
    }
    else {
        for (NSDictionary * elem in ticketArray) {
            [orderDetail._ticketInfo addObject:[MemberOrderDetailTicketNumberResponse setOrderDetailTicke:elem]];
        }
    }
    
    NSArray * pickArray = [dic objectForKey:@"pickList"];
    if (![pickArray isKindOfClass:[NSArray class]]) {
        orderDetail._pickInfo = nil;
    }
    else {
        for (NSDictionary * elem in pickArray) {
            [orderDetail._pickInfo addObject:[MemberOrderDetailFlightPickResponse setOrderDetailTickePick:elem]];
        }
    }
    
    if ( [orderDetail._flightInfo count] == 0) {
        orderDetail._flightInfo = nil;
    }
    if ( [orderDetail._passengersInfo count] == 0) {
        orderDetail._passengersInfo = nil;
    }
    if ( [orderDetail._ticketInfo count] == 0) {
        orderDetail._ticketInfo = nil;
    }
    if ( [orderDetail._pickInfo count] == 0) {
        orderDetail._pickInfo = nil;
    }
    return [orderDetail autorelease];
}
@end


@implementation MemberOrderDetailPassengersInfoResponse
@synthesize _userId, _name, _certType, _type, _certNum, _birthday;

- (void)dealloc
{
    self._userId = nil;
    self._name = nil;
    self._certType = nil;
    self._type = nil;
    self._certNum = nil;
    self._birthday = nil;
    [super dealloc];
}

+ (MemberOrderDetailPassengersInfoResponse *)setOrderDetailPassenger:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    MemberOrderDetailPassengersInfoResponse * passengersInfo = [[MemberOrderDetailPassengersInfoResponse alloc] init];
    passengersInfo._userId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"userId"]];
    passengersInfo._name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
    passengersInfo._certType = [NSString stringWithFormat:@"%@", [dic objectForKey:@"certType"]];
    passengersInfo._type = [NSString stringWithFormat:@"%@", [dic objectForKey:@"type"]];
    passengersInfo._certNum = [NSString stringWithFormat:@"%@", [dic objectForKey:@"certNum"]];
    passengersInfo._birthday = [NSString stringWithFormat:@"%@", [dic objectForKey:@"birthday"]];
    
    return [passengersInfo autorelease];
}
@end


@implementation MemberOrderDetailTicketNumberResponse
@synthesize _name, _number, _state, _type, _certNum, _birthday, _certType;

- (void)dealloc
{
    self._name = nil;
    self._number = nil;
    self._state = nil;
    self._certType = nil;
    self._certNum = nil;
    self._type = nil;
    self._birthday = nil;
    [super dealloc];
}

+(MemberOrderDetailTicketNumberResponse *)setOrderDetailTicke:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    MemberOrderDetailTicketNumberResponse * ticketNumber = [[MemberOrderDetailTicketNumberResponse alloc] init];
    ticketNumber._name =        [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
    ticketNumber._number =      [[NSString stringWithFormat:@"%@", [dic objectForKey:@"number"]] componentsSeparatedByString:@"&"];
    ticketNumber._state =       [[NSString stringWithFormat:@"%@", [dic objectForKey:@"state"]] componentsSeparatedByString:@"&"];
    ticketNumber._certType =    [NSString stringWithFormat:@"%@", [dic objectForKey:@"certType"]];
    ticketNumber._certNum =     [NSString stringWithFormat:@"%@", [dic objectForKey:@"certNum"]];
    ticketNumber._type =        [NSString stringWithFormat:@"%@", [dic objectForKey:@"type"]];
    ticketNumber._birthday =    [NSString stringWithFormat:@"%@", [dic objectForKey:@"birthday"]];
    
    return [ticketNumber autorelease];
}
@end


@implementation MemberOrderDetailFlightInfoResponse
@synthesize _departure, _arrival, _departureDate, _flightNo, _airline, _planeType, _cabinCode, _cabinType, _startTime, _endTime, _startAirport, _startTerminal, _endAirport, _endTerminal, _rules;
@synthesize  _adultInfo, _childInfo;
@synthesize _arrivalDate;

- (void)dealloc
{
    self._departure = nil;
    self._arrival = nil;
    self._departureDate = nil;
    self._flightNo = nil;
    self._airline = nil;
    self._planeType = nil;
    self._cabinCode = nil;
    self._cabinType = nil;
    self._startTime = nil;
    self._endTime = nil;
    self._startAirport = nil;
    self._startTerminal = nil;
    self._endAirport = nil;
    self._endTerminal = nil;
   self._rules = nil;
    self._adultInfo = nil;
    self._childInfo = nil;
    self._arrivalDate = nil;
    [super dealloc];
}

+ (MemberOrderDetailFlightInfoResponse *)setOrderDetailFlight:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    MemberOrderDetailFlightInfoResponse * flightInfo = [[MemberOrderDetailFlightInfoResponse alloc] init];
    flightInfo._departure = [NSString stringWithFormat:@"%@", [dic objectForKey:@"departure"]];
    flightInfo._arrival = [NSString stringWithFormat:@"%@", [dic objectForKey:@"arrival"]];
    flightInfo._departureDate = [NSString stringWithFormat:@"%@", [dic objectForKey:@"departureDate"]];
    flightInfo._arrivalDate = [NSString stringWithFormat:@"%@", [dic objectForKey:@"arrivalDate"]];
    flightInfo._flightNo = [NSString stringWithFormat:@"%@", [dic objectForKey:@"flightNo"]];
    
    flightInfo._airline = [NSString stringWithFormat:@"%@", [dic objectForKey:@"airline"]];
    flightInfo._planeType = [NSString stringWithFormat:@"%@", [dic objectForKey:@"planeType"]];
    flightInfo._cabinCode = [NSString stringWithFormat:@"%@", [dic objectForKey:@"cabinCode"]];
    flightInfo._cabinType = [NSString stringWithFormat:@"%@", [dic objectForKey:@"cabinType"]];
    
    flightInfo._startTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"startTime"]];
    flightInfo._endTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"endTime"]];
    flightInfo._startAirport = [NSString stringWithFormat:@"%@", [dic objectForKey:@"startAirport"]];
    flightInfo._startTerminal = [NSString stringWithFormat:@"%@", [dic objectForKey:@"startTerminal"]];
    
    flightInfo._endAirport = [NSString stringWithFormat:@"%@", [dic objectForKey:@"endAirport"]];
    flightInfo._endTerminal = [NSString stringWithFormat:@"%@", [dic objectForKey:@"endTerminal"]];
    flightInfo._rules = [NSString stringWithFormat:@"%@", [dic objectForKey:@"rules"]];
    
    if (![[dic objectForKey:@"adult"] isKindOfClass:[NSNull class]])
        flightInfo._adultInfo = [MemberOrderDetailFlightAdultResponse setOrderDetailTickeAdult:[dic objectForKey:@"adult"]];
    if (![[dic objectForKey:@"child"] isKindOfClass:[NSNull class]])
        flightInfo._childInfo = [MemberOrderDetailFlightChildResponse setOrderDetailTickeChild:[dic objectForKey:@"child"]];

    return [flightInfo autorelease];
}
@end


@implementation MemberOrderDetailFlightAdultResponse
@synthesize _ticketPrice, _fuelTax ,_airportTax;

- (void)dealloc
{
    self._ticketPrice = nil;
    self._fuelTax = nil;
    self._airportTax = nil;
    [super dealloc];
}

+ (MemberOrderDetailFlightAdultResponse *)setOrderDetailTickeAdult:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    MemberOrderDetailFlightAdultResponse * flightAdultInfo = [[MemberOrderDetailFlightAdultResponse alloc] init];
    flightAdultInfo._ticketPrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"ticketPrice"]];
    flightAdultInfo._fuelTax = [NSString stringWithFormat:@"%@", [dic objectForKey:@"fuelTax"]];
    flightAdultInfo._airportTax = [NSString stringWithFormat:@"%@", [dic objectForKey:@"airportTax"]];
    
    return [flightAdultInfo autorelease];
}
@end


@implementation MemberOrderDetailFlightChildResponse
@synthesize _ticketPrice, _fuelTax ,_airportTax;

- (void)dealloc
{
    self._ticketPrice = nil;
    self._fuelTax = nil;
    self._airportTax = nil;
    [super dealloc];
}

+ (MemberOrderDetailFlightChildResponse *)setOrderDetailTickeChild:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    MemberOrderDetailFlightChildResponse * flightChildInfo = [[MemberOrderDetailFlightChildResponse alloc] init];
    flightChildInfo._ticketPrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"ticketPrice"]];
    flightChildInfo._fuelTax = [NSString stringWithFormat:@"%@", [dic objectForKey:@"fuelTax"]];
    flightChildInfo._airportTax = [NSString stringWithFormat:@"%@", [dic objectForKey:@"airportTax"]];
    
    return [flightChildInfo autorelease];
}
@end


@implementation MemberOrderDetailFlightPickResponse
@synthesize _pickName, _pickPhone, _pickType;

- (void)dealloc
{
    self._pickName = nil;
    self._pickPhone = nil;
    self._pickType = nil;
    [super dealloc];
}

+ (MemberOrderDetailFlightPickResponse *)setOrderDetailTickePick:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    MemberOrderDetailFlightPickResponse * flightPickInfo = [[MemberOrderDetailFlightPickResponse alloc] init];
    flightPickInfo._pickName = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
    flightPickInfo._pickPhone = [NSString stringWithFormat:@"%@", [dic objectForKey:@"phone"]];
    flightPickInfo._pickType = [NSString stringWithFormat:@"%@", [dic objectForKey:@"type"]];
    
    return [flightPickInfo autorelease];
}
@end