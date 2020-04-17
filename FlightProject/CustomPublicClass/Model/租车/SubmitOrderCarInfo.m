//
//  SubmitOrderCarInfo.m
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SubmitOrderCarInfo.h"

@implementation SubmitOrderCarInfo
@synthesize _userId,_name,_identityNumber,_mobileNumber,_modeCode,_vehicleLevel,_serviceId,_activityId,_deptype;

@synthesize _typeName,_typeDesc;

@synthesize _submitOrderCarRes;
@synthesize _preAuthorization;
@synthesize _levelType;
@synthesize _selectPackage;
@synthesize _orderType, _productType, _uuid, _validId;
//@synthesize  _carServiceList,_carActvityList;


-(void)dealloc
{
    self._validId = nil;
    self._uuid = nil;
    self._productType = nil;
    self._orderType = nil;
    self._userId = nil;
    self._name = nil;
    self._identityNumber = nil;
    self._mobileNumber = nil;
    self._modeCode = nil;
    self._vehicleLevel = nil;
    self._serviceId = nil;
    self._activityId = nil;
    self._deptype = nil;
    
    self._typeName = nil;
    self._typeDesc = nil;
    
    self._submitOrderCarRes = nil;
    self._preAuthorization = nil;
    self._selectPackage = nil;
//    
//    self._carActvityList = nil;
//    self._carServiceList = nil;
    
    self._levelType = nil;
    
    [super dealloc];
}
+(SubmitOrderCarInfo *)sharedSubmitOrderCarInfo
{
    static SubmitOrderCarInfo * info = nil;
    if (info == nil) {
        info = [[SubmitOrderCarInfo alloc] init];
    }
    return info;
}
@end
