//
//  UpdateOrderGetItineraryResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UpdateOrderGetItineraryResponse.h"
@implementation UpdateOrderGetItineraryRequst
@synthesize orderID,getLtinerary,mailPsg;
-(void)dealloc
{
    self.orderID = nil;
    self.getLtinerary = nil;
    self.mailPsg = nil;
    [super dealloc];
}
@end

@implementation UpdateOrderGetItineraryResponse
+(void)updateOrderGetItineraryResponseWithArray:(NSArray *)resultArray
{
    if ([[resultArray objectAtIndex:0] isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:@"修改行程单成功"];
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
}
@end
