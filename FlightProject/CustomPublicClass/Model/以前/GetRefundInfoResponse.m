//
//  GetRefundInfoResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetRefundInfoResponse.h"

@implementation RefundInfo

@synthesize ticketNo,totalPrice,refundPrice,refundPriceP,refundCoin,refundMoney;
-(void)dealloc
{
    self.ticketNo = nil;
    self.totalPrice = nil;
    self.refundPrice = nil;
    self.refundPriceP = nil;
    self.refundCoin = nil;
    self.refundMoney = nil;
    [super dealloc];
}


@end

@implementation GetRefundInfoResponse
+(RefundInfo *) getRefundInfoResponseWithElem:(NSArray *)elem
{
    RefundInfo * refundInfo = [[RefundInfo alloc] init];
    refundInfo.ticketNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    refundInfo.totalPrice = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    refundInfo.refundPrice = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    refundInfo.refundPriceP = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    refundInfo.refundCoin = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    refundInfo.refundMoney = [NSString stringWithFormat:@"%@",[elem objectAtIndex:5]];
    return [refundInfo autorelease];

}
+(NSArray *)getRefundInfoResponseWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    NSMutableArray * returnArray = nil;
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        returnArray = [[NSMutableArray alloc] init];
        for (NSArray * elem in [resultArray objectAtIndex:1]) {
            [returnArray addObject:[self getRefundInfoResponseWithElem:elem]];
        }
    }
    else {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[array objectAtIndex:1]] ];
    }
    return [returnArray autorelease];
}
@end
