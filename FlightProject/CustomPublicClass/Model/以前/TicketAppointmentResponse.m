//
//  TicketAppointmentResponse.m
//  FlightProject
//
//  Created by 崔立东 on 12-9-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  机票预约数据传输模型
//

#import "TicketAppointmentResponse.h"



@implementation TicketAppointment

@synthesize terminalId;
@synthesize userId;
@synthesize cabinDiscount;
@synthesize departure;
@synthesize arrival;
@synthesize starteDate;
@synthesize endDate;
@synthesize flyPeriod;
@synthesize endPeriod;
@synthesize smsTime;
@synthesize endSmsDate;

-(void)dealloc
{
  self.terminalId = nil;
  self.userId = nil;
  self.cabinDiscount = nil;
  self.departure = nil;
  self.arrival = nil;
  self.starteDate = nil;
  self.endDate = nil;
  self.flyPeriod = nil;
  self.endPeriod = nil;
  self.smsTime = nil;
  self.endSmsDate = nil;

  [super dealloc];
}

@end

@implementation TicketAppointmentResponse

@end
