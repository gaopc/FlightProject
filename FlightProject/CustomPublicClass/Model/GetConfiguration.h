//
//  GetConfiguration.h
//  FlightProject
//
//  Created by longcd on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Version : NSObject
@property (nonatomic,retain) NSString * _code;
@property (nonatomic,retain) NSString * _name;
@property (nonatomic,retain) NSString * _url;
@property (nonatomic,retain) NSString * _desc;
@property (nonatomic,retain) NSString * _mandatoryCode;
@end

@interface GetConfiguration : NSObject
@property (nonatomic,retain) NSString * _umeng;
@property (nonatomic,retain) NSString * _isFirst;
@property (nonatomic,retain) NSString * _unPayOrders;
@property (nonatomic,retain) NSString * _insurance;
@property (nonatomic,retain) NSString * _airportVersion;
@property (nonatomic,retain) NSString * _airportCItyVersion;
@property (nonatomic,retain) NSString * _hotelCityVersion;
@property (nonatomic,retain) NSString * _carRentalVersion;
@property (nonatomic,retain) NSString * _trainCityVersion;
@property (nonatomic,retain) NSString * _weatherCithVersion;

@property (nonatomic,retain) Version * _version;

@property (nonatomic,retain) NSArray * _messageArray;

@property (nonatomic, assign) BOOL needUpdateAirportInfo;
@property (nonatomic, assign) BOOL needUpdateAirportCityInfo;
@property (nonatomic, assign) BOOL needUpdateHotelCityList;
@property (nonatomic, assign) BOOL needUpdateCarRentalList;
@property (nonatomic, assign) BOOL needUpdateTrainCitysList;
@property (nonatomic, assign) BOOL needUpdateWeatherCitysList;

@property (nonatomic,retain) NSString * _advertisingImgBig;
@property (nonatomic,retain) NSString * _advertisingImg;

+(GetConfiguration *) shareGetConfiguration;
+(GetConfiguration * )shareGetConfiguration : (NSDictionary *)resultDic;
@end
