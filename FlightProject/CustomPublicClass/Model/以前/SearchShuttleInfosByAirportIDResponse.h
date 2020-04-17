//
//  SearchShuttleInfosByAirportIDResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//2.50	查询机场班车信息接口
#import <Foundation/Foundation.h>

@interface ShuttleInfo  : NSObject
@property (nonatomic,retain) NSString * shuttleID;
@property (nonatomic,retain) NSString * shuttleName;
@property (nonatomic,retain) NSString * operationsTime;
@property (nonatomic,retain) NSString * price;
@property (nonatomic,retain) NSString * startStation;
@property (nonatomic,retain) NSString * endStation;

@property (nonatomic,retain) NSString * airportID;
@property (nonatomic,retain) NSString * intervalTime;
@property (nonatomic,retain) NSString * passStation;
@property (nonatomic,retain) NSString * driection;
@property (nonatomic,retain) NSString * hotLine;
@end

@interface SearchShuttleInfosByAirportIDResponse : NSObject
+(NSArray *)searchShuttleInfosByAirportIDResponseWithArray:(NSArray *)resultArray;
@end
