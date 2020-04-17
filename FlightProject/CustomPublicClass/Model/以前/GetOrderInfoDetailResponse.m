//
//  GetOrderInfoResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetOrderInfoDetailResponse.h"
@implementation LtineraryMailInfo
@synthesize orderID,getType,result;
-(void)dealloc
{
    self.orderID = nil;
    self.getType = nil;
    self.result = nil;
    [super dealloc];
}
@end

@implementation PayInfo
@synthesize orderId,isPay,cardId,payPrice,payTime;
-(void)dealloc
{
    self.orderId = nil;
    self.isPay = nil;
    self.cardId = nil;
    self.payPrice = nil;
    self.payTime = nil;
    [super dealloc];
}
@end

@implementation LCDCoinInfo
@synthesize lcdCoin,waitLcdCoin;
-(void)dealloc
{
    self.lcdCoin = nil;
    self.waitLcdCoin = nil;
    [super dealloc];
}
@end

@implementation AcceptServicesInfo
@synthesize ticketNo,isAccept,status;
-(void)dealloc
{
    self.ticketNo = nil;
    self.isAccept = nil;
    self.status = nil;
    [super dealloc];
}
@end

@implementation TicketInfo
@synthesize ticketNo,ticketStatus,passengeName,psgType,psgIdno,flightSite;
-(void)dealloc
{
    self.ticketNo = nil;
    self.ticketStatus = nil;
    self.passengeName = nil;
    self.psgType = nil;
    self.psgIdno = nil;
    self.flightSite = nil;
    [super dealloc];
}
@end

@implementation OrderInfoDetail

@synthesize psgInfos,segsInfos,contactorInfo,ticketInfos,ltineraryMailInfos,lcdCoinInfos,payInfo,acceptSevicesInfos;
-(void)dealloc
{
    self.psgInfos = nil;
    self.segsInfos = nil;
    self.contactorInfo = nil;
    self.ticketInfos = nil;
    self.ltineraryMailInfos = nil;
    self.lcdCoinInfos = nil;
    self.payInfo = nil;
    self.acceptSevicesInfos = nil;
    [super dealloc];
}


@end

@implementation GetOrderInfoDetailResponse


