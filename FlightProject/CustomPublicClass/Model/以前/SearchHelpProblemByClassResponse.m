//
//  SearchHelpProblemByClassResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchHelpProblemByClassResponse.h"

@implementation HelpProblem

@synthesize problem,problemID;
-(void)dealloc
{
    self.problem = nil;
    self.problemID = nil;
    [super dealloc];
}

@end

@implementation SearchHelpProblemByClassResponse
+(HelpProblem *)searchHelpProblemByClassResponseWithElem:(NSArray *)elem
{
    HelpProblem * info = [[HelpProblem alloc] init];
    info.problem = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    info.problem = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    return [info autorelease];
}
+(NSArray *)searchHelpProblemByClassResponseWithArray:(NSArray *)resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    NSMutableArray * returnArray = nil;
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        returnArray = [[NSMutableArray alloc] init];
        NSArray * dataArray = [resultArray objectAtIndex:1];
        for (NSArray * elem in dataArray) {
            [returnArray addObject:[self searchHelpProblemByClassResponseWithElem:elem]];
        }
    }
    else {
        [UIAlertView alertViewWithMessage:[resultArray objectAtIndex:1]];
    }
    return [returnArray autorelease];

}
@end
