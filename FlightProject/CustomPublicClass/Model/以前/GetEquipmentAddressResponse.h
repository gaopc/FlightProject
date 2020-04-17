//
//  GetEquipmentAddressResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//2.57	城市终端机摆放地点查询接口
#import <Foundation/Foundation.h>

@interface CityAddrInfo : NSObject
@property (nonatomic,retain) NSString *equipmentAddress ;
@property (nonatomic,retain) NSString * province;
@property (nonatomic,retain) NSString * city;
@property (nonatomic,retain) NSString * longitude;
@property (nonatomic,retain) NSString * latitude;
@end

@interface GetEquipmentAddressResponse : NSObject
@property (nonatomic,retain) NSString *totalCount;
@property (nonatomic,retain) NSString *totalPageNum;
@property (nonatomic,retain) NSArray *cityAddrInfos;

+(GetEquipmentAddressResponse *)getEquipmentAddressResponseWithArray:(NSArray *)resultArray;
@end

@interface GetEquipmentAddressByAddressResponse : GetEquipmentAddressResponse // 模糊查询

@end
