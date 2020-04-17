//
//  GetCreditCardInfosResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetCreditCardInfosResponse.h"

@implementation GetCreditCardInfosResponse

@synthesize cardID,useName,certNum,bankID,bankName,bankGateway;
-(void)dealloc
{
    self.cardID = nil;
    self.useName = nil;
    self.certNum = nil;
    self.bankID = nil;
    self.bankName = nil;
    self.bankGateway = nil;
    [super dealloc];
}


+(GetCreditCardInfosResponse *)getCreditCardInfosResponseWithElem:(NSArray *)elem
{
    GetCreditCardInfosResponse * creditCardInfo = [[GetCreditCardInfosResponse alloc] init];
    creditCardInfo.cardID = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    creditCardInfo.useName = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    creditCardInfo.certNum = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    creditCardInfo.bankID = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    creditCardInfo.bankName = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    creditCardInfo.bankGateway = [NSString stringWithFormat:@"%@",[elem objectAtIndex:5]];
    return [creditCardInfo autorelease];
}
+(NSArray *)getCreditCardInfosResponseWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    if ([[array objectAtIndex:0] isEqualToString:@"0"]) {
        NSMutableArray * mArray = [[NSMutableArray alloc] init];
        for (int i=1; i<[resultArray count]; i++) {
            [mArray addObject:[self getCreditCardInfosResponseWithElem:[resultArray objectAtIndex:i]]];
        }
        return [mArray autorelease];
    }
    else {
        [UIAlertView alertViewWithMessage:[array objectAtIndex:1]];
    }
    return nil;
}
@end
