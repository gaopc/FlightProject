//
//  SearchPayBankResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchPayBankResponse.h"

@implementation PayBank

@synthesize bankName,bankGateway,bankID;
-(void)dealloc
{
    self.bankName = nil;
    self.bankGateway = nil;
    self.bankID = nil;
    [super dealloc];
}

@end

@implementation SearchPayBankResponse
+(PayBank *) searchPayBankWithElem:(NSArray *)elem
{
    PayBank * bank = [[PayBank alloc] init];
    bank.bankName = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    bank.bankGateway = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    bank.bankID = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    return [bank autorelease];
}
+(NSArray *)searchPayBankWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    NSMutableArray * returnArray = nil;
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        returnArray = [[NSMutableArray alloc] init];
        for (NSArray * elem in [resultArray objectAtIndex:1]) {
            [returnArray addObject:[self searchPayBankWithElem:elem]];
        }
    }
    else {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[array objectAtIndex:1]] ];
    }
    return [returnArray autorelease];
}
@end
