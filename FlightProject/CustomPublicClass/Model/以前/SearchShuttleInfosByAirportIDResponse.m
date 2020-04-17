//
//  SearchShuttleInfosByAirportIDResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchShuttleInfosByAirportIDResponse.h"

@implementation ShuttleInfo

@synthesize shuttleID,shuttleName,operationsTime,price,startStation,endStation,airportID,intervalTime,passStation,driection,hotLine;
-(void)dealloc
{
    self.shuttleID = nil;
    self.shuttleName = nil;
    self.operationsTime = nil;
    self.price = nil;
    self.startStation = nil;
    self.endStation = nil;
    self.airportID = nil;
    self.intervalTime = nil;
    self.passStation = nil;
    self.driection = nil;
    self.hotLine = nil;
    [super dealloc];
}

@end

@implementation SearchShuttleInfosByAirportIDResponse
+(ShuttleInfo *)searchShuttleInfosByAirportIDResponseWithElem:(NSArray *)elem
{
    ShuttleInfo * info = [[ShuttleInfo alloc] init];
    info.shuttleID = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    info.shuttleName = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    info.operationsTime = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    info.price = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    info.startStation = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    info.endStation = [NSString stringWithFormat:@"%@",[elem objectAtIndex:5]];
    return [info autorelease];
}
+(NSArray *)searchShuttleInfosByAirportIDResponseWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    NSMutableArray * returnArray = nil;
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        returnArray = [[NSMutableArray alloc] init];
        NSArray * dataArray = [resultArray objectAtIndex:1];
        for (NSArray * elem in dataArray) {
            [returnArray addObject:[self searchShuttleInfosByAirportIDResponseWithElem:elem]];
        }
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    return [returnArray autorelease];
}
@end
