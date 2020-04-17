//
//  GetRouteMapRequest.m
//  FlightProject
//
//  Created by longcd on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetRouteMapRequest.h"

@implementation GetRouteMapRequest
+(void) getRouteMapResponseeWithArray:(NSArray * ) resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        // 存入数据库
        NSRange range = {1,[resultArray count] -1};
        [DataClass insertintoDirectCityWithArray:[resultArray subarrayWithRange:range]];

    }
    else {
        NSLog(@"%@",[NSString stringWithFormat:@"%@",[array objectAtIndex:1]]);
    }
}

@end
