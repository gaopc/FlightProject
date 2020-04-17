//
//  SubmitOrderResponse.h
//  FlightProject
//
//  Created by longcd on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubmitOrderResponse : NSObject
@property (nonatomic,retain) NSString * _shengPZ;
@property (nonatomic,retain) NSString * _availableLcdCurrency;
@property (nonatomic,retain) NSString * _returnLcdCurrency;
@property (nonatomic,retain) NSArray * _payment;
@property (nonatomic,retain) NSArray * _paymentInfo;
@property (nonatomic,retain) NSString * _orderId;
@property (nonatomic,retain) NSArray * _ticketPriceForChild;
+ (SubmitOrderResponse *)SubmitOrderResponse:(NSDictionary *)dic;
@end
