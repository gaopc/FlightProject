//
//  SearchConnectFlightsBriefInfoResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchConnectFlightsBriefInfoResponse.h"
@implementation SearchConnectFlightsBriefInfoRequest
@synthesize dptCity,transit,arrCity,departureDate;
-(void)dealloc
{

    self.dptCity = nil;
    self.transit = nil;
    self.arrCity = nil;
    self.departureDate = nil;
    [super dealloc];
}

@end


@implementation SearchConnectFlightsBriefInfoResponse

@synthesize legNum;

-(void)dealloc
{
    self.legNum = nil;
    [super dealloc];
}
+(SearchConnectFlightsBriefInfoResponse *)searchConnectFlightsBriefInfoResponseWithElem:(NSArray *)elem
{
    SearchConnectFlightsBriefInfoResponse * briefInfo = [[SearchConnectFlightsBriefInfoResponse alloc] init];
    briefInfo.airLine = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    briefInfo.flightNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    briefInfo.startAirPort = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    briefInfo.departureTime = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    briefInfo.endAirPort = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    briefInfo.arrivalTime = [NSString stringWithFormat:@"%@",[elem objectAtIndex:5]];
    briefInfo.stopNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:6]];
    briefInfo.stopCity = [NSString stringWithFormat:@"%@",[elem objectAtIndex:7]];
    briefInfo.isFood = [NSString stringWithFormat:@"%@",[elem objectAtIndex:8]];
    briefInfo.isCodeShare = [NSString stringWithFormat:@"%@",[elem objectAtIndex:9]];
    briefInfo.carrier = [NSString stringWithFormat:@"%@",[elem objectAtIndex:10]];
    briefInfo.planeType = [NSString stringWithFormat:@"%@",[elem objectAtIndex:11]];
    briefInfo.fullPrice = [NSString stringWithFormat:@"%@",[elem objectAtIndex:12]];
    
    NSMutableArray *citems = [[NSMutableArray alloc] init];
    NSString *cis = [NSString stringWithFormat:@"%@",[elem objectAtIndex:13]];//舱位相关数据
    NSArray *cia = [cis componentsSeparatedByString:@"+"];//各个航班存进来
    for (NSString *ci in cia) {
        ci = [ci stringByReplacingOccurrencesOfString:@";;" withString:@";"];
        NSArray *cit = [ci componentsSeparatedByString:@";"];
        if ([cit count] >= 6) {
            CabinItem *cabinItem = [[CabinItem alloc] init];
            cabinItem.cabinNO = [cit objectAtIndex:0];//舱位代码
            cabinItem.sits = [cit objectAtIndex:1];//剩余座位数
            cabinItem.discount = [cit objectAtIndex:2];//折扣率
            cabinItem.baseCabin = [cit objectAtIndex: 3];//基准舱位
            cabinItem.moneyType = [cit objectAtIndex:4];//货币类型
            cabinItem.oneWayPrice = [cit objectAtIndex:5];//单程价格（折扣价）
            cabinItem.cabinType = [cit objectAtIndex: 6];//舱位类型(0为正常折扣舱位,1为单程特价舱位,2是往返特价舱位)
            if ([cit count] > 7) 
                cabinItem.specialFlightNum = ([cit objectAtIndex: 7]==[NSNull null]?@"":[cit objectAtIndex: 7]);
            else cabinItem.specialFlightNum = @"";
            if ([cit count] > 8) {
                cabinItem.specialBaseCabin = [cit objectAtIndex: 7];
            }
            else cabinItem.specialBaseCabin = @"";
            
            [citems addObject:cabinItem];
            [cabinItem release];
        }
    }
    //排序
    for(int i=0;i<[citems count];i++)
    {
        CabinItem *cabinItem =[[citems objectAtIndex:i] retain];
        if([cabinItem.cabinNO isEqualToString:@"F"])
        {
            [citems removeObjectAtIndex:i];
            [citems insertObject:cabinItem atIndex:[citems count]];
        }
        [cabinItem release];
    }
    briefInfo.cabinItems = citems;
    [citems release];
    
    briefInfo.flightDelay = [NSString stringWithFormat:@"%@",[elem objectAtIndex:14]];
    briefInfo.SflightTerminal = [NSString stringWithFormat:@"%@",[elem objectAtIndex:15]];
    briefInfo.EflightTerminal = [NSString stringWithFormat:@"%@",[elem objectAtIndex:16]];
    briefInfo.legNum = [NSString stringWithFormat:@"%@",[elem objectAtIndex:17]];
    
    return [briefInfo autorelease];
}
+(NSArray *)searchConnectFlightsBriefInfoResponseFirstWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    NSMutableArray * returnArray = nil;
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        if ([resultArray count]==1) {
            //[UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[array objectAtIndex:1]]];
            return nil;
        }
        
        returnArray = [[NSMutableArray alloc] init];
        for (int i = 1; i< [resultArray count]; i++) 
        {
            NSArray * elem = [resultArray objectAtIndex:i];
            if ( [[NSString stringWithFormat:@"%@",[elem objectAtIndex:17]] isEqualToString:@"0"])  // 航程1
            {
                [returnArray addObject:[self searchConnectFlightsBriefInfoResponseWithElem:elem]];
            }
        }
    }
    else {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[array objectAtIndex:1]]];
    }
    return [returnArray autorelease];
}
+(NSArray *)searchConnectFlightsBriefInfoResponseSecondWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    NSMutableArray * returnArray = nil;
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        if ([resultArray count]==1) {
           // [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[array objectAtIndex:1]]];
            return nil;
        }
        
        returnArray = [[NSMutableArray alloc] init];
        for (int i = 1; i< [resultArray count]; i++) 
        {
            NSArray * elem = [resultArray objectAtIndex:i];
            if ( [[NSString stringWithFormat:@"%@",[elem objectAtIndex:17]] isEqualToString:@"1"])  // 航程1
            {
                [returnArray addObject:[self searchConnectFlightsBriefInfoResponseWithElem:elem]];
            }
        }
        
    }
    else {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[array objectAtIndex:1]]];
    }
    return [returnArray autorelease];

}

@end
