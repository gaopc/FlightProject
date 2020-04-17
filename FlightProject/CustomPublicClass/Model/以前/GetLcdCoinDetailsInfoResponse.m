//
//  GetLcdCoinDetailsInfoResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetLcdCoinDetailsInfoResponse.h"

@implementation LCDCoinDetailInfo

@synthesize lcdCoin,date,inOrOut,source,Ticketno;
-(void)dealloc
{
    self.lcdCoin = nil;
    self.date = nil;
    self.inOrOut = nil;
    self.source = nil;
    self.Ticketno = nil;
    [super dealloc];
}

@end

@implementation GetLcdCoinDetailsInfoResponse
+(LCDCoinDetailInfo *) getLcdCoinDetailsInfoResponseWithArray : (NSArray *)resultArray
{
    LCDCoinDetailInfo * DetailInfo = nil;
    NSArray * array = [resultArray objectAtIndex:0];
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        NSArray * dataArray = [resultArray objectAtIndex:1];
        DetailInfo = [[LCDCoinDetailInfo alloc] init];
        DetailInfo.lcdCoin = [NSString stringWithFormat:@"%@",[dataArray objectAtIndex:0]];
        DetailInfo.date = [NSString stringWithFormat:@"%@",[dataArray objectAtIndex:1]];
        DetailInfo.inOrOut = [NSString stringWithFormat:@"%@",[dataArray objectAtIndex:2]];
        DetailInfo.source = [NSString stringWithFormat:@"%@",[dataArray objectAtIndex:3]];
        DetailInfo.Ticketno = [NSString stringWithFormat:@"%@",[dataArray objectAtIndex:4]];
    }
    else {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:1]]];
    }
    return [DetailInfo autorelease];

}
@end
