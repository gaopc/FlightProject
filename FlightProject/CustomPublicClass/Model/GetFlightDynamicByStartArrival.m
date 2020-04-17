//
//  GetFlightDynamicByStartArrival.m
//  FlightProject
//
//  Created by 月 小 on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetFlightDynamicByStartArrival.h"

@implementation FlightDynamic3
@synthesize flightCompang,flightLogo,flightNo,departure,arrival,statusName,startAirport,startTerminal,endAirport,endTerminal,takeOffTime,reachTime;
- (void)dealloc
{
    self.flightCompang = nil;
    self.flightLogo = nil;
    self.flightNo = nil;
    self.departure = nil;
    self.arrival = nil;
    self.statusName = nil;
    self.startAirport = nil;
    self.startTerminal = nil;
    self.endAirport = nil;
    self.endTerminal = nil;
    self.takeOffTime = nil;
    self.reachTime = nil;
    [super dealloc];
}

@end
@implementation GetFlightDynamicByStartArrival
@synthesize flightDynamicAry;
- (void)dealloc
{
    self.flightDynamicAry = nil;
    [super dealloc];
}
+(GetFlightDynamicByStartArrival *)getFlightDynamicByStartArrival:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    GetFlightDynamicByStartArrival *flightDynamicBySA = [[GetFlightDynamicByStartArrival alloc] init];
    NSMutableArray *firstArray = [NSMutableArray array];
    NSArray * array = [dic objectForKey:@"flightDynamic"];
    if ([array isKindOfClass:[NSArray class]]) {
        for(NSDictionary *elem in array)
        {
            FlightDynamic3 *flightDynamic = [[FlightDynamic3 alloc] init];
            flightDynamic.flightCompang = [NSString stringWithFormat:@"%@",[elem objectForKey:@"flightCompang"]];
            flightDynamic.flightLogo = [NSString stringWithFormat:@"%@",[elem objectForKey:@"flightLogo"]];
            flightDynamic.flightNo = [NSString stringWithFormat:@"%@",[elem objectForKey:@"flightNo"]];
            flightDynamic.departure = [NSString stringWithFormat:@"%@",[elem objectForKey:@"departure"]];
            flightDynamic.arrival = [NSString stringWithFormat:@"%@",[elem objectForKey:@"arrival"]];
            flightDynamic.statusName = [NSString stringWithFormat:@"%@",[elem objectForKey:@"statusName"]];
            flightDynamic.startAirport = [NSString stringWithFormat:@"%@",[elem objectForKey:@"startAirport"]];
            flightDynamic.startTerminal = [NSString stringWithFormat:@"%@",[elem objectForKey:@"startTerminal"]];
            flightDynamic.endAirport = [NSString stringWithFormat:@"%@",[elem objectForKey:@"endAirport"]];
            flightDynamic.endTerminal = [NSString stringWithFormat:@"%@",[elem objectForKey:@"endTerminal"]];
//            flightDynamic.takeOffTime = [NSString stringWithFormat:@"%@",[elem objectForKey:@"takeOffTime"]];
            TimeInfo *aTimeInfo = [[TimeInfo alloc] init];
            flightDynamic.takeOffTime = aTimeInfo;
            [aTimeInfo release];
            ([[[elem objectForKey:@"takeOffTime"] objectForKey:@"plan"] isEqual:@""])?(flightDynamic.takeOffTime.plan = @" "):(flightDynamic.takeOffTime.plan = [NSString stringWithFormat:@"%@",[[elem objectForKey:@"takeOffTime"] objectForKey:@"plan"]]);
            flightDynamic.takeOffTime.forecast = [NSString stringWithFormat:@"%@",[[elem objectForKey:@"takeOffTime"] objectForKey:@"forecast"]];
            flightDynamic.takeOffTime.actual = [NSString stringWithFormat:@"%@",[[elem objectForKey:@"takeOffTime"] objectForKey:@"actual"]];
            TimeInfo *sTimeInfo = [[TimeInfo alloc] init];
            flightDynamic.reachTime = sTimeInfo;
            [sTimeInfo release];
            ([[[elem objectForKey:@"takeOffTime"] objectForKey:@"plan"] isEqual:@""])?(flightDynamic.reachTime.plan = @" "):(flightDynamic.reachTime.plan = [NSString stringWithFormat:@"%@",[[elem objectForKey:@"reachTime"] objectForKey:@"plan"]]);
            flightDynamic.reachTime.forecast = [NSString stringWithFormat:@"%@",[[elem objectForKey:@"reachTime"] objectForKey:@"forecast"]];
            flightDynamic.reachTime.actual = [NSString stringWithFormat:@"%@",[[elem objectForKey:@"reachTime"] objectForKey:@"actual"]];
            [firstArray addObject:flightDynamic];
            [flightDynamic release];
        }
    }
    if ([firstArray count]>0) {
        flightDynamicBySA.flightDynamicAry = firstArray;
    }
    else{
        flightDynamicBySA.flightDynamicAry = nil;
    }
    return [flightDynamicBySA autorelease];
}
@end
