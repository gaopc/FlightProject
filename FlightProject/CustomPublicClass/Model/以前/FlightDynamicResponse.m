//
//  FlightDynamicResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlightDynamicResponse.h"
@implementation FlightDynamicRequest
@synthesize vDate;
@synthesize vNum;
@synthesize vOrg;
@synthesize vDst;
-(void)dealloc
{
    self.vDate = nil;
    self.vNum = nil;
    self.vOrg = nil;
    self.vDst = nil;
    [super dealloc];
}
@end

@implementation FlightDynamic

@synthesize flightCompany;
@synthesize flightNo;
@synthesize flightDepcode;
@synthesize flightArrcode;
@synthesize flightDep;
@synthesize flightArr;
@synthesize flightDeptimeReady;
@synthesize flightArrtimeReady;
@synthesize flightDeptime;
@synthesize flightArrtime;
@synthesize flightState;
@synthesize flightHTerminal;
@synthesize flightTerminal;
//@synthesize expectedlandingTime;
@synthesize flightDeptimePlan;
@synthesize flightArrtimePlan;
-(void)dealloc
{
    self.flightCompany = nil;
    self.flightNo = nil;
    self.flightDepcode = nil;
    self.flightArrcode = nil;
    self.flightDep = nil;
    self.flightArr = nil;
    self.flightDeptimeReady = nil;
    self.flightArrtimeReady = nil;
    self.flightDeptime = nil;
    self.flightArrtime = nil;
    self.flightState = nil;
    self.flightHTerminal = nil;
    self.flightTerminal = nil;
    self.flightDeptimePlan = nil;
    self.flightArrtimePlan = nil;
    [super dealloc];
}
@end

@implementation FlightDynamicResponse
+(FlightDynamic *)flightDynamicResponseWithElem:(NSArray *)elem
{
    FlightDynamic * dynamic = [[FlightDynamic alloc] init];
    dynamic.flightCompany = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    dynamic.flightNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    dynamic.flightDepcode = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    dynamic.flightArrcode = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    dynamic.flightDep = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    dynamic.flightArr = [NSString stringWithFormat:@"%@",[elem objectAtIndex:5]];
    dynamic.flightDeptimeReady = [NSString stringWithFormat:@"%@",[elem objectAtIndex:6]];
    if ([dynamic.flightDeptimeReady isEqualToString:@"false"]) {
        dynamic.flightDeptimeReady = @"";
    }
    dynamic.flightArrtimeReady = [NSString stringWithFormat:@"%@",[elem objectAtIndex:7]];
    if ([dynamic.flightArrtimeReady isEqualToString:@"false"]) {
        dynamic.flightArrtimeReady = @"";
    }
    dynamic.flightDeptime = [NSString stringWithFormat:@"%@",[elem objectAtIndex:8]];
    if ([dynamic.flightDeptime isEqualToString:@"false"]) {
        dynamic.flightDeptime = @"";
    }
    dynamic.flightArrtime = [NSString stringWithFormat:@"%@",[elem objectAtIndex:9]];
    if ([dynamic.flightArrtime isEqualToString:@"false"]) {
        dynamic.flightArrtime = @"";
    }
    dynamic.flightState = [NSString stringWithFormat:@"%@",[elem objectAtIndex:10]];
    dynamic.flightHTerminal = [NSString stringWithFormat:@"%@",[elem objectAtIndex:11]];
    if ([dynamic.flightHTerminal isEqualToString:@"false"]) {
        dynamic.flightHTerminal = @"";
    }
    dynamic.flightTerminal = [NSString stringWithFormat:@"%@",[elem objectAtIndex:12]];
    if ([dynamic.flightTerminal isEqualToString:@"false"]) {
        dynamic.flightTerminal = @"";
    }
    dynamic.flightDeptimePlan = [NSString stringWithFormat:@"%@",[elem objectAtIndex:13]];
    dynamic.flightArrtimePlan = [NSString stringWithFormat:@"%@",[elem objectAtIndex:14]];
    return [dynamic autorelease];
}
+(NSArray *)flightDynamicResponseWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    NSMutableArray * returnArray = nil;
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        returnArray = [[NSMutableArray alloc] init];
        for (int i=1; i< [resultArray count]; i++) {
            NSArray * elem = [resultArray objectAtIndex:i];
            [returnArray addObject:[self flightDynamicResponseWithElem:elem]];
        }
    }
    else {
        [UIAlertView alertViewWithMessage:[array objectAtIndex:1]];
    }
    return [returnArray autorelease];
}
@end
