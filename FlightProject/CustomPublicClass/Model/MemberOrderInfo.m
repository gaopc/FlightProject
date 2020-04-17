//
//  MemberOrderInfo.m
//  FlightProject
//
//  Created by admin on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MemberOrderInfo.h"

@implementation MemberOrderInfo
@synthesize _date, _state, _arrical, _orderId, _flightNo, _departure, _flightType, _totalPrice, _departureDate;

-(void)dealloc
{
    self._date = nil;
    self._state = nil;
    self._arrical = nil;
    self._orderId = nil;
    self._flightNo = nil;
    self._totalPrice = nil;
    self._departure = nil;
    self._flightType = nil;
    self._departureDate = nil;
    [super dealloc];
}

+(MemberOrderInfo *)MemberOrderDetail:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    MemberOrderInfo * memberOrderInfo = [[MemberOrderInfo alloc] init];
    memberOrderInfo._orderId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"orderId"]];
    memberOrderInfo._date = [NSString stringWithFormat:@"%@", [dic objectForKey:@"date"]];
    memberOrderInfo._totalPrice = [NSString stringWithFormat:@"%@", [dic objectForKey:@"totalPrice"]];
    memberOrderInfo._arrical = [[dic objectForKey:@"arrival"] componentsSeparatedByString:@"&"];
    memberOrderInfo._departure = [[dic objectForKey:@"departure"] componentsSeparatedByString:@"&"];
    memberOrderInfo._flightType =[NSString stringWithFormat:@"%@", [dic objectForKey:@"flightType"]] ;
    memberOrderInfo._state = [NSString stringWithFormat:@"%@", [dic objectForKey:@"state"]];
    memberOrderInfo._flightNo = [[dic objectForKey:@"flightNo"] componentsSeparatedByString:@"&"];
    memberOrderInfo._departureDate = [[dic objectForKey:@"departureDate"] componentsSeparatedByString:@"&"];
   
    return [memberOrderInfo autorelease];
}

+(NSArray *)MemberOrderList:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray * array = [dic objectForKey:@"orderList"];
    if (![array isKindOfClass:[NSArray class]] ) {
        return nil;
    }
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary * elem in array) {
        [marray addObject:[self MemberOrderDetail:elem]];
    }
    return marray;
}
@end
