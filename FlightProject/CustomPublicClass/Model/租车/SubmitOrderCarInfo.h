//
//  SubmitOrderCarInfo.h
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarModel.h"
#import "SubmitOrderCar.h"

@interface SubmitOrderCarInfo : CarModel
@property (nonatomic,retain) NSString * _userId;
@property (nonatomic,retain) NSString * _name;
@property (nonatomic,retain) NSString * _identityNumber;
@property (nonatomic,retain) NSString * _mobileNumber;
@property (nonatomic,retain) NSString * _modeCode;
@property (nonatomic,retain) NSString * _vehicleLevel;
@property (nonatomic,retain) NSString * _serviceId;
@property (nonatomic,retain) NSString * _activityId;
@property (nonatomic,retain) NSString * _deptype;

@property (nonatomic,retain) NSString * _typeName;
@property (nonatomic,retain) NSString * _typeDesc;

@property (nonatomic,retain) SubmitOrderCarResponse * _submitOrderCarRes;
@property (nonatomic,retain) NSString * _preAuthorization;

@property (nonatomic,retain) NSString * _levelType;
@property (nonatomic, retain) NSString *_selectPackage;

@property (nonatomic, retain) NSString *_orderType;
@property (nonatomic, retain) NSString *_productType;
@property (nonatomic, retain) NSString *_validId;
@property (nonatomic, retain) NSString *_uuid;

//@property (nonatomic,retain) NSMutableArray * _carServiceList;
//@property (nonatomic,retain) NSMutableArray * _carActvityList;


+(SubmitOrderCarInfo *)sharedSubmitOrderCarInfo;
@end
