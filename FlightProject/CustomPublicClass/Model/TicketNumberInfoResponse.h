//
//  TicketNumberInfoResponse.h
//  FlightProject
//
//  Created by admin on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketNumberInfoResponse : NSObject
@property (nonatomic, retain) NSString *_totalPrice;
@property (nonatomic, retain) NSString *_price;
@property (nonatomic, retain) NSString *_fee;
@property (nonatomic, retain) NSString *_rules;
@property (nonatomic, retain) NSString *_ticketNum;

+ (TicketNumberInfoResponse *)setTicketNumberInfo:(NSDictionary *)dic;
@end