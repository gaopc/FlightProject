//
//  UserRefundTicketNewResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserRefundTicketNewResponse.h"

@implementation autorRefundTicketRequest

@synthesize userID,ticketNoList,refundType;
-(void)dealloc
{
    self.userID = nil;
    self.ticketNoList = nil;
    self.refundType = nil;
    [super dealloc];
}

@end

@implementation UserRefundTicketNewResponse
+(void)userRefundTicketNewResponseWithArray:(NSArray *)resultArray
{
    if ([[resultArray objectAtIndex:0] isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:@"退票成功"];
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    
}
@end
