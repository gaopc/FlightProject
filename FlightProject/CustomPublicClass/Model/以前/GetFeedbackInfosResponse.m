//
//  GetFeedbackInfosResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetFeedbackInfosResponse.h"

@implementation FeedbackInfo

@synthesize problem,answer;
-(void)dealloc
{
    self.problem = nil;
    self.answer = nil;
    [super dealloc];
}

@end

@implementation GetFeedbackInfosResponse
+(FeedbackInfo *)getFeedbackInfosResponseWithElem:(NSArray *)elem
{
    FeedbackInfo * info = [[FeedbackInfo alloc] init];
    info.problem = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    info.answer = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    return [info autorelease];

}
+(NSArray *)getFeedbackInfosResponseWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    NSMutableArray * returnArray = nil;
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        returnArray = [[NSMutableArray alloc] init];
        NSArray * dataArray = [resultArray objectAtIndex:1];
        for (NSArray * elem in dataArray) {
            [returnArray addObject:[self getFeedbackInfosResponseWithElem:elem]];
        }
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    return [returnArray autorelease];

}
@end
