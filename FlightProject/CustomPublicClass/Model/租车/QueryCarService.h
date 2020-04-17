//
//  QueryCarService.h
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarModel.h"

@interface QueryCarService : CarModel

@property (nonatomic,retain) NSString * _modeCode;

@end

// 一下为服务器返回数据封装

@interface CarService : NSObject
@property (nonatomic,retain) NSString * _serviceId;
@property (nonatomic,retain) NSString * _serviceName;
@property (nonatomic,retain) NSString * _servicePrice;
@property (nonatomic,retain) NSString * _chooseType;
+(CarService *)CarService:(NSDictionary *)resultDic;
@end

@interface CarActvity : NSObject
@property (nonatomic,retain) NSString * _actvityId;
@property (nonatomic,retain) NSString * _actvityDesc;
@property (nonatomic,retain) NSString * _selectlimit;
+(CarActvity *)CarActvity:(NSDictionary *)resultDic;
@end

@interface QueryCarServiceResponse : NSObject
@property (nonatomic,retain) NSArray * _carService;
@property (nonatomic,retain) NSArray * _actvityList;

+(QueryCarServiceResponse *)QueryCarServiceResponse:(NSDictionary *)resultDic;
@end