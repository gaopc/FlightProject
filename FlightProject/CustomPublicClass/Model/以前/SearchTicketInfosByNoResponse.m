//
//  SearchTicketInfosByNoResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchTicketInfosByNoResponse.h"

@implementation SubSegsInfo

@synthesize totalMoney,fuelTax,airportTax;
-(void)dealloc
{
    self.totalMoney = nil;
    self.fuelTax = nil;
    self.airportTax = nil;
    [super dealloc];
}

@end

@implementation FareMovement

@synthesize movemengtDate,movemengtPrice;
-(void)dealloc
{
    self.movemengtPrice = nil;
    self.movemengtDate = nil;
    [super dealloc];
}

@end

@implementation SearchTicketInfosByNoResponse
@synthesize segsInfos,psgInfos,ltineraryMailInfos,isInsure,fareMovements;
-(void)dealloc
{
    self.segsInfos = nil;
    self.psgInfos = nil;
    self.ltineraryMailInfos = nil;
    self.isInsure = nil;
    self.fareMovements = nil;
    [super dealloc];
}
+(SubSegsInfo *)subSegsInfoWithArray:(NSArray *)array
{
    SubSegsInfo * info = [[SubSegsInfo alloc] init];
    info.flightNo = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    info.airLine = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    info.cabin = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    info.planeType = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
    info.departureDate = [NSString stringWithFormat:@"%@",[array objectAtIndex:4]];
    info.arriveDate = [NSString stringWithFormat:@"%@",[array objectAtIndex:5]];
    info.departure = [NSString stringWithFormat:@"%@",[array objectAtIndex:6]];
    info.arrival = [NSString stringWithFormat:@"%@",[array objectAtIndex:7]];
    info.totalMoney = [NSString stringWithFormat:@"%@",[array objectAtIndex:8]];
    info.cabinDiscount = [NSString stringWithFormat:@"%@",[array objectAtIndex:9]];
    info.fuelTax = [NSString stringWithFormat:@"%@",[array objectAtIndex:10]];
    info.airportTax = [NSString stringWithFormat:@"%@",[array objectAtIndex:11]];
    return [info autorelease];
}
+(PassengerInfomation *)passengerInfomationWithArray:(NSArray *)array
{
    PassengerInfomation * info = [[PassengerInfomation alloc] init];
    info.psgName = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    info.IDType = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    info.IDNo = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    return [info autorelease];
}
+(LtineraryMailInfo *)ltineraryMailInfoWithArray:(NSArray *)array
{
    LtineraryMailInfo * ltinerary = [[LtineraryMailInfo alloc] init];
    ltinerary.getType = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    ltinerary.result = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    switch ([ltinerary.getType intValue]) {
        case 1:
        {
            //ltinerary.getType = @"免费邮寄";
            switch ([ltinerary.result intValue]) {
                case 0:
                    ltinerary.result = @"未邮寄";
                    break;
                case 1:
                    ltinerary.result = @"已邮寄";
                    break;
                case 2:
                    ltinerary.result = @"邮寄丢失";
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            //ltinerary.getType = @"民航自助售票打印";
            switch ([ltinerary.result intValue]) {
                case 0:
                    ltinerary.result = @"未打印";
                    break;
                case 1:
                    ltinerary.result = @"部分打印";
                    break;
                case 2:
                    ltinerary.result = @"全部打印";
                    break;
                default:
                    break;
            }
            
        }
            break;
            
        default:
            break;
    }
    return [ltinerary autorelease];

}
+(NSString *)isInsureWithStr:(NSString *)str
{
    NSString * isInsureStr = nil;
    switch ([str intValue]) {
        case 0:
            isInsureStr = @"未购买";
            break;
        case 1:
            isInsureStr = @"购买了";
            break;
        default:
            break;
    }
    return isInsureStr;
}
+(FareMovement *)fareMovementWithArray:(NSArray *)array
{
    FareMovement * movement = [[FareMovement alloc] init];
    movement.movemengtDate = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    movement.movemengtPrice = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    return [movement autorelease];
}
+(SearchTicketInfosByNoResponse *) searchTicketInfosByNoResponseWithDic:(NSDictionary * ) resultDic
{
    SearchTicketInfosByNoResponse * ticketInfo = nil;
    NSString * result = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"result"]];
    NSString * errorDes = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"errorDescription"]];
    if ([result isEqualToString:@"0"]) {
        ticketInfo = [[SearchTicketInfosByNoResponse alloc] init];
        NSArray * tempSegsInfos = [resultDic objectForKey:@"segsInfos"];
        NSArray * tempPsgInfos = [resultDic objectForKey:@"psgInfos"];
        NSArray * templtineraryMailInfos = [resultDic objectForKey:@"ltineraryMailInfos"];
        NSString * tempisInsure = [resultDic objectForKey:@"isInsure"];
        NSString * tempfareMovements = [resultDic objectForKey:@"fareMovements"];
        ticketInfo.segsInfos = [self subSegsInfoWithArray:tempSegsInfos];
        ticketInfo.psgInfos = [self passengerInfomationWithArray:tempPsgInfos];
        ticketInfo.ltineraryMailInfos = [self ltineraryMailInfoWithArray:templtineraryMailInfos];
        ticketInfo.isInsure = [self isInsureWithStr:tempisInsure];
        NSMutableArray * mArray = [[NSMutableArray alloc] init];
        for (NSString * str in [tempfareMovements componentsSeparatedByString:@"+"]) {
            NSArray * elem = [str componentsSeparatedByString:@";"];
            [mArray addObject:[self fareMovementWithArray:elem]];
        }
        ticketInfo.fareMovements = mArray;
        [mArray release];
    }
    else {
        [UIAlertView alertViewWithMessage:errorDes];
    }
    return [ticketInfo autorelease];
}

@end
