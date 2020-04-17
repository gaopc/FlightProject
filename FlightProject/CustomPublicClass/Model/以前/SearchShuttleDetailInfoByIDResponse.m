//
//  SearchShuttleDetailInfoByIDResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchShuttleDetailInfoByIDResponse.h"

@implementation SearchShuttleDetailInfoByIDResponse
+(ShuttleInfo *)searchShuttleDetailInfoByIDResponseWithArray:(NSArray *) resultArray
{
    ShuttleInfo * info = nil;
    if ([[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:0]] isEqualToString:@"0"]) {
        info = [[ShuttleInfo alloc] init];
        info.shuttleID = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
        info.shuttleName = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:3]];
        info.airportID = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:4]];
        info.price = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:5]];
        info.operationsTime = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:6]];
        info.intervalTime = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:7]];
        info.passStation = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:8]];
        info.startStation = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:9]];
        info.endStation = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:10]];
        info.driection = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:11]];
        info.hotLine = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:12]];
    }
    else {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:1]]];
    }
    return [info autorelease];
}
@end
