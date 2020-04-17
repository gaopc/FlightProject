//
//  GetFeedbackInfosResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ResetPasswordResponse.h"
@implementation ResetPassword
@synthesize telephone,passWord,checkCode;
-(void)dealloc
{
    self.telephone = nil;
    self.passWord = nil;
    self.checkCode = nil;
    [super dealloc];
 }
@end

@implementation ResetPasswordResponse
+(void)resetPasswordResponseWithArray:(NSArray *)resultArray
{
    if ([[resultArray objectAtIndex:0] isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:@"密码修改成功"];
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
}
@end
