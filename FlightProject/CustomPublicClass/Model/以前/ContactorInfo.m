//
//  ContactorInfo.m
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ContactorInfo.h"

@implementation ContactorInfo
@synthesize contactorName,contactorMobile,contactorTelephone,contactorID;
-(void)dealloc
{
    self.contactorTelephone = nil;
    self.contactorName = nil;
    self.contactorMobile = nil;
    self.contactorID = nil;
    [super dealloc];
}
@end
