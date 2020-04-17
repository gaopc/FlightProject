//
//  PassengerInfo.m
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PassengerInfo.h"


@implementation PassengerInfo

@synthesize airlineMileageCard,psgMileageCard,totalMoney,fuelTax,airportTax,insuranceCount,insuranceMoney,returnTotalMoney,returnFuelTax,returnAirportTax;

-(void)dealloc
{
    self.airlineMileageCard = nil;
    self.psgMileageCard = nil;
    self.totalMoney = nil;
    self.fuelTax = nil;
    self.airportTax = nil;
    self.insuranceMoney = nil;
    self.insuranceCount = nil;
    self.returnTotalMoney = nil;
    self.returnFuelTax = nil;
    self.returnAirportTax = nil;
    [super dealloc];
}

@end