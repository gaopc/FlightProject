//
//  MailInfo.m
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MailPsgInfo.h"

@implementation MailPsgInfo
@synthesize mailName,postCode,postalAddress,mobile,addressID;
-(void)dealloc
{
    self.mailName = nil;
    self.postCode = nil;
    self.postalAddress = nil;
    self.mobile = nil;
    self.addressID = nil;
    [super dealloc];
}
@end
