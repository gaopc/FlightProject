//
//  GetReservationInfosResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetReservationInfosResponse.h"

@implementation ReservationInfos

@synthesize reservationID;
-(void)dealloc
{
    self.reservationID = nil;
    [super dealloc];
}

@end


@implementation GetReservationInfosResponse
+(ReservationInfos *)getReservationInfosResponseWithElem:(NSArray *)elem
{
    ReservationInfos * info = [[ReservationInfos alloc] init];
    info.dptCity = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    info.arrCity = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    info.startDate = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    info.endDate = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    info.flyPeriod = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    info.week = [NSString stringWithFormat:@"%@",[elem objectAtIndex:5]];
    info.accept = [NSString stringWithFormat:@"%@",[elem objectAtIndex:6]];
    info.SMSTime = [NSString stringWithFormat:@"%@",[elem objectAtIndex:7]];
    info.cabinDiscount = [NSString stringWithFormat:@"%@",[elem objectAtIndex:8]];
    info.reservationID = [NSString stringWithFormat:@"%@",[elem objectAtIndex:9]];
    return [info autorelease];
}
+(NSArray *)getReservationInfosResponseWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    NSMutableArray * returnArray = nil;
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        returnArray = [[NSMutableArray alloc] init];
        NSArray * dataArray = [resultArray objectAtIndex:1];
        for (NSArray * elem in dataArray) {
            [returnArray addObject:[self getReservationInfosResponseWithElem:elem]];
        }
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    return [returnArray autorelease];

}
@end
