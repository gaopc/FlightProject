//
//  SearchShuttleDetailInfoByIDResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//2.51	查询班车详情接口
#import <Foundation/Foundation.h>
#import "SearchShuttleInfosByAirportIDResponse.h"

@interface SearchShuttleDetailInfoByIDResponse : NSObject
+(ShuttleInfo *)searchShuttleDetailInfoByIDResponseWithArray:(NSArray *)resultArray;
@end
