//
//  SearchRuleResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchRuleResponse.h"
@implementation SearchRuleReques
@synthesize airCode,cabin,flightStartTime;
-(void)dealloc
{
    self.airCode = nil;
    self.cabin = nil;
    self.flightStartTime = nil;
    [super dealloc];
}
@end


@implementation SearchRuleResponse

+(NSString *)searchRuleResponseWithArray:(NSArray * ) resultArray
{
    NSString * rules = nil;
    NSString * resultFlag = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:0]];
    NSString * errorDes = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:1]];
    if ([resultFlag isEqualToString:@"0"]) {
        rules = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
    }
    else {
        [UIAlertView alertViewWithMessage:errorDes];
    }
    return rules;
}
@end
