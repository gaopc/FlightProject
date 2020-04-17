//
//  PassengerInfomation.m
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PassengerInfomation.h"

@implementation PassengerInfomation
@synthesize psgName,psgType,IDNo,userID,IDType,birthday,contactPhone;

-(void)dealloc
{
    self.psgName = nil;
    self.psgType = nil;
    self.IDNo = nil;
    self.userID = nil;
    self.IDType = nil;
    self.birthday = nil;
    self.contactPhone = nil;
    [super dealloc];
}
-(NSString *)description
{
    NSString * str = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@",self.psgName,self.psgType,self.IDNo,self.IDType,self.birthday,self.contactPhone,self.userID];
    return str;
}
@end
