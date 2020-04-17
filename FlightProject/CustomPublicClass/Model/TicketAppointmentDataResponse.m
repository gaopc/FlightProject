//
//  TicketAppointmentDataResponse.m
//  FlightProject
//
//  Created by green kevin on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TicketAppointmentDataResponse.h"

@implementation TicketAppointmentDataResponse
@synthesize _ticketAppointmentDescArray,_id,_message;

//查询机票预约列表
+ (NSMutableArray *)queryReservationList:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray *appointmentlist = [dic valueForKey:@"reservationList"];
	NSMutableArray *list = [NSMutableArray array];
    if ([appointmentlist isKindOfClass:[NSArray class]]) {
        if (![appointmentlist isEqual:@""])
        {
            for (NSDictionary *dicList in appointmentlist) {
                TicketAppointmentInfo *info = [[TicketAppointmentInfo alloc] init];
                info._id = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"id"]] ;
                info._departure =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"departure"]] ;
                info._arrival =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"arrival"]] ;
                info._starteDate =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"starteDate"]] ;
                info._endDate =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"endDate"]] ;
                info._cabinDiscount =   [[NSString stringWithFormat:@"%@", [dicList objectForKey:@"cabinDiscount"]]intValue];
                info._createTime =   [NSString stringWithFormat:@"%@", [dicList objectForKey:@"createTime"]] ;
                [list addObject: info];
                [info release];
            }
        }
    }
    if ([list count] == 0) {
        return nil;
    }

	return list;
}

//添加机票预约
+ (TicketAppointmentDataResponse *)addReservation:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	TicketAppointmentDataResponse * ticketAppointment = [[[TicketAppointmentDataResponse  alloc] init] autorelease];

	
	ticketAppointment._id = [dic objectForKey:@"id"];

	ticketAppointment._message =  [dic objectForKey:@"message"];
	
	return ticketAppointment;
}

//查询机票预约详情
+ (NSMutableArray *)queryReservationDetail:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	NSArray *appointmentlist = [dic valueForKey:@"reservationDetailList"];
	NSMutableArray *list = [NSMutableArray array];
    if ([appointmentlist isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dicList in appointmentlist) {
            TicketAppointmentDesc *info = [[[TicketAppointmentDesc alloc] init]autorelease];
            
            info._date =  [NSString stringWithFormat:@"%@", [dicList objectForKey:@"date"]] ;
            info._describe = [NSString stringWithFormat:@"%@", [dicList objectForKey:@"describe"]] ;
            
            [list addObject: info];
        }
    }
    if ([list count] == 0) {
        return nil;
    }
	return list;
}


@end


@implementation TicketAppointmentInfo
@synthesize _id,_departure,_arrival,_starteDate,_endDate,_cabinDiscount,_createTime;

-(void)dealloc
{
	self._id = nil;
	self._departure = nil;
	self._arrival = nil;
	self._starteDate = nil;
	self._endDate = nil;
	self._cabinDiscount = 0;
	self._createTime = nil;
	[super dealloc];
}

@end

@implementation TicketAppointmentDesc
@synthesize _date,_describe;

-(void)dealloc
{
    self._date = nil;
	self._describe = nil;
	[super dealloc];
}

@end