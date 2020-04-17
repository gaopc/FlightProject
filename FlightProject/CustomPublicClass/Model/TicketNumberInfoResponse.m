//
//  TicketNumberInfoResponse.m
//  FlightProject
//
//  Created by admin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TicketNumberInfoResponse.h"

@implementation TicketNumberInfoResponse
@synthesize _fee, _price, _rules, _totalPrice, _ticketNum;

- (void)dealloc
{
    self._fee = nil;
    self._price = nil;
    self._rules = nil;
    self._totalPrice = nil;
    self._ticketNum = nil;
    [super dealloc];
}

+(TicketNumberInfoResponse *)setTicketNumberInfo:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    TicketNumberInfoResponse * ticketNumber = [[TicketNumberInfoResponse alloc] init];

    ticketNumber._totalPrice =  [NSString stringWithFormat:@"%@", [dic objectForKey:@"totalPrice"]];
    ticketNumber._price =       [NSString stringWithFormat:@"%@", [dic objectForKey:@"price"]];
    ticketNumber._rules =       [NSString stringWithFormat:@"%@", [dic objectForKey:@"rules"]];
    ticketNumber._fee =         [NSString stringWithFormat:@"%@", [dic objectForKey:@"fee"]];
    
    return [ticketNumber autorelease];
}
@end
