//
//  SearchTicketPriceQueryRequest.h
//  LCDFlight
//
//  Created by walker on 11-7-28.
//  Copyright 2011年 BeyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

// 票价查询接口不理解 暂时不做
@interface SearchTicketPriceQueryRequest : RootRequestModel {
    NSString *departure;
    NSString *arrival;
    NSString *departureDate;
    NSString *arrivalTime;
    NSString *flightNo;
    NSMutableArray *cabin;
    NSString *planeType;
}

@property (nonatomic, retain) NSString *departure;
@property (nonatomic, retain) NSString *arrival;
@property (nonatomic, retain) NSString *departureDate;
@property (nonatomic, retain) NSString *arrivalTime;
@property (nonatomic, retain) NSString *flightNo;
@property (nonatomic, retain) NSMutableArray *cabin;
@property (nonatomic, retain) NSString *planeType;

@end
