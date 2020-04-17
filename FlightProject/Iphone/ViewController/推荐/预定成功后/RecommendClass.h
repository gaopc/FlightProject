//
//  RecommendClass.h
//  FlightProject
//
//  Created by longcd on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterfaceClass.h"
#import "SendRequstCatchQueue.h"
#import "QueryFlightTicket.h"
#import "TicketQueryViewController.h"
#import "SubmitOrderCarInfo.h"

@protocol RecommendClassDelegate <NSObject>
-(void) recommendTicketSucessful:(QueryFlightTicket  *)array;
-(void) recommendHotelSucessful:(HotelQueryDataResponse *)response;
-(void) recommendCarSucessful:(NSArray *) array;
@end

@interface RecommendClass : NSObject

@property (nonatomic,retain) TicketQueryDataModel * ticketQueryDataModel;
@property (nonatomic,retain) TicketQueryDataModel * hotelQueryDataModel;
@property (nonatomic,retain) SubmitOrderCarInfo * carQueryDataModel;

@property (nonatomic,retain) id delegate;

- (void)recommendFlightWithDeparture:(NSString *)departure withArrival:(NSString *)arrival withStartDate:(NSString *)startDate; //73
- (void)recommendHotelWithCityName:(NSString *)cityName withCheckInDate:(NSString *)checkInDate; //74
- (void)recommendCarWithCityCode:(NSString *)cityCode withFromDate:(NSString *)fromDate withToDate:(NSString *)toDate; //75

@end