+(PassengerInfo *)getPassengerInfoWithElem:(NSArray *)elem
{
    PassengerInfo * passenger = [[PassengerInfo alloc] init];
    passenger.psgName = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    passenger.psgType = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    passenger.IDType = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    passenger.IDNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    passenger.birthday = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    passenger.airlineMileageCard = [NSString stringWithFormat:@"%@",[elem objectAtIndex:5]];
    passenger.psgMileageCard = [NSString stringWithFormat:@"%@",[elem objectAtIndex:6]];
    passenger.contactPhone = [NSString stringWithFormat:@"%@",[elem objectAtIndex:7]];
    passenger.totalMoney = [NSString stringWithFormat:@"%@",[elem objectAtIndex:8]];
    passenger.fuelTax = [NSString stringWithFormat:@"%@",[elem objectAtIndex:9]];
    passenger.airportTax = [NSString stringWithFormat:@"%@",[elem objectAtIndex:10]];
    passenger.insuranceCount = [NSString stringWithFormat:@"%@",[elem objectAtIndex:11]];
    passenger.insuranceMoney = [NSString stringWithFormat:@"%@",[elem objectAtIndex:12]];
    passenger.returnTotalMoney = [NSString stringWithFormat:@"%@",[elem objectAtIndex:13]];
    passenger.returnFuelTax = [NSString stringWithFormat:@"%@",[elem objectAtIndex:14]];
    passenger.returnAirportTax = [NSString stringWithFormat:@"%@",[elem objectAtIndex:15]];
    return [passenger autorelease];
}
+(SegsInfo *)getSegsInfoWithElem:(NSArray *)elem
{
    SegsInfo * segInfo = [[SegsInfo alloc] init];
    segInfo.departure = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    segInfo.arrival = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    segInfo.departureDate = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    segInfo.cabin = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    segInfo.baseCabin = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    segInfo.airLine = [NSString stringWithFormat:@"%@",[elem objectAtIndex:5]];
    segInfo.flightNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:6]];
    segInfo.specialFlightNum = [NSString stringWithFormat:@"%@",[elem objectAtIndex:7]];
    segInfo.arriveDate = [NSString stringWithFormat:@"%@",[elem objectAtIndex:8]];
    segInfo.cabinDiscount = [NSString stringWithFormat:@"%@",[elem objectAtIndex:9]];
    segInfo.planeType = [NSString stringWithFormat:@"%@",[elem objectAtIndex:10]];
    return [segInfo autorelease];
}
+(LtineraryMailInfo *)getLtineraryMailInfoWithElem:(NSArray *)elem
{
    LtineraryMailInfo * ltinerary = [[LtineraryMailInfo alloc] init];
    ltinerary.orderID = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    ltinerary.getType = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    ltinerary.result = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
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
+(LCDCoinInfo *)getLCDCoinInfoWithElem:(NSArray *)elem
{
    LCDCoinInfo * coinInfo = [[LCDCoinInfo alloc] init];
    coinInfo.lcdCoin = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    coinInfo.waitLcdCoin =  [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    return [coinInfo autorelease];
}
+(AcceptServicesInfo *)getAcceptServicesInfoWithElem:(NSArray *)elem
{
    AcceptServicesInfo * servicesInfo = [[AcceptServicesInfo alloc] init];
    servicesInfo.ticketNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    servicesInfo.isAccept = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
     servicesInfo.status = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    return [servicesInfo autorelease];
}
+(ContactorInfo *)getContactorInfoWithElem:(NSArray *)elem
{
    ContactorInfo * contactor = [[ContactorInfo alloc] init];
    contactor.contactorName = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    contactor.contactorMobile = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    contactor.contactorTelephone = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    return [contactor autorelease];
}
+(PayInfo *)getPayInfoWithElem:(NSArray *)elem
{
    PayInfo * payInfo = [[PayInfo alloc] init];
    payInfo.orderId = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    payInfo.isPay = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    switch ([payInfo.isPay intValue]) {
        case 0:
            payInfo.isPay = @"未支付";
            payInfo.cardId = @"";
            payInfo.payPrice = @"";
            payInfo.payTime = @"";
            break;
        case 1:
            payInfo.isPay = @"已支付";
            payInfo.cardId = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
            payInfo.payPrice = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
            payInfo.payTime = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
            break;
        default:
            break;
    }
    
    return [payInfo autorelease];
}
+(TicketInfo *)getTicketInfoWithElem:(NSArray *)elem
{
    TicketInfo * ticket = [[TicketInfo alloc] init];
    ticket.ticketNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    ticket.ticketStatus = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    ticket.passengeName = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    ticket.psgType = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    ticket.psgIdno = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    ticket.flightSite = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    switch ([ticket.ticketStatus intValue]) {
        case 0:
            ticket.ticketStatus = @"正常（可退）";
            break;
        case 1:
            ticket.ticketStatus = @"已退票";
            break;
        case 2:
            ticket.ticketStatus = @"退票申请中";
            break;
        case 3:
            ticket.ticketStatus = @"已使用";
            break;
        case 4:
            ticket.ticketStatus = @"其他";
            break;
        default:
            break;
    }
    switch ([ticket.flightSite intValue]) {
        case 0:
            ticket.flightSite= @"去程";
            break;
        case 1:
            ticket.flightSite= @"返程";
            break;
        default:
            break;
    }
    return [ticket autorelease];
}
+(OrderInfoDetail *)getOrderInfoDetailResponseWithArray:(NSDictionary *)resultDic
{
    NSString * result = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"result"]];
    NSString * errorDes = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"errorDescription"]];
    OrderInfoDetail * instance = nil;
    if ([result isEqualToString:@"0"]) {
        instance = [[OrderInfoDetail alloc] init];
        
        NSArray * resultPassengers = [resultDic objectForKey:@"psgInfos"];
        NSMutableArray * passengerArray = [[NSMutableArray alloc] init];
        for (NSArray * elem in resultPassengers) {
            [passengerArray addObject:[self getPassengerInfoWithElem:elem]];
        }
        instance.psgInfos = passengerArray;
        [passengerArray release];
        
        NSArray * resultSegs = [resultDic objectForKey:@"segsInfos"];
        NSMutableArray * segsArray = [[NSMutableArray alloc] init];
        for (NSArray * elem in resultSegs) {
            [segsArray addObject:[self getPassengerInfoWithElem:elem]];
        }
        instance.segsInfos = segsArray;
        [segsArray release];
        
        NSArray * resultLtinerary = [resultDic objectForKey:@"ltineraryMailInfos"];
        instance.ltineraryMailInfos = [self getLtineraryMailInfoWithElem:resultLtinerary];
        
        NSArray * resultLcdCoin = [resultDic objectForKey:@"lcdCoinInfos"];
        instance.lcdCoinInfos = [self getLCDCoinInfoWithElem:resultLcdCoin] ;
        
        NSArray * resultAcceptSevices = [resultDic objectForKey:@"acceptSevicesInfos"];
        NSMutableArray * acceptSevicesArray = [[NSMutableArray alloc] init];
        for (NSArray * elem in resultAcceptSevices) {
            [acceptSevicesArray addObject:[self getAcceptServicesInfoWithElem:elem]];
        }
        instance.acceptSevicesInfos = acceptSevicesArray;
        [acceptSevicesArray release];

        NSArray * resultContactor = [resultDic objectForKey:@"contactorInfo"];
        instance.contactorInfo = [self getContactorInfoWithElem:resultContactor];
        
        NSArray * resultPayInfo = [resultDic objectForKey:@"payInfo"];
        instance.payInfo = [self getPayInfoWithElem:resultPayInfo];
        
        NSArray * resultTicketInfos = [resultDic objectForKey:@"ticketInfos"];
        NSMutableArray * ticketInfoArray = [[NSMutableArray alloc] init];
        for (NSArray * elem in resultTicketInfos) {
            [ticketInfoArray addObject:[self getTicketInfoWithElem:elem]];
        }
        instance.ticketInfos = ticketInfoArray;
        [ticketInfoArray release];
    }
    else {
        [UIAlertView alertViewWithMessage:errorDes];
    }
    return [instance autorelease];
}
@end
