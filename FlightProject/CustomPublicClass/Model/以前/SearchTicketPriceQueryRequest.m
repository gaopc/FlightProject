//
//  SearchTicketPriceQueryRequest.m
//  LCDFlight
//
//  Created by walker on 11-7-28.
//  Copyright 2011年 BeyondSoft. All rights reserved.
//

#import "SearchTicketPriceQueryRequest.h"


@implementation SearchTicketPriceQueryRequest

@synthesize departure;
@synthesize arrival;
@synthesize departureDate;
@synthesize arrivalTime;
@synthesize flightNo;
@synthesize cabin;
@synthesize planeType;

- (id)init
{
	[super init];
	cabin = [[NSMutableArray alloc] init];
	return self;
}

- (void)dealloc
{
    self.departure = nil;
    self.arrival = nil;
    self.departureDate = nil;
    self.arrivalTime = nil;
    self.flightNo = nil;
    self.cabin = nil;
    self.planeType = nil;
	[super dealloc];
    
}

@end
