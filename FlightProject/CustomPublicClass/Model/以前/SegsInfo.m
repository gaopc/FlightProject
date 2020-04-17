//
//  SegsInfo.m
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SegsInfo.h"

@implementation SegsInfo
@synthesize departure, arrival, departureDate, baseCabin, cabinDiscount, cabin, flightNo, planeType, specialFlightNum, arriveDate, airLine;
-(void)dealloc
{
    self.departure = nil;
    self.arrival = nil;
    self.departure = nil;
    self.baseCabin = nil;
    self.cabinDiscount = nil;
    self.cabin = nil;
    self.flightNo = nil;
    self.planeType = nil;
    self.specialFlightNum = nil;
    self.arriveDate = nil;
    self.airLine = nil;
    [super dealloc];
}
@end
