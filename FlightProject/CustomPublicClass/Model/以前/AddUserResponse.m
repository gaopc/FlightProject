//
//  AddUserResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AddUserResponse.h"

@implementation RegisterInfo

@synthesize telephone, password, checkCode, source, recommendTelephone;
-(void)dealloc
{
    self.telephone = nil;
    self.password = nil;
    self.checkCode = nil;
    self.source = nil;
    self.recommendTelephone = nil;
    [super dealloc];
}

@end

@implementation AddUserResponse
+(NSString *)addUserResponseWithArray:(NSArray *)resultArray
{
    NSString * userID = nil;
    if ([[resultArray objectAtIndex:0] isEqualToString:@"0"]) {
        userID = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"注册成功,会员ID为: %@",userID]];
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    return userID;
}
@end
