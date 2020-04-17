//
//  QueryFlightTicket.m
//  FlightProject
//
//  Created by longcd on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QueryFlightTicket.h"

@implementation TransitCity

@synthesize _code,_name;
-(void)dealloc
{
    self._code = nil;
    self._name = nil;
    [super dealloc];
}

@end

@implementation CabinInfo

@synthesize _cabinCode,_baseCabin,_cabinType,_cabinTypeName,_ticketPrice,_ticketCount,_discount,_returnLcdFee,_specialFlightNum;
@synthesize  _rule;
@synthesize _dropFee,_returnLcdFeeRatio;
@synthesize _source;
-(void)dealloc
{
    self._cabinCode = nil;
    self._baseCabin = nil;
    self._cabinType = nil;
    self._cabinTypeName = nil;
    self._ticketPrice = nil;
    self._ticketCount = nil;
    self._discount = nil;
    self._returnLcdFee = nil;
    self._specialFlightNum = nil;
    self._rule = nil;
    
    self._dropFee = nil;
    self._returnLcdFeeRatio = nil; //_returnLcdFeeRatio
    self._source = nil;
    [super dealloc];
}

@end

@implementation FlightInfo

@synthesize _startDate,_flightNo,_airline,_planeType,_ticketCount,_ticketPrice,_discount,_endTime,_startAirport,_startTerminal,_endAirport,_endTerminal,_stopNum,_returnLcdFee,_cabinInfo;
@synthesize _selectedCabin;
@synthesize _airportTaxForAdult,_airportTaxForChild,_fuelTaxForAdult,_fuelTaxForChild,_stopCityInfo;
@synthesize _endAirportCode,_startAirportCode;

@synthesize _dropFee,_soldout,_planeTypeName;

@synthesize _isdrop,_cabinCountZeroArray;

@synthesize _suggestionMsg;

-(void)dealloc
{
    self._startDate = nil;
    self._flightNo = nil;
    self._airline = nil;
    self._planeType = nil;
    self._ticketCount = nil;
    self._ticketPrice = nil;
    self._discount = nil;
    self._endTime = nil;
    self._startAirport = nil;
    self._startTerminal = nil;
    self._endAirport = nil;
    self._endTerminal = nil;
    self._stopNum = nil;
    self._returnLcdFee = nil;
    self._cabinInfo = nil;
    
    self._selectedCabin = nil;
    
    self._airportTaxForAdult = nil;
    self._airportTaxForChild = nil;
    self._fuelTaxForAdult = nil;
    self._fuelTaxForChild = nil;
    self._stopCityInfo = nil;
    
    self._endAirportCode = nil;
    self._startAirportCode = nil;
    
    self._dropFee = nil;
    self._soldout = nil;
    self._planeTypeName = nil;
    self._isdrop = FALSE;
    self._cabinCountZeroArray = nil;
    
    self._suggestionMsg = nil;
    [super dealloc];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"price:%@",self._ticketPrice];
}

@end

@implementation QueryFlightTicket
@synthesize _isDirect,_departureCity,_arrivalCity,_departureWeather,_arrivalWeather,_transitCity,_firstFlightInfo,_secondFlightInfo;
-(void)dealloc
{
    self._isDirect = nil;
    self._departureCity = nil;
    self._arrivalCity = nil;
    self._departureWeather = nil;
    self._arrivalWeather = nil;
    self._transitCity = nil;
    self._firstFlightInfo = nil;
    self._secondFlightInfo = nil;
    [super dealloc];
}

//static NSInteger sortTicketArrayByPriceAesc(id item1, id item2, void *context){//升序
//    
//    FlightInfo *info1 = item1;
//    FlightInfo *info2 = item2;
//    int v1 = [info1._ticketPrice intValue];
//    int v2 = [info2._ticketPrice intValue];
//    
//	if (v1 < v2)
//        return NSOrderedAscending;//降序
//    else if (v1 >v2)
//        return NSOrderedDescending;//升序
//    else
//        return NSOrderedSame;
//    
//}

