//
//  GetPassengerInfosResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//2.16	会员常旅客列表查询接口
#import <Foundation/Foundation.h>
#import "PassengerInfomation.h"
@interface GetPassengerInfosResponse : NSObject

+(NSArray *)getPassengerInfosResponseWithArray:(NSArray *)resultArray;

@end
