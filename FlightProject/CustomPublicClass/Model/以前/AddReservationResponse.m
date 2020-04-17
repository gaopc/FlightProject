//
//  AddReservationResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AddReservationResponse.h"
@implementation  ReservationInfo
@synthesize dptCity,arrCity,startDate,endDate,flyPeriod,week,accept,SMSTime,cabinDiscount;
-(void)dealloc
{
    self.dptCity = nil;
    self.arrCity = nil;
    self.startDate = nil;
    self.endDate = nil;
    self.flyPeriod = nil;
    self.week = nil;
    self.accept = nil;
    self.SMSTime = nil;
    self.cabinDiscount = nil;
    [super dealloc];
}

@end

@implementation ReservationRequstInfo

@synthesize userID;
-(void)dealloc
{
    self.userID = nil;
    [super dealloc];
}

@end

@implementation AddReservationResponse
+(NSString *)addReservationResponseWithArray:(NSArray *)resultArray
{
    NSString * reservationID = nil;
    if ([[resultArray objectAtIndex:0] isEqualToString:@"0"]) {
        reservationID = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"预约成功,预约ID为: %@",reservationID]];
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    return reservationID;
}
@end
