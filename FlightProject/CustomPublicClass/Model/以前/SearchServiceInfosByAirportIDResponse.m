//
//  SearchServiceInfosByAirportIDResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchServiceInfosByAirportIDResponse.h"

@implementation AirportServiceInfo

@synthesize serviceName,serviceID;
-(void)dealloc
{
    self.serviceName = nil;
    self.serviceID = nil;
    [super dealloc];
}

@end

@implementation SearchServiceInfosByAirportIDResponse
+(AirportServiceInfo *)searchServiceInfosByAirportIDResponseWithElem:(NSArray *)elem
{
    AirportServiceInfo * info = [[AirportServiceInfo alloc] init];
    info.serviceName = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    info.serviceID = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    return [info autorelease];

}  
+(NSArray *)searchServiceInfosByAirportIDResponseWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    NSMutableArray * returnArray = nil;
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        returnArray = [[NSMutableArray alloc] init];
        NSArray * dataArray = [resultArray objectAtIndex:1];
        for (NSArray * elem in dataArray) {
            [returnArray addObject:[self searchServiceInfosByAirportIDResponseWithElem:elem]];
        }
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    return [returnArray autorelease];

}
@end
