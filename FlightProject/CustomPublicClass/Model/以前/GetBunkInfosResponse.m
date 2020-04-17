//
//  GetBunkInfosResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetBunkInfosResponse.h"

@implementation BunkInfo

@synthesize airport_code,cabin_code,cabin_name,standard_cabin_code;
-(void)dealloc
{
    self.airport_code = nil;
    self.cabin_code = nil;
    self.cabin_name = nil;
    self.standard_cabin_code = nil;
    [super dealloc];
}

@end

@implementation GetBunkInfosResponse
+(BunkInfo *)bunkInfoWithArray:(NSArray *)array
{
    BunkInfo * info = [[BunkInfo alloc] init];
    info.airport_code = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    info.cabin_code = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    info.cabin_name = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    info.standard_cabin_code = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
    return [info autorelease];
}
+(NSArray *) getBunkInfosResponseeWithArray:(NSArray * ) resultArray
{
    NSArray * array = [resultArray objectAtIndex:0];
    NSMutableArray * returnArray = nil;
    if ([[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] isEqualToString:@"0"]) {
        // 存入数据库
        NSRange range = {1,[resultArray count] -1};
        [DataClass insertintoBunk_infoWithArray:[resultArray subarrayWithRange:range]];
        
        returnArray = [[NSMutableArray alloc] init];
        for (int i = 1; i < [resultArray count];i++) {
            [returnArray addObject:[self bunkInfoWithArray:[resultArray objectAtIndex:i]]];
        }
    }
    else {
        NSLog(@"%@",[NSString stringWithFormat:@"%@",[array objectAtIndex:1]]);
    }
    return [returnArray autorelease];
}
@end
