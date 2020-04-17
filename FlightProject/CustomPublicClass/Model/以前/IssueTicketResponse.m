//
//  IssueTicketResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

@implementation IssueTicketRequest

@synthesize flowNo, cardNo, cvv, telephone, expiredDate, totalMoney, lcdCoin;
@synthesize userId, batchNo, tradeTime, userName;
@synthesize encryptType,bankGateway,identitycard;

@end

@implementation lssueTicket

@synthesize psgName,psgType,idNo,ticketNoList;

-(void)dealloc
{
    self.psgName = nil;
    self.psgType = nil;
    self.idNo = nil;
    self.ticketNoList = nil;
    [super dealloc];
}


@end

@implementation IssueTicketResponse

@synthesize orderID,ticket;

-(void)dealloc
{
    self.orderID = nil;
    self.ticket = nil;
    [super dealloc];
}
+(lssueTicket *) issueTicketResponseWithElem:(NSArray *)elem
{
    lssueTicket * ticket = [[lssueTicket alloc] init];
    ticket.psgName = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    ticket.psgType = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    ticket.idNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    ticket.ticketNoList = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    return [ticket autorelease];
}
+(IssueTicketResponse *)issueTicketResponseWithArray:(NSArray *)resultArray
{
    IssueTicketResponse * instance = nil;
    NSArray * array = [resultArray objectAtIndex:0];
    if ([[array objectAtIndex:0] isEqualToString:@"0"]) { // 支付成功，出票成功
        instance = [[IssueTicketResponse alloc] init];
        instance.orderID = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
        NSArray * dataArray = [resultArray objectAtIndex:1];
        instance.ticket = [self issueTicketResponseWithElem:dataArray];
    }   
    else if ([[array objectAtIndex:0] isEqualToString:@"C0"]) {// 正在支付中。。。。。
         [UIAlertView alertViewWithMessage:@"正在支付中。。。。。"];
    }   
    else if ([[array objectAtIndex:0] isEqualToString:@"00"]) {// 支付成功，出票失败
         [UIAlertView alertViewWithMessage:@"支付成功，出票失败"];
    }   
    else
    {
         [UIAlertView alertViewWithMessage:[array objectAtIndex:1]];
    }
    return [instance autorelease];
}
@end
