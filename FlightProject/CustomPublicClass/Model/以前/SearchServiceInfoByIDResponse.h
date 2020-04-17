//
//  SearchServiceInfoByIDResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//2.49	查询周边服务详情接口
#import <Foundation/Foundation.h>

@interface ServiceDetailInfo : NSObject
@property (nonatomic,retain) NSString * serviceID;
@property (nonatomic,retain) NSString * serviceInfo;
@end

@interface SearchServiceInfoByIDResponse : NSObject
+(NSArray *)searchServiceInfoByIDResponseWithArray:(NSArray *)resultArray;
@end
