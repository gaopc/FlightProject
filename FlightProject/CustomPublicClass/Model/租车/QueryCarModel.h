//
//  QueryCarModel.h
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarModel.h"

@class CarPackageResponse;

@interface QueryCarModel : CarModel

@property (nonatomic,assign) NSInteger _pageIndex;

@end

// 服务器返回数据

@interface CarModelDetail : NSObject
@property (nonatomic,retain) NSString * _modeCode;
@property (nonatomic,retain) NSString * _picUrl;
@property (nonatomic,retain) NSString * _typeName;
@property (nonatomic,retain) NSString * _typeDesc;
@property (nonatomic,retain) NSString * _insurance;
@property (nonatomic,retain) NSString * _preAuthorization;
@property (nonatomic,retain) NSString * _dayPrice;
@property (nonatomic,retain) NSString * _modeLevelName;
@property (nonatomic,retain) NSString * _modeLevel;
@property (nonatomic,retain) NSString * _levelType;
@property (nonatomic,retain) NSString * _packageType;

@property (nonatomic,retain) NSString * _orderType;
@property (nonatomic,retain) NSString * _productType;
@property (nonatomic,retain) CarPackageResponse *_packageInfo;
+(id)CarModelDetail:(NSDictionary * )resultDic;
@end

@interface QueryCarModelResponse : CarModelDetail
@property (nonatomic,retain) NSString * _storeCode;
@property (nonatomic,retain) NSString * _deptype;
@property (nonatomic,retain) NSString * _shopName;
@property (nonatomic,retain) NSString * _shopAddress;
@property (nonatomic,retain) NSMutableArray  * _detail;

+(NSArray *)QueryCarModelResponse:(NSDictionary *)resultDic;

@end

@interface CarPackageResponse : NSObject
@property (nonatomic,retain) NSString * _discount;
@property (nonatomic,retain) NSString * _day;
@property (nonatomic,retain) NSString * _total;
@property (nonatomic,retain) NSString * _packageInfo;
@property (nonatomic, retain) NSString *_orderType;
@property (nonatomic, retain) NSString *_productType;

+ (CarPackageResponse *)CarPackageInfo:(NSDictionary * )dic;
@end
