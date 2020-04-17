//
//  QueryFlightTicketDetail.m
//  FlightProject
//
//  Created by longcd on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QueryFlightTicketDetail.h"

@implementation StopCityInfo

@synthesize _name,_time;
-(void)dealloc
{
    self._name = nil;
    self._time = nil;
    [super dealloc];
}

@end

@implementation QueryFlightTicketDetail
@synthesize _airportTaxForAdult,_airportTaxForChild,_fuelTaxForAdult,_fuelTaxForChild,_stopCityInfo;
-(void)dealloc
{
    self._airportTaxForAdult = nil;
    self._airportTaxForChild = nil;
    self._fuelTaxForAdult = nil;
    self._fuelTaxForChild = nil;
    self._stopCityInfo = nil;
    [super dealloc];
}
+(QueryFlightTicketDetail *)QueryFlightTicketDetail:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    QueryFlightTicketDetail * detail = [[QueryFlightTicketDetail alloc] init];
    detail._airportTaxForAdult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"airportTaxForAdult"]];
    detail._airportTaxForChild = [NSString stringWithFormat:@"%@",[dic objectForKey:@"airportTaxForChild"]];
    detail._fuelTaxForAdult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fuelTaxForAdult"]];
    detail._fuelTaxForChild = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fuelTaxForChild"]];
    if (![[dic objectForKey:@"stopCityInfo"] isKindOfClass:[NSNull class]]) {
        NSMutableArray * mArray = [NSMutableArray array];
        NSArray *temp = [dic objectForKey:@"stopCityInfo"];
        if ([temp isKindOfClass:[NSArray class]]) {
            for (NSDictionary * elem in temp ) {
                StopCityInfo * info = [[StopCityInfo alloc] init];
                info._name = [NSString stringWithFormat:@"%@",[elem objectForKey:@"name"]];
                info._time =  [NSString stringWithFormat:@"%@",[elem objectForKey:@"time"]];
                [mArray addObject:info];
                [info release];
            }
        }
        
        detail._stopCityInfo = mArray;
        if ([detail._stopCityInfo count] == 0) {
            detail._stopCityInfo = nil;
        }
    }
    return [detail autorelease];
}
@end
