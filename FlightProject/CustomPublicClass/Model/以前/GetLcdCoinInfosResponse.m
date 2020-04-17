//
//  GetLcdCoinInfosResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetLcdCoinInfosResponse.h"
@implementation LcdCoinInfo
@synthesize accumulatedLcdCoin,usedLcdCoin,usingLcdCoin,noGetLcdCoin;
-(void)dealloc
{
    self.accumulatedLcdCoin = nil;
    self.usedLcdCoin = nil;
    self.usedLcdCoin = nil;
    self.noGetLcdCoin = nil;
    [super dealloc];
}
@end

@implementation GetLcdCoinInfosResponse
+(LcdCoinInfo *) getLcdCoinInfosResponseWithArray : (NSArray *)resultArray
{
    LcdCoinInfo * lcdCoin = nil;
    if ([[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:0]] isEqualToString:@"0"]) {
        lcdCoin = [[LcdCoinInfo alloc] init];
        lcdCoin.accumulatedLcdCoin = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
        lcdCoin.usedLcdCoin = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:3]];
        lcdCoin.usingLcdCoin = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:4]];
        lcdCoin.noGetLcdCoin = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:5]];
    }
    else {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:1]]];
    }
    return [lcdCoin autorelease];
}
@end
