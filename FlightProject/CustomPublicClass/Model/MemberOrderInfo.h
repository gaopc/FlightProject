//
//  MemberOrderInfo.h
//  FlightProject
//
//  Created by admin on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MemberOrderInfo : NSObject

@property (nonatomic,retain) NSString *_orderId;
@property (nonatomic,retain) NSString *_date;
@property (nonatomic,retain) NSString *_totalPrice;
@property (nonatomic,retain) NSString *_flightType;
@property (nonatomic,retain) NSString *_state;
@property (nonatomic, retain) NSArray *_flightNo;
@property (nonatomic, retain) NSArray *_departureDate;
@property (nonatomic, retain) NSArray *_departure;
@property (nonatomic, retain) NSArray *_arrical;

+(NSArray *)MemberOrderList:(NSDictionary *)dic;
@end
