//
//  AddorUpdateMailingAddressResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AddorUpdateMailingAddressResponse.h"

@implementation AddorUpdateMailingAddressResponse
+(void)addorUpdateMailingAddressResponseWithArray:(NSArray *)resultArray
{
    if ([[resultArray objectAtIndex:0] isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:@"添加成功"];
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
}
@end
