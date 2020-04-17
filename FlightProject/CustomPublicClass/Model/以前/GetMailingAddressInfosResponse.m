//
//  GetMailingAddressInfosResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetMailingAddressInfosResponse.h"

@implementation GetMailingAddressInfosResponse

+(MailPsgInfo *)getMailingAddressInfosResponseWithElem:(NSArray *)elem
{
    MailPsgInfo * MailPsg = [[MailPsgInfo alloc] init];
    MailPsg.mailName = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    MailPsg.postCode = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    MailPsg.postalAddress = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    MailPsg.addressID = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    MailPsg.mobile = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    return [MailPsg autorelease];
    
}
+(NSArray *)getMailingAddressInfosResponseWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    if ([[array objectAtIndex:0] isEqualToString:@"0"]) {
        NSMutableArray * mArray = [[NSMutableArray alloc] init];
        for (int i=1; i<[resultArray count]; i++) {
            [mArray addObject:[self getMailingAddressInfosResponseWithElem:[resultArray objectAtIndex:i]]];
        }
        return [mArray autorelease];
    }
    else {
        [UIAlertView alertViewWithMessage:[array objectAtIndex:1]];
    }
    return nil;
    
}

@end
