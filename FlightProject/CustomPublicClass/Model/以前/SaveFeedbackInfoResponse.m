//
//  SaveFeedbackInfoResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SaveFeedbackInfoResponse.h"

@implementation SaveFeedbackInfoResponse
+(void)saveFeedbackInfoResponseWithArray:(NSArray *)resultArray
{
    if ([[resultArray objectAtIndex:0] isEqualToString:@"0"]) {
        [UIAlertView alertViewWithMessage:@"意见提交成功"];
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
}
@end
