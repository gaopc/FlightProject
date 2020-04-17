//
//  Airlines.m
//  FlightProject
//
//  Created by longcd on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Airlines.h"

@implementation Airlines
@synthesize _airline_code,_airline_png,_airline_name,_airline_name_abbreviation,_airline_telephone;
-(void)dealloc
{
    self._airline_code = nil;
    self._airline_png = nil;
    self._airline_name = nil;
    self._airline_name_abbreviation = nil;
    self._airline_telephone = nil;
    [super dealloc];
}
+(Airlines *) AirlinesWithElem:(NSArray *)array
{
    Airlines * airline = [[Airlines alloc] init];
    airline._airline_code = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    airline._airline_png = [NSString stringWithFormat:@"%@.png",[array objectAtIndex:0]];
    airline._airline_name = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
    airline._airline_name_abbreviation = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
    airline._airline_telephone = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
    return [airline autorelease];
}
+(NSArray *)AirlinesWithArray:(NSArray *)array
{
    NSMutableArray * mArray = [NSMutableArray array];
    [mArray addObject:[self AirlinesWithElem:[NSArray arrayWithObjects:@"",@"不限",@"不限",@"",nil]]];
    for (NSArray * elem in array) {
        [mArray addObject:[self AirlinesWithElem:elem]];
    }
    return mArray;
}
@end
