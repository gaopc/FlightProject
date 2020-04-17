//
//  getEnfantPriceResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetEnfantPriceResponse.h"
@implementation GetEnfantPriceReques
@synthesize cabin,baseCabin,price;
-(void)dealloc
{
    self.cabin = nil;
    self.baseCabin = nil;
    self.price = nil;
    [super dealloc];
}
@end

@implementation GetEnfantPriceResponse

+(NSString *)GetEnfantPriceResponseWithArray:(NSArray * ) resultArray
{
    NSString * enfantPrice = nil;
    NSString * resultFlag = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:0]];
    NSString * errorDescription = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:1]];
    if ([resultFlag isEqualToString:@"0"]) {
        enfantPrice = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
    }
    else {
        [UIAlertView alertViewWithMessage:errorDescription];
    }
    return enfantPrice;
}
@end