static NSInteger sortTicketArrayByPriceDesc(id item1, id item2, void *context){//降序
    
    FlightInfo *info1 = item1;
    FlightInfo *info2 = item2;
    int v1 = [info1._ticketPrice intValue];
    int v2 = [info2._ticketPrice intValue];
    
	if (v1 > v2)
        return NSOrderedAscending;//降序
    else if (v1 <v2)
        return NSOrderedDescending;//升序
    else
        return NSOrderedSame;
    
}


+(QueryFlightTicket *)QueryFlightTicket:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    QueryFlightTicket * queryTicket = [[QueryFlightTicket  alloc] init];
    queryTicket._isDirect = [dic objectForKey:@"isDirect"];
    queryTicket._departureCity =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"departureCity"]];
    queryTicket._arrivalCity =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"arrivalCity"]];
    queryTicket._departureWeather = [NSString stringWithFormat:@"%@",[dic objectForKey:@"departureWeather"]];
    queryTicket._arrivalWeather = [NSString stringWithFormat:@"%@",[dic objectForKey:@"arrivalWeather"]];
    if ([queryTicket._isDirect isKindOfClass:[NSNull class]]) {
        [queryTicket release];
        return nil;
    }
    if (![queryTicket._isDirect  boolValue]  && ![[dic objectForKey:@"transitCity"]  isKindOfClass:[NSNull class]]) {
        NSMutableArray * mArray = [NSMutableArray array];
        NSArray *temp = [dic objectForKey:@"transitCity"];
        if ([temp isKindOfClass:[NSArray class]]) {
            for (NSDictionary * elem in temp) {
                TransitCity * city = [[TransitCity alloc] init];
                city._code = [NSString stringWithFormat:@"%@",[elem objectForKey:@"code"]];
                city._name = [NSString stringWithFormat:@"%@",[elem objectForKey:@"name"]];
                [mArray addObject:city];
                [city release];
            }
        }
        
        queryTicket._transitCity = mArray;
        if ([queryTicket._transitCity count] == 0) {
            queryTicket._transitCity = nil;
        }
        queryTicket._firstFlightInfo = nil;
        queryTicket._secondFlightInfo = nil;
    }
    else {
        queryTicket._transitCity = nil;
        NSMutableArray * firstArray = [NSMutableArray array];
        NSMutableArray * secondArray = [NSMutableArray array];
        NSArray * firstFlightInfo = nil;
        if (![[dic objectForKey:@"firstFlightInfo"] isKindOfClass:[NSNull class]]) {
            firstFlightInfo = [dic objectForKey:@"firstFlightInfo"];
        }
        if ([firstFlightInfo isKindOfClass:[NSArray class]]) {
            for (NSDictionary * elem in firstFlightInfo) {
                FlightInfo * flightInfo = [[FlightInfo alloc] init];
                flightInfo._startDate =[NSString stringWithFormat:@"%@", [elem objectForKey:@"startDate"]];
                flightInfo._flightNo = [NSString stringWithFormat:@"%@",[elem objectForKey:@"flightNo"]];
                flightInfo._airline = [NSString stringWithFormat:@"%@",[elem objectForKey:@"airline"]];
                flightInfo._planeType =[NSString stringWithFormat:@"%@", [elem objectForKey:@"planeType"]];
                flightInfo._ticketCount =[NSString stringWithFormat:@"%@",[elem objectForKey:@"ticketCount"]] ;
                
                flightInfo._discount = [NSString stringWithFormat:@"%@",[elem objectForKey:@"discount"]];
                flightInfo._endTime = [NSString stringWithFormat:@"%@",[elem objectForKey:@"endTime"]];
                flightInfo._startAirport =[NSString stringWithFormat:@"%@", [elem objectForKey:@"startAirport"]];
                flightInfo._startTerminal =[NSString stringWithFormat:@"%@", [elem objectForKey:@"startTerminal"]];
                flightInfo._endAirport = [NSString stringWithFormat:@"%@",[elem objectForKey:@"endAirport"]];
                flightInfo._endTerminal = [NSString stringWithFormat:@"%@",[elem objectForKey:@"endTerminal"]];
                flightInfo._stopNum = [NSString stringWithFormat:@"%@", [elem objectForKey:@"stopNum"]];
                flightInfo._returnLcdFee =  [NSString stringWithFormat:@"%@", [elem objectForKey:@"returnLcdFee"]];
                flightInfo._startAirportCode = [NSString stringWithFormat:@"%@", [elem objectForKey:@"startAirportCode"]];
                flightInfo._endAirportCode = [NSString stringWithFormat:@"%@", [elem objectForKey:@"endAirportCode"]];
                
                flightInfo._planeTypeName =  [NSString stringWithFormat:@"%@", [elem objectForKey:@"planeTypeName"]];
                flightInfo._dropFee =  [NSString stringWithFormat:@"%@", [elem objectForKey:@"dropFee"]];
                flightInfo._ticketPrice = [NSString stringWithFormat:@"%d", [[NSString stringWithFormat:@"%@", [elem objectForKey:@"ticketPrice"]] intValue] - [flightInfo._dropFee intValue]];
                flightInfo._soldout =  [NSString stringWithFormat:@"%@", [elem objectForKey:@"soldout"]];
                flightInfo._airportTaxForAdult = [NSString stringWithFormat:@"%@",[elem objectForKey:@"airportTax"]];
                flightInfo._fuelTaxForAdult = [NSString stringWithFormat:@"%@",[elem objectForKey:@"fuelTax"]];
                
                if ([flightInfo._dropFee intValue]>0) {
                    flightInfo._isdrop = TRUE;
                }
                else{
                    flightInfo._isdrop = FALSE;
                }
                
                flightInfo._cabinCountZeroArray = [NSMutableArray array];
                NSMutableArray * mArray = [NSMutableArray array];
//                CabinInfo * Fcabin = nil;
                NSArray *tmp = [elem objectForKey:@"cabinInfo"];
                if ([tmp isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * elemsub in tmp) {
                        NSString * ticketCount = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"ticketCount"]] ;
                        
                        CabinInfo * cabinInfo = [[CabinInfo alloc] init];
                        cabinInfo._cabinCode = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"cabinCode"]];
                        cabinInfo._baseCabin =[NSString stringWithFormat:@"%@", [elemsub objectForKey:@"baseCabin"]];
                        cabinInfo._cabinType = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"cabinType"]] ;
                        cabinInfo._cabinTypeName = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"cabinTypeName"]];
                        cabinInfo._ticketPrice = [NSString stringWithFormat:@"%d", [[NSString stringWithFormat:@"%@", [elemsub objectForKey:@"ticketPrice"]] intValue]];
                        
                        cabinInfo._ticketCount = ticketCount;
                        
                        cabinInfo._discount = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"discount"]];
                        cabinInfo._returnLcdFee =[NSString stringWithFormat:@"%@",[elemsub objectForKey:@"returnLcdFee"]] ;
                        cabinInfo._specialFlightNum = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"specialFlightNum"]];
                        
                        cabinInfo._dropFee = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"dropFee"]];
                        if ([cabinInfo._dropFee intValue]>0) {
                            flightInfo._isdrop = TRUE;
                        }
                        cabinInfo._returnLcdFeeRatio = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"returnLcdFeeRatio"]];
                        cabinInfo._source = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"source"]];
                        
                        cabinInfo._ticketPrice = [NSString stringWithFormat:@"%d", [[NSString stringWithFormat:@"%@", [elemsub objectForKey:@"ticketPrice"]] intValue] - [cabinInfo._dropFee intValue]];
                        
                        if ([ticketCount isEqualToString:@"0"]) {
                            [flightInfo._cabinCountZeroArray addObject:cabinInfo];
                        }
                        else {
                             [mArray addObject:cabinInfo];
//                            if ([cabinInfo._cabinCode isEqualToString:@"F"])
//                            {
//                                Fcabin = [cabinInfo retain];
//                            }
//                            else{
//                                [mArray addObject:cabinInfo];
//                            }
                        }
                        [cabinInfo release];
                    }
                }
                
                flightInfo._cabinInfo = mArray;
                if ([flightInfo._cabinInfo count] == 0) {
                    flightInfo._cabinInfo = nil;
                }
                NSMutableArray * sortedArray = [NSMutableArray array];
                [sortedArray addObjectsFromArray:[mArray sortedArrayUsingFunction:sortTicketArrayByPriceDesc context:NULL]] ;
//                if (Fcabin) {
//                    [sortedArray insertObject:Fcabin atIndex:0];
//                    [Fcabin release];
//                }
                flightInfo._cabinInfo = sortedArray;
                if ([flightInfo._cabinInfo count] == 0) {
                    flightInfo._cabinInfo = nil;
                }
                [firstArray addObject:flightInfo];
                [flightInfo release];
            }
        }
        
        queryTicket._firstFlightInfo = firstArray;
        if ([queryTicket._firstFlightInfo count] == 0) {
            queryTicket._firstFlightInfo = nil;
        }
        NSArray * secondFlightInfo = nil;
        if (![[dic objectForKey:@"secondFlightInfo"] isKindOfClass:[NSNull class]]) {
            secondFlightInfo = [dic objectForKey:@"secondFlightInfo"];
        }
        
        if ([secondFlightInfo isKindOfClass:[NSArray class]]) {
            for (NSDictionary * elem in secondFlightInfo) {
                FlightInfo * flightInfo = [[FlightInfo alloc] init];
                flightInfo._startDate = [NSString stringWithFormat:@"%@",[elem objectForKey:@"startDate"]];
                flightInfo._flightNo =[NSString stringWithFormat:@"%@", [elem objectForKey:@"flightNo"]];
                flightInfo._airline = [NSString stringWithFormat:@"%@",[elem objectForKey:@"airline"]];
                flightInfo._planeType =[NSString stringWithFormat:@"%@", [elem objectForKey:@"planeType"]];
                flightInfo._ticketCount = [NSString stringWithFormat:@"%@",[elem objectForKey:@"ticketCount"]] ;
                flightInfo._ticketPrice = [NSString stringWithFormat:@"%d", [[NSString stringWithFormat:@"%@", [elem objectForKey:@"ticketPrice"]] intValue]];
                flightInfo._discount =[NSString stringWithFormat:@"%@", [elem objectForKey:@"discount"]];
                flightInfo._endTime = [NSString stringWithFormat:@"%@",[elem objectForKey:@"endTime"]];
                flightInfo._startAirport = [NSString stringWithFormat:@"%@",[elem objectForKey:@"startAirport"]];
                flightInfo._startTerminal = [NSString stringWithFormat:@"%@",[elem objectForKey:@"startTerminal"]];
                flightInfo._endAirport = [NSString stringWithFormat:@"%@",[elem objectForKey:@"endAirport"]];
                flightInfo._endTerminal = [NSString stringWithFormat:@"%@",[elem objectForKey:@"endTerminal"]];
                flightInfo._stopNum = [NSString stringWithFormat:@"%@", [elem objectForKey:@"stopNum"]];
                flightInfo._returnLcdFee =  [NSString stringWithFormat:@"%@", [elem objectForKey:@"returnLcdFee"]];
                flightInfo._startAirportCode = [NSString stringWithFormat:@"%@", [elem objectForKey:@"startAirportCode"]];
                flightInfo._endAirportCode = [NSString stringWithFormat:@"%@", [elem objectForKey:@"endAirportCode"]];
                
                flightInfo._planeTypeName =  [NSString stringWithFormat:@"%@", [elem objectForKey:@"planeTypeName"]];
                flightInfo._dropFee =  [NSString stringWithFormat:@"%@", [elem objectForKey:@"dropFee"]];
                flightInfo._ticketPrice = [NSString stringWithFormat:@"%d", [[NSString stringWithFormat:@"%@", [elem objectForKey:@"ticketPrice"]] intValue] - [flightInfo._dropFee intValue]];
                flightInfo._soldout =  [NSString stringWithFormat:@"%@", [elem objectForKey:@"soldout"]];
                
                if ([flightInfo._dropFee intValue]>0) {
                    flightInfo._isdrop = TRUE;
                }
                else{
                    flightInfo._isdrop = FALSE;
                }
                
                flightInfo._cabinCountZeroArray = [NSMutableArray array];
                NSMutableArray * mArray = [NSMutableArray array];
//                CabinInfo * Fcabin = nil;
                NSArray *temp = [elem objectForKey:@"cabinInfo"];
                if ([temp isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * elemsub in temp) {
                        NSString * ticketCount = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"ticketCount"]] ;
                        
                        CabinInfo * cabinInfo = [[CabinInfo alloc] init];
                        cabinInfo._cabinCode =[NSString stringWithFormat:@"%@", [elemsub objectForKey:@"cabinCode"]];
                        cabinInfo._baseCabin = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"baseCabin"]];
                        cabinInfo._cabinType = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"cabinType"]] ;
                        cabinInfo._cabinTypeName = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"cabinTypeName"]];
                        cabinInfo._ticketPrice = [NSString stringWithFormat:@"%d", [[NSString stringWithFormat:@"%@", [elemsub objectForKey:@"ticketPrice"]] intValue]];
                        cabinInfo._ticketCount = ticketCount;
                        cabinInfo._discount = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"discount"]];
                        cabinInfo._returnLcdFee =[NSString stringWithFormat:@"%@",[elemsub objectForKey:@"returnLcdFee"]] ;
                        cabinInfo._specialFlightNum = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"specialFlightNum"]];
                        
                        cabinInfo._dropFee = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"dropFee"]];
                        if ([cabinInfo._dropFee intValue]>0) {
                            flightInfo._isdrop = TRUE;
                        }
                        cabinInfo._returnLcdFeeRatio = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"returnLcdFeeRatio"]];
                        cabinInfo._source = [NSString stringWithFormat:@"%@",[elemsub objectForKey:@"source"]];
                        cabinInfo._ticketPrice = [NSString stringWithFormat:@"%d", [[NSString stringWithFormat:@"%@", [elemsub objectForKey:@"ticketPrice"]] intValue] - [cabinInfo._dropFee intValue]];
                        
                        if ([ticketCount isEqualToString:@"0"]) {
                            [flightInfo._cabinCountZeroArray addObject:cabinInfo];
                        }
                        else {
                             [mArray addObject:cabinInfo];
//                            if ([cabinInfo._cabinCode isEqualToString:@"F"]) {
//                                Fcabin = [cabinInfo retain];
//                            }
//                            else {
//                                [mArray addObject:cabinInfo];
//                            }
                        }
                        [cabinInfo release];
                    }
                }
                
                flightInfo._cabinInfo = mArray;
                if ([flightInfo._cabinInfo count] == 0) {
                    flightInfo._cabinInfo = nil;
                }
                NSMutableArray * sortedArray =  [NSMutableArray array];
                [sortedArray addObjectsFromArray:[mArray sortedArrayUsingFunction:sortTicketArrayByPriceDesc context:NULL]] ;
//                if (Fcabin) {
//                    [sortedArray insertObject:Fcabin atIndex:0];
//                    [Fcabin release];
//                }
                flightInfo._cabinInfo = sortedArray;
                if ([flightInfo._cabinInfo count]==0) {
                    flightInfo._cabinInfo = nil;
                }
                [secondArray addObject:flightInfo];
                [flightInfo release];
            }
        }
        
        queryTicket._secondFlightInfo = secondArray;
        if ([queryTicket._secondFlightInfo count] == 0) {
            queryTicket._secondFlightInfo = nil;
        }
    }
    
    return [queryTicket autorelease];
}
@end
