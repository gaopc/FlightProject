//
//  PayDataClass.m
//  LCDFlight
//
//  Created by longcd on 12-8-9.
//  Copyright (c) 2012年 BeyondSoft. All rights reserved.
//

#import "PayDataClass.h"

@implementation PayDataClass

@end

@implementation GetDealKeyRequest

@synthesize terminalId,orderID,payCoin,payMoney,payType,userID;
-(void)dealloc
{
	self.terminalId = nil;
	self.orderID = nil;
	self.payCoin = nil;
	self.payMoney = nil;
	self.payType = nil;
	self.userID = nil;
	[super dealloc];
}

@end

//@implementation GetDealKeyResponse
//
//@synthesize result,errorDescription,packets;
//-(void)dealloc
//{
//    self.result = nil;
//    self.errorDescription = nil;
//    self.packets = nil;
//    [super dealloc];
//}
//+(NSString *)GetDealKeyResponse:(NSArray *)resultArray
//{
////    NSString * packet = nil;
////    NSArray * array = [resultArray objectAtIndex:0];
////    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"1"] ) {
////        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该订单已经支付。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
////        [alert show];
////        [alert release];
////    }
////    else if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
////        packet =  [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
////    }
////    else if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"3"]){
////        //您有一个支付流程仍未完成，请您取消该支付流程或稍做等待后，再次进行支付
////        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",[array objectAtIndex:1]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
////        [alert show];
////        [alert release];
////    }
////    else {
////        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"订单生成失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
////        [alert show];
////        [alert release];
////    }
////    return packet;
//}
//@end

@implementation GetPaymentInfoRequest

@synthesize terminalId,phonePackets,paymentChannels,times,orderID,userID;
-(void)dealloc
{
	self.terminalId = nil;
	self.phonePackets = nil;
	self.paymentChannels = nil;
	self.times = nil;
	self.orderID = nil;
	self.userID = nil;
	[super dealloc];   
}

@end

@implementation GetPaymentInfoResphonse

@synthesize result,message;
-(void)dealloc
{
	self.result = nil;
	self.message = nil;
	[super dealloc];
}
+(GetPaymentInfoResphonse *) GetPaymentInfoResphonse:(NSDictionary *)resultDic
{
	GetPaymentInfoResphonse * paymentInfo = [[GetPaymentInfoResphonse alloc] init];
	paymentInfo.result  = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"statusCode"]] ;
	paymentInfo.message   = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"message"]];
	return [paymentInfo autorelease];
}
@end