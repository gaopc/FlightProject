//
//  TelePhoneLoginResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TelePhoneLoginResponse.h"

@implementation TelephoneLogin

@synthesize telephone,password;
-(void)dealloc
{
    self.telephone = nil;
    self.password = nil;
    [super dealloc];
}

@end

@implementation TelePhoneLoginResponse
+(UserInfo *)telePhoneLoginResponseWithArray:(NSArray *)resultArray
{
    UserInfo * userInfo = nil;
    if ([[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:0]] isEqualToString:@"0"])
    {
        userInfo = [UserInfo sharedUserInfo];
        userInfo.userID = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
         userInfo.password = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:3]];
         userInfo.name = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:4]];
         userInfo.email = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:5]];
         userInfo.telePhone = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:6]];
    }
    else {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:1]] ];
    }
    return userInfo ;
}
@end
