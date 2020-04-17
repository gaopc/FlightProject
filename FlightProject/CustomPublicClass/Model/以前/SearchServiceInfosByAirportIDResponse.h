//
//  SearchServiceInfosByAirportIDResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//2.48	查询机场周边服务信息接口
#import <Foundation/Foundation.h>

@interface AirportServiceInfo : NSObject
@property (nonatomic,retain) NSString * serviceName;
@property (nonatomic,retain) NSString * serviceID;
@end


@interface SearchServiceInfosByAirportIDResponse : NSObject
+(NSArray *)searchServiceInfosByAirportIDResponseWithArray:(NSArray *)resultArray;
@end
