//
//  MakeReservationResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MakeReservationResponse.h"

@implementation MakeReservationRequst
@synthesize passengers, segsInfo, outTimeLimit, flightType;
@synthesize isSpecialFlight, mailinfo, contactorInfo, isAcceptSevice, userID;
@synthesize getItinerary;
-(void)dealloc
{
    self.passengers = nil;
    self.segsInfo = nil;
    self.outTimeLimit = nil;
    self.flightType = nil;
    self.isAcceptSevice = nil;
    self.isSpecialFlight = nil;
    self.mailinfo = nil;
    self.contactorInfo = nil;
    self.isAcceptSevice = nil;
    self.getItinerary = nil;
    [super dealloc];
}

@end

@implementation PNRInfo

@synthesize pnrID,pnrNo,pnrType,orderind;
-(void)dealloc
{
    self.pnrID = nil;
    self.pnrNo = nil;
    self.pnrType = nil;
    self.orderind = nil;
    [super dealloc];
}


@end

@implementation MakeReservationResponse

@synthesize shengPZ,flowNo,pnrInfo;
-(void)dealloc
{
    self.shengPZ = nil;
    self.flowNo = nil;
    self.pnrInfo = nil;
    [super dealloc];
}

+(PNRInfo *) makeReservationResponseWithElem:(NSArray *)elem
{
    PNRInfo * Instance = [[PNRInfo alloc] init];
    Instance.pnrID =[NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    Instance.pnrNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    Instance.pnrType = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    Instance.orderind = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    return [Instance autorelease];
}

+(MakeReservationResponse *)makeReservationResponseWithArray:(NSArray *)resultArray
{    
    NSArray * array = [resultArray objectAtIndex:0];
    MakeReservationResponse * instance = nil;
    NSString * result = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    NSString * errorDes = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    NSString * shengpz =  [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    if ([result isEqualToString:@"0"]) {
        instance = [[MakeReservationResponse alloc] init];
        instance.flowNo =  [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
        NSArray * dataArray = [resultArray objectAtIndex:1];
        instance.pnrInfo = [self makeReservationResponseWithElem:[dataArray objectAtIndex:4]];
    }
    else {
        if ([result isEqualToString:@"-10003"]) {
             instance = [[MakeReservationResponse alloc] init];
            instance.shengPZ = shengpz;
        }
        [UIAlertView alertViewWithMessage:errorDes];
    }
    return [instance autorelease];
}
@end
