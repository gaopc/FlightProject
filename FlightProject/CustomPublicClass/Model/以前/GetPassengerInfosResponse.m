//
//  GetPassengerInfosResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetPassengerInfosResponse.h"

@implementation GetPassengerInfosResponse 

+(PassengerInfomation *) getPassengerInfosResponseWithElem:(NSArray *)elem
{
    PassengerInfomation * passengerInfos = [[PassengerInfomation alloc] init];
    passengerInfos.psgName = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    passengerInfos.psgType = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    passengerInfos.IDType = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    passengerInfos.IDNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    passengerInfos.birthday = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    passengerInfos.contactPhone = [NSString stringWithFormat:@"%@",[elem objectAtIndex:5]];
    passengerInfos.userID = [NSString stringWithFormat:@"%@",[elem objectAtIndex:6]];
    return [passengerInfos autorelease];
}
+(NSArray *)getPassengerInfosResponseWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    if ([[array objectAtIndex:0] isEqualToString:@"0"]) {
        NSMutableArray * mArray = [[NSMutableArray alloc] init];
        for (int i=1; i<[resultArray count]; i++) {
            [mArray addObject:[self getPassengerInfosResponseWithElem:[resultArray objectAtIndex:i]]];
        }
        return [mArray autorelease];
    }
    else
    {
        [UIAlertView alertViewWithMessage:[array objectAtIndex:1]];
        return nil;
    }
}
@end