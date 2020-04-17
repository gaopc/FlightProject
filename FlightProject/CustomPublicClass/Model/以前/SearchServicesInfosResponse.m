//
//  SearchServicesInfosResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchServicesInfosResponse.h"

@implementation IsServiceString

@synthesize lastTicketNo,price,nowPrice,departure,arrival,returnCoin,departureDate;
-(void)dealloc
{
    self.lastTicketNo = nil;
    self.price = nil;
    self.nowPrice = nil;
    self.departure = nil;
    self.arrival = nil;
    self.returnCoin = nil;
    self.departureDate = nil;
    [super dealloc];
}

@end

@implementation NoServiceString

@synthesize lastTicketNo,price,nowPrice,departure,arrival,returnCoin,departureDate;
-(void)dealloc
{
    self.lastTicketNo = nil;
    self.price = nil;
    self.nowPrice = nil;
    self.departure = nil;
    self.arrival = nil;
    self.returnCoin = nil;
    self.departureDate = nil;
    [super dealloc];
}

@end

@implementation SearchServicesInfosResponse
@synthesize coin,isServiceString,noServiceString;
-(void)dealloc
{
    self.coin = nil;
    self.isServiceString = nil;
    self.noServiceString = nil;
    [super dealloc];
}
+(IsServiceString *) searchIsServiceStringWithElem:(NSArray *)elem
{
    IsServiceString * info = [[IsServiceString alloc] init];
    info.lastTicketNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    info.price = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    info.nowPrice = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    info.departure = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    info.arrival = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    info.returnCoin = [NSString stringWithFormat:@"%@",[elem objectAtIndex:5]];
    info.departureDate = [NSString stringWithFormat:@"%@",[elem objectAtIndex:6]];
    return [info autorelease];
}
+(NoServiceString *) searchNoServiceStringWithElem:(NSArray *)elem
{
    NoServiceString * info = [[NoServiceString alloc] init];
    info.lastTicketNo = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    info.price = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    info.nowPrice = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    info.departure = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    info.arrival = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    info.returnCoin = [NSString stringWithFormat:@"%@",[elem objectAtIndex:5]];
    info.departureDate = [NSString stringWithFormat:@"%@",[elem objectAtIndex:6]];
    return [info autorelease];

}
+(SearchServicesInfosResponse *)searchServicesInfosResponseWithDic:(NSDictionary *)resultDic
{
    SearchServicesInfosResponse * instance = nil;
    NSString * result = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"result"]];
    NSString * errorDes = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"errorDescription"]];
    if ([result isEqualToString:@"0"]) {
        instance = [[SearchServicesInfosResponse alloc] init];
        instance.coin =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"coin"]];
        NSMutableArray * isMArray = [[NSMutableArray alloc] init];
        for (NSArray * elem in [resultDic objectForKey:@"isServiceString"]) {
            [isMArray addObject: [self searchIsServiceStringWithElem:elem]];
        }
        instance.isServiceString = isMArray;
        [isMArray release];
        NSMutableArray * noMArray = [[NSMutableArray alloc] init];
        for (NSArray * elem in [resultDic objectForKey:@"noServiceString"]) {
            [noMArray addObject: [self searchNoServiceStringWithElem:elem]];
        }
        instance.isServiceString = noMArray;
        [noMArray release];
    }
    else {
        [UIAlertView alertViewWithMessage:errorDes];
    }
    return  [instance autorelease];
}
@end
