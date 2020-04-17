//
//  GetContactorInfosResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetContactorInfosResponse.h"

@implementation GetContactorInfosResponse

+(ContactorInfo *)getContactorInfosResponseWithElem:(NSArray *)elem
{
    ContactorInfo * creditCardInfo = [[ContactorInfo alloc] init];
    creditCardInfo.contactorName = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    creditCardInfo.contactorMobile = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    creditCardInfo.contactorTelephone = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    creditCardInfo.contactorID = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    return [creditCardInfo autorelease];
}
+(NSArray *)getContactorInfosResponseWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    if ([[array objectAtIndex:0] isEqualToString:@"0"]) {
        NSMutableArray * mArray = [[NSMutableArray alloc] init];
        for (int i=1; i<[resultArray count]; i++) {
            [mArray addObject:[self getContactorInfosResponseWithElem:[resultArray objectAtIndex:i]]];
        }
        return [mArray autorelease];
    }
    else {
        [UIAlertView alertViewWithMessage:[array objectAtIndex:1]];
    }
    return nil;

}
@end
