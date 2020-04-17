//
//  MapDataResponse.h
//  FlightProject
//
//  Created by admin on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


//@interface MapDataCityInfoResponse : NSObject
//@property (nonatomic, retain) NSString *_longitude;
//@property (nonatomic, retain) NSString *_latitude;
//@property (nonatomic, retain) NSString *_address;
//
//+(NSArray *)cityInfo:(NSDictionary *)dic;
//@end
//
//@interface MapDataProvinceListResponse : NSObject
//@property (nonatomic, retain) NSString *_name;
//@property (nonatomic, retain) NSArray *_citys;
//
//+(NSArray *)provincesList:(NSDictionary *)dic;
//@end
//
//@interface MapDataCityListResponse : NSObject
//@property (nonatomic, retain) NSString *_cityCode;
//@property (nonatomic, retain) NSArray *_cityName;
//
//+(NSArray *)citysList:(NSDictionary *)dic;
//@end

@interface TerminalCity : NSObject
@property (nonatomic, retain) NSString *_cityCode;
@property (nonatomic, retain) NSString *_cityName;
+(TerminalCity *)TerminalCity:(NSDictionary *)dic;
@end

@interface TerminalProvince : NSObject
@property (nonatomic,retain) NSMutableArray * _citys;
@property (nonatomic,retain) NSString * _provinceName;
+(NSArray *) TerminalProvince:(NSDictionary *)dic;
@end

@interface TerminalInfo : NSObject
@property (nonatomic, retain) NSString *_longitude;
@property (nonatomic, retain) NSString *_latitude;
@property (nonatomic, retain) NSString *_address;
+(NSArray *)TerminalInfo:(NSDictionary *)dic;
@end
