//
//  SubmitOrderResponse.m
//  FlightProject
//
//  Created by longcd on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SubmitOrderResponse.h"

@implementation SubmitOrderResponse
@synthesize _shengPZ,_availableLcdCurrency,_returnLcdCurrency,_payment,_orderId,_ticketPriceForChild;
@synthesize _paymentInfo;
-(void) dealloc
{
    self._shengPZ = nil;
    self._availableLcdCurrency = nil;
    self._returnLcdCurrency = nil;
    self._payment = nil;
    self._orderId = nil;
    self._ticketPriceForChild = nil;
    [super dealloc];
}
+ (SubmitOrderResponse *)SubmitOrderResponse:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    SubmitOrderResponse * order = [[SubmitOrderResponse alloc] init];
    order._shengPZ =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"shengPZ"]];
    order._availableLcdCurrency =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"availableLcdCurrency"]];
    order._returnLcdCurrency =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"returnLcdCurrency"]];
    order._payment =  [[NSString stringWithFormat:@"%@",[dic objectForKey:@"payment"]] componentsSeparatedByString:@"&"];
    order._paymentInfo =  [[NSString stringWithFormat:@"%@",[[dic objectForKey:@"paymentInfo"] isKindOfClass:[NSNull class]]?@"":[dic objectForKey:@"paymentInfo"]] componentsSeparatedByString:@"&"];
    order._orderId =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderId"]];
    order._ticketPriceForChild = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"ticketPriceForChild"]] componentsSeparatedByString:@"&"];
    return [order autorelease];
}
@end
