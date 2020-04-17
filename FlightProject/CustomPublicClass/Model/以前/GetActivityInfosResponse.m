//
//  GetActivityInfosResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetActivityInfosResponse.h"

@implementation ActivityInfo

@synthesize activityName,nameImgUrl,activityUrl;//,activityStartTime,activityEndTime,activityUpdateTime;
-(void)dealloc
{
    self.activityUrl = nil;
    self.activityName = nil;
    self.nameImgUrl = nil;
//    self.activityUpdateTime = nil;
//    self.activityStartTime = nil;
//    self.activityEndTime = nil;
    [super dealloc];
}

@end

@implementation GetActivityInfosResponse
+(ActivityInfo *)getActivityInfosResponseWithElem:(NSArray *)elem
{
    ActivityInfo * info = [[ActivityInfo alloc] init];
    info.activityName =  [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    info.nameImgUrl =  [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    info.activityUrl =  [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
//    info.activityStartTime =  [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
//    info.activityEndTime =  [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
//    info.activityUpdateTime =  [NSString stringWithFormat:@"%@",[elem objectAtIndex:5]];
    return [info autorelease];
}
+(NSArray *)getActivityInfosResponseWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    NSMutableArray * returnArray = nil;
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        returnArray = [[NSMutableArray alloc] init];
        NSArray * dataArray = [resultArray objectAtIndex:1];
        for (NSArray * elem in dataArray) {
            [returnArray addObject:[self getActivityInfosResponseWithElem:elem]];
        }
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    return [returnArray autorelease];

}
@end
