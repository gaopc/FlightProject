//
//  UpdateOrdercontactorResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UpdateOrdercontactorResponse.h"
@implementation UpdateOrdercontactorRequst
@synthesize userID,orderID,contactor;
-(void)dealloc
{
    self.userID = nil;
    self.orderID = nil;
    self.contactor = nil;
    [super dealloc];
}
@end

@implementation UpdateOrdercontactorResponse
+(void)updateOrdercontactorResponseWithArray:(NSArray *)resultArray
{
    if ([[resultArray objectAtIndex:0] isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:@"修改订单联系人信息成功"];
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }

}
@end
