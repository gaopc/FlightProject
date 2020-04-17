//
//  DeleteUserInfoResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DeleteUserInfoResponse.h"

@implementation DeleteUserInfoResponse
+(void)deleteUserInfoResponseWithArray:(NSArray *)resultArray
{
    if ([[resultArray objectAtIndex:0] isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:@"删除成功"];
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
 
}
@end
