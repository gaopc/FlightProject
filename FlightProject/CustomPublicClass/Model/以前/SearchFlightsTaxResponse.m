//
//  SearchFlightsTaxResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchFlightsTaxResponse.h"
@implementation SearchFlightsTaxRequest

@synthesize departure;
@synthesize arrival;
@synthesize departureDate;
@synthesize psgType;
@synthesize airline;
@synthesize planeType;
-(void)dealloc{
	
    self.departure = nil;
    self.arrival = nil;
    self.departureDate = nil;
    self.psgType = nil;
    self.airline = nil;
    self.planeType = nil;
	[super  dealloc];
}

-(id)init{
	self = [super init];
	if (self) {
		
	}
	return self;
}

@end

@implementation FlightsTax

@synthesize fuelTax,airportTax,currency;
-(void)dealloc
{
    self.fuelTax = nil;
    self.airportTax = nil;
    self.currency = nil;
    [super dealloc];
}


@end

@implementation SearchFlightsTaxResponse
+(FlightsTax *) searchFlightsTaxResponseWithArray:(NSArray * ) resultArray
{
    FlightsTax * flightTax = nil;
    NSString * resultFlag =[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:0]] ;
    NSString * errorDes =[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:1]] ;
    if ([resultFlag isEqualToString:@"0"]) {
        flightTax = [[FlightsTax alloc] init];
        flightTax.fuelTax =[NSString stringWithFormat:@"¥%d",[[resultArray objectAtIndex:2] intValue] / 100] ;
        flightTax.airportTax =[NSString stringWithFormat:@"¥%d",[[resultArray objectAtIndex:3] intValue] / 100] ;
        flightTax.currency =[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:4]] ;
    }
    else {
        
        [UIAlertView alertViewWithMessage:errorDes];
    }
    return [flightTax autorelease];
}
@end
