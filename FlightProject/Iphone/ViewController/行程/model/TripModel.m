//
//  TripModel.m
//  FlightProject
//
//  Created by gaopengcheng on 15-11-9.
//
//

#import "TripModel.h"

@implementation TripModel
@synthesize _cabinType, _arrivalWeather, _departureWeather, _departureCity, _arrivalCity;

- (void)dealloc
{
    self._cabinType = nil;
    self._arrivalCity = nil;
    self._arrivalWeather = nil;
    self._departureCity = nil;
    self._departureWeather = nil;
    [super dealloc];
}

+ (NSMutableArray *)getTripForTicketModel:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSArray *dataArr = [dic objectForKey:@"noTakeOffTicketList"];
    if ([dataArr isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    NSMutableArray *modelArr = [[[NSMutableArray alloc] init] autorelease];
    for (NSDictionary *itemDic in dataArr) {
        
        TripModel *tripModel = [[[TripModel alloc] init] autorelease];
        tripModel._planeType = [itemDic objectForKey:@"planeType"];
        tripModel._flightNo = [itemDic objectForKey:@"flightNo"];
        tripModel._airline = [itemDic objectForKey:@"airline"];
        tripModel._departureCity = [itemDic objectForKey:@"departureCity"];
        tripModel._arrivalCity = [itemDic objectForKey:@"arrivalCity"];
        tripModel._departureWeather = [itemDic objectForKey:@"departureWeather"];
        tripModel._arrivalWeather = [itemDic objectForKey:@"arrivalWeather"];
        tripModel._startDate = [itemDic objectForKey:@"departureTime"];
        tripModel._endTime = [itemDic objectForKey:@"arrivalTime"];
        tripModel._startAirport = [itemDic objectForKey:@"startAirport"];
        tripModel._startTerminal = [itemDic objectForKey:@"startTerminal"];
        tripModel._endAirport = [itemDic objectForKey:@"endAirport"];
        tripModel._endTerminal = [itemDic objectForKey:@"endTerminal"];
        tripModel._cabinType = [itemDic objectForKey:@"cabinType"];
        
        [modelArr addObject:tripModel];
    }
    return modelArr;
}
@end



@implementation TripHotelModel
@synthesize _lon, _lat;

- (void)dealloc
{
    self._lat = nil;
    self._lon = nil;
    [super dealloc];
}

+ (NSMutableArray *)getTripForHotelModel:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSArray *dataArr = [dic objectForKey:@"hotelList"];
    if ([dataArr isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    NSMutableArray *modelArr = [[[NSMutableArray alloc] init] autorelease];
    for (NSDictionary *itemDic in dataArr) {
        
        TripHotelModel *tripModel = [[[TripHotelModel alloc] init] autorelease];
        tripModel.checkInDate = [NSString stringWithFormat:@"%@", [itemDic objectForKey:@"checkInDate"]];
        tripModel.checkOutDate = [NSString stringWithFormat:@"%@", [itemDic objectForKey:@"checkOutDate"]];
        tripModel.hotelName = [NSString stringWithFormat:@"%@", [itemDic objectForKey:@"hotelName"]];
        tripModel.hotelAddress = [NSString stringWithFormat:@"%@", [itemDic objectForKey:@"hotelAddress"]];
        tripModel.roomTypeName = [[itemDic objectForKey:@"roomTypeName"] isKindOfClass:[NSNull class]] ? @"" : [itemDic objectForKey:@"roomTypeName"];
        tripModel.peopleName = [NSString stringWithFormat:@"%@", [itemDic objectForKey:@"peopleName"]];
        tripModel._lon = [NSString stringWithFormat:@"%@", [itemDic objectForKey:@"lon"]];
        tripModel._lat = [NSString stringWithFormat:@"%@", [itemDic objectForKey:@"lat"]];
        
        [modelArr addObject:tripModel];
    }
    return modelArr;
}
@end
