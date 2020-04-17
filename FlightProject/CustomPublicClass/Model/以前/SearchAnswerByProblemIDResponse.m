//
//  SearchAnswerByProblemIDResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchAnswerByProblemIDResponse.h"

@implementation SearchAnswerByProblemIDResponse
+(NSString *)searchAnswerByProblemIDResponseWithArray:(NSArray *)resultArray
{
    NSString * answer = nil;
    if ([[resultArray objectAtIndex:0] isEqualToString:@"0"]) {
        answer = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    return answer;

}
@end
