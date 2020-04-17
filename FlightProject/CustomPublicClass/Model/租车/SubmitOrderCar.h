//
//  SubmitOrderCar.h
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarModel.h"

@interface SubmitOrderCar : CarModel

@property (nonatomic,retain) NSString * _modeCode;
@property (nonatomic,retain) NSString * _vehicleLevel;
@property (nonatomic,retain) NSString * _serviceId;
@property (nonatomic,retain) NSString * _activityId;

@end

@interface CarServiceList : NSObject
@property (nonatomic,retain) NSString * _serviceName;
@property (nonatomic,retain) NSString * _servicePrice;
@end

@interface SubmitOrderCarResponse : NSObject
@property (nonatomic,retain) NSString * _totalCarRentMoney;
@property (nonatomic,retain) NSString * _totalCarFee;
@property (nonatomic,retain) NSString * _insuranceFee;
@property (nonatomic,retain) NSArray * _serviceFee ;
@property (nonatomic,retain) NSString * _otherFee;
@property (nonatomic,retain) NSString * _lcdFee;
@property (nonatomic,retain) NSString * _lcdRate;
@property (nonatomic,retain) NSString * _lcdValue;
+(SubmitOrderCarResponse *) SubmitOrderCarResponse:(NSDictionary *)resultDic;
@end
