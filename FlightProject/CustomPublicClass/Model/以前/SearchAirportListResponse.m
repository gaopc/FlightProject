//
//  SearchAirportListResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchAirportListResponse.h"

@implementation AirportInfo

@synthesize airportID,airportName;
-(void)dealloc
{
    self.airportName = nil;
    self.airportID = nil;
    [super dealloc];
}

@end

@implementation SearchAirportListResponse
+(AirportInfo *)searchAirportLisResponseWithElem:(NSArray *)elem
{
    AirportInfo * info = [[AirportInfo alloc] init];
    info.airportID = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    info.airportName = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    return [info autorelease];
}
+(NSArray *)searchAirportLisResponseWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    NSMutableArray * returnArray = nil;
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        returnArray = [[NSMutableArray alloc] init];
        NSArray * dataArray = [resultArray objectAtIndex:1];
        for (NSArray * elem in dataArray) {
            [returnArray addObject:[self searchAirportLisResponseWithElem:elem]];
        }
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    return [returnArray autorelease];

}
@end
