//
//  GetCheckCodeResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetCheckCodeResponse.h"

@implementation GetCheckCodeResponse
+(NSString *)getCheckCodeResponseWithArray:(NSArray *)resultArray
{
    NSString * checkCode = nil;
    if ([[resultArray objectAtIndex:0] isEqualToString:@"0"]) {
        checkCode = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    return checkCode;

}
@end
