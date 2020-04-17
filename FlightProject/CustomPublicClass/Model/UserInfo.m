//
//  UserInfo.m
//  FlightProject
//
//  Created by longcd on 12-6-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserInfo.h"
#import "NSDate+convenience.h"

@implementation UserInfo
@synthesize userID,password,name,email,telePhone,birthday,sex,postalAddress,postCode,cardType,cardNo;
@synthesize deviceToken, _orderStateNum;
@synthesize _isAutoLogin,_loginTime,_isAutoLoginOut;
@synthesize lcdCurrency,idCard;
-(void)dealloc
{
    self._orderStateNum = nil;
    self.userID = nil;
    self.password = nil;
    self.name = nil;
    self.email = nil;
    self.telePhone = nil;
    self.birthday = nil;
    self.sex = nil;
    self.postalAddress = nil;
    self.postCode = nil;
    self.cardType = nil;
    self.cardNo = nil;
    
    self.deviceToken = nil;
    
    self._isAutoLogin = false;
    self._loginTime = nil;
	
    self.lcdCurrency = nil;
    self.idCard = nil;
    [super dealloc];
}
+(UserInfo *)sharedUserInfo
{
    static UserInfo * info = nil;
    if (info == nil) {
        info = [[UserInfo alloc] init];
        info._loginTime = [NSDate laterDateStr:[NSDate date]];
        info._isActivityShare = NO;
//        info.userID = @"69743";
//        info.userID = @"69659";
//        info.telePhone = @"13531375946";
//        info.email = @"";
    }
    return info;
}
@end
