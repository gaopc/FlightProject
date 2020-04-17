//
//  AddPassengerResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AddPassengerResponse.h"

@implementation AddPassengerResponse
+(NSString *)addPassengerResponseWithArray:(NSArray *)resultArray
{
    NSString * passengerID = nil;
    if ([[resultArray objectAtIndex:0] isEqualToString:@"0"]) {
        passengerID = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"添加成功,常旅客ID为: %@",passengerID]];
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    return passengerID;
}
@end
