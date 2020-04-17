//
//  TripModel.h
//  FlightProject
//
//  Created by gaopengcheng on 15-11-9.
//
//

#import "QueryFlightTicket.h"
#import "GetOrderHotelList.h"

@interface TripModel : FlightInfo
@property (nonatomic ,retain) NSString *_departureCity;
@property (nonatomic ,retain) NSString *_arrivalCity;
@property (nonatomic ,retain) NSString *_departureWeather;
@property (nonatomic ,retain) NSString *_arrivalWeather;
@property (nonatomic ,retain) NSString *_cabinType;

+ (NSMutableArray *)getTripForTicketModel:(NSDictionary *)dic;
@end


@interface TripHotelModel : HotelModel
@property (nonatomic ,retain) NSString *_lat;
@property (nonatomic ,retain) NSString *_lon;

+ (NSMutableArray *)getTripForHotelModel:(NSDictionary *)dic;
@end