//
//  GetMyAttentionList.m
//  FlightProject
//
//  Created by 月 小 on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetMyAttentionList.h"


@implementation MyAttention
@synthesize ids,flightCompang,flightLogo,flightNo,departure,arrival;
- (void)dealloc
{
    self.ids = nil;
    self.flightCompang = nil;
    self.flightLogo = nil;
    self.flightNo = nil;
    self.departure = nil;
    self.arrival = nil;
    [super dealloc];
}
@end

@implementation GetMyAttentionList
@synthesize myAttentionList;
- (void)dealloc
{
    self.myAttentionList = nil;
    [super dealloc];
}
+(GetMyAttentionList*)getMyAttentionList:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    GetMyAttentionList *attentionList = [[GetMyAttentionList alloc] init];
    NSMutableArray *firstArray = [NSMutableArray array];
    NSArray * array = [dic objectForKey:@"myAttentionList"];
    if ([array isKindOfClass:[NSArray class]]) {
        for(NSDictionary *elem in array)
        {
            MyAttention *myAttention = [[MyAttention alloc] init];
            myAttention.ids = [NSString stringWithFormat:@"%@",[elem objectForKey:@"id"]];
            myAttention.flightCompang = [NSString stringWithFormat:@"%@",[elem objectForKey:@"flightCompang"]];
            myAttention.flightLogo = [NSString stringWithFormat:@"%@",[elem objectForKey:@"flightLogo"]];
            myAttention.flightNo = [NSString stringWithFormat:@"%@",[elem objectForKey:@"flightNo"]];
            ([[elem objectForKey:@"departure"] isKindOfClass:[NSNull class]])?(myAttention.departure = @" "):(myAttention.departure = [NSString stringWithFormat:@"%@",[elem objectForKey:@"departure"]]);
            ([[elem objectForKey:@"arrival"] isKindOfClass:[NSNull class]])?(myAttention.arrival = @" "):(myAttention.arrival = [NSString stringWithFormat:@"%@",[elem objectForKey:@"arrival"]]);
            [firstArray addObject:myAttention];
            [myAttention release];
        }
    }
    if ([firstArray count]>0) {
        attentionList.myAttentionList = firstArray;
    }
    else{
        attentionList.myAttentionList = nil;
    }
    return [attentionList autorelease];
}
@end
