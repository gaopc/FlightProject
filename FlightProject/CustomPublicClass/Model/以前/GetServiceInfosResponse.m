//
//  GetServiceInfosResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetServiceInfosResponse.h"
@implementation TicketPrice
@synthesize ticketDate,ticketPrice;
-(void)dealloc
{
    self.ticketPrice = nil;
    self.ticketDate = nil;
    [super dealloc];
}
@end

@implementation ServiceInfo

@synthesize ticketNo,price,ticketPriceArray;
-(void)dealloc
{
    self.ticketNo = nil;
    self.price = nil;
    self.ticketPriceArray = nil;
    [super dealloc];
}


@end

@implementation GetServiceInfosResponse
+(TicketPrice *)getServiceInfosResponseWithElem:(NSArray *)elem
{
    TicketPrice * instance = [[TicketPrice alloc] init];
    instance.ticketDate = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    instance.ticketDate = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    return [instance autorelease];
}
+(ServiceInfo *)getServiceInfosResponseWithArray:(NSArray *)resultArray
{
    ServiceInfo * serviceInfo = nil;
    NSArray * array = [resultArray objectAtIndex:0];
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        serviceInfo = [[ServiceInfo alloc] init];
        NSArray * dataArray = [resultArray objectAtIndex:1];
        serviceInfo.ticketNo =  [NSString stringWithFormat:@"%@",[dataArray objectAtIndex:0]];
        serviceInfo.price =  [NSString stringWithFormat:@"%@",[dataArray objectAtIndex:1]];
        NSString * ticketPrice =  [NSString stringWithFormat:@"%@",[dataArray objectAtIndex:2]];
        NSArray * priceArray = [ticketPrice componentsSeparatedByString:@"+"];
        NSMutableArray * mArray = [[NSMutableArray alloc] init];
        for (NSString * str in priceArray) {
            NSArray * elem = [str componentsSeparatedByString:@";"];
            [mArray addObject:[self getServiceInfosResponseWithElem:elem]];
        }
        serviceInfo.ticketPriceArray = mArray;
        [mArray release];
    }
    else {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[array objectAtIndex:1]]];
    }
    return [serviceInfo autorelease];
}
@end
