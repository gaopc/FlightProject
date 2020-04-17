//
//  GetFlightDynamicByFlightNo.m
//  FlightProject
//
//  Created by 月 小 on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetFlightDynamicByFlightNo.h"

@implementation TimeInfo
@synthesize plan,forecast,actual;
- (void)dealloc
{
    self.plan = nil;
    self.forecast = nil;
    self.actual = nil;
    [super dealloc];
}
@end

@implementation StopoverInfo
@synthesize departure,arrival,departureCode,arrivalCode,statusCode,startAirport,startTerminal,endAirport,endTerminal,date,takeOffTime,reachTime;
- (void)dealloc
{
    self.departure = nil;
    self.arrival = nil;
    self.departureCode = nil;
    self.arrivalCode = nil;
    self.statusCode = nil;
    self.startAirport = nil;
    self.startTerminal = nil;
    self.endAirport = nil;
    self.endTerminal = nil;
    self.date = nil;
    self.takeOffTime = nil;
    self.reachTime = nil;
    [super dealloc];
}
@end

@implementation GetFlightDynamicByFlightNo
@synthesize attentionId,flightCompany,stopoverInfos,agoFlightNo,agoFlightDesc;
- (void)dealloc
{
    self.attentionId = nil;
    self.flightCompany = nil;
    self.stopoverInfos = nil;
    self.agoFlightNo = nil;
    self.agoFlightDesc = nil;
    [super dealloc];
}
+(GetFlightDynamicByFlightNo *)GetFlightDynamicByFlightNo:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    GetFlightDynamicByFlightNo *flightDynamicByNo = [[GetFlightDynamicByFlightNo alloc] init];
    flightDynamicByNo.attentionId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"attentionId"]];
    flightDynamicByNo.flightCompany = [NSString stringWithFormat:@"%@",[dic objectForKey:@"flightCompang"]];
    flightDynamicByNo.agoFlightNo = [NSString stringWithFormat:@"%@",[dic objectForKey:@"agoFlightNo"]];//[NSString stringWithFormat:@"MU5138"];
    flightDynamicByNo.agoFlightDesc = [NSString stringWithFormat:@"%@",[dic objectForKey:@"agoFlightDesc"]];//[NSString stringWithFormat:@"前序航班MU5138【上海虹桥到北京首都】已于23:48到达"];
    NSMutableArray * firstArray = [NSMutableArray array];
    NSArray * array = [dic objectForKey:@"info"];
    if ([array isKindOfClass:[NSArray class]]) {
        for(NSDictionary * elem in array)
        {
            StopoverInfo *stopoverInfo = [[StopoverInfo alloc] init];
            stopoverInfo.departure = [NSString stringWithFormat:@"%@",[elem objectForKey:@"departure"]];
            stopoverInfo.arrival = [NSString stringWithFormat:@"%@",[elem objectForKey:@"arrival"]];
            stopoverInfo.departureCode = [NSString stringWithFormat:@"%@",[elem objectForKey:@"departureCode"]];
            stopoverInfo.arrivalCode = [NSString stringWithFormat:@"%@",[elem objectForKey:@"arrivalCode"]];
            stopoverInfo.statusCode = [NSString stringWithFormat:@"%@",[elem objectForKey:@"statusCode"]];
            stopoverInfo.startAirport = [NSString stringWithFormat:@"%@",[elem objectForKey:@"startAirport"]];
            stopoverInfo.startTerminal = [NSString stringWithFormat:@"%@",[elem objectForKey:@"startTerminal"]];
            stopoverInfo.endAirport = [NSString stringWithFormat:@"%@",[elem objectForKey:@"endAirport"]];
            stopoverInfo.endTerminal = [NSString stringWithFormat:@"%@",[elem objectForKey:@"endTerminal"]];
            stopoverInfo.date = [NSString stringWithFormat:@"%@",[elem objectForKey:@"date"]];
            TimeInfo *aTimeInfo = [[TimeInfo alloc] init];
            stopoverInfo.takeOffTime = aTimeInfo;
            [aTimeInfo release];
            stopoverInfo.takeOffTime.forecast = [NSString stringWithFormat:@"%@",[[elem objectForKey:@"takeOffTime"] objectForKey:@"forecast"]];
            stopoverInfo.takeOffTime.actual = [NSString stringWithFormat:@"%@",[[elem objectForKey:@"takeOffTime"] objectForKey:@"actual"]];
            ([[[elem objectForKey:@"takeOffTime"] objectForKey:@"plan"] isKindOfClass:[NSNull class]])?(stopoverInfo.takeOffTime.plan = @" "):(stopoverInfo.takeOffTime.plan = [NSString stringWithFormat:@"%@",[[elem objectForKey:@"takeOffTime"] objectForKey:@"plan"]]);
            TimeInfo *sTimeInfo = [[TimeInfo alloc] init];
            stopoverInfo.reachTime = sTimeInfo;
            [sTimeInfo release];
            ([[[elem objectForKey:@"reachTime"] objectForKey:@"plan"] isKindOfClass:[NSNull class]])?(stopoverInfo.reachTime.plan = @" "):(stopoverInfo.reachTime.plan = [NSString stringWithFormat:@"%@",[[elem objectForKey:@"reachTime"] objectForKey:@"plan"]]);
            
            stopoverInfo.reachTime.forecast = [NSString stringWithFormat:@"%@",[[elem objectForKey:@"reachTime"] objectForKey:@"forecast"]];
            stopoverInfo.reachTime.actual = [NSString stringWithFormat:@"%@",[[elem objectForKey:@"reachTime"] objectForKey:@"actual"]];
            [firstArray addObject:stopoverInfo];
            [stopoverInfo release];
        }
    }
    if ([firstArray count] >0) {
        flightDynamicByNo.stopoverInfos = firstArray;
    }
    else{
        flightDynamicByNo.stopoverInfos = nil;
    }
    return [flightDynamicByNo autorelease];
}
@end
