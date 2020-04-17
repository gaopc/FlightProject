//
//  UpdateTicketPostalAddressResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UpdateTicketPostalAddressResponse.h"
@implementation UpdateTicketPostalAddressRequst
@synthesize userID,orderID,mailPsg;
-(void)dealloc
{
    self.userID = nil;
    self.orderID = nil;
    self.mailPsg = nil;
    [super dealloc];
}
@end

@implementation UpdateTicketPostalAddressResponse
+(void)updateTicketPostalAddressResponseWithArray:(NSArray *)resultArray
{
    if ([[resultArray objectAtIndex:0] isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:@"修改邮寄信息成功"];
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
}
@end
