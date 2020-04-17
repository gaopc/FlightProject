//
//  AddContactorResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AddContactorResponse.h"

@implementation AddContactorResponse
+(NSString *)addContactorResponseWithArray:(NSArray *)resultArray
{
    NSString * contactorID = nil;
    if ([[resultArray objectAtIndex:0] isEqualToString:@"0"]) {
        contactorID = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"添加成功,常旅客ID为: %@",contactorID]];
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    return contactorID;
}
@end
