//
//  GetVersionResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetVersionResponse.h"

@implementation GetVersionResponse

+(NSString *) getVersionResponse : (NSArray *)array
{
    NSString * version = nil;
    if ([[array objectAtIndex:0] isEqualToString:@"0"]) {
        version = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
       // [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"国内航线版本: %@",version]];
    }
    else {
        [UIAlertView alertViewWithMessage:[array objectAtIndex:1]];
    }
    return version;
}

@end
