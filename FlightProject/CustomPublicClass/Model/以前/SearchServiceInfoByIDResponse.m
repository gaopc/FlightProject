//
//  SearchServiceInfoByIDResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchServiceInfoByIDResponse.h"

@implementation ServiceDetailInfo

@synthesize serviceID,serviceInfo;
-(void)dealloc
{
    self.serviceID = nil;
    self.serviceInfo = nil;
    [super dealloc];
}

@end


@implementation SearchServiceInfoByIDResponse
+(ServiceDetailInfo *)searchServiceInfoByIDResponseWithElem:(NSArray *)elem
{
    ServiceDetailInfo * info = [[ServiceDetailInfo alloc] init];
    info.serviceID = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    info.serviceInfo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    return [info autorelease];

}
+(NSArray *)searchServiceInfoByIDResponseWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    NSMutableArray * returnArray = nil;
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        returnArray = [[NSMutableArray alloc] init];
        NSArray * dataArray = [resultArray objectAtIndex:1];
        for (NSArray * elem in dataArray) {
            [returnArray addObject:[self searchServiceInfoByIDResponseWithElem:elem]];
        }
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    return [returnArray autorelease];

}
@end
