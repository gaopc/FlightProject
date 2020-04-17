//
//  UserInfo.m
//  FlightProject
//
//  Created by longcd on 12-6-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
@synthesize userID,password,name,email,telePhone,birthday,sex,postalAddress,postCode,cardType,cardNo;

-(void)dealloc
{
   
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
	
    [super dealloc];
}
+(UserInfo *)sharedUserInfo
{
    static UserInfo * info = nil;
    if (info == nil) {
        info = [[UserInfo alloc] init];
        info.userID = @"69659";
        info.telePhone = @"13531375946";
        info.email = @"";
    }
    return info;
}
@end
