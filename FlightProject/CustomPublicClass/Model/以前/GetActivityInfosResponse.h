//
//  GetActivityInfosResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

// 2.39	会员活动列表查询接口
#import <Foundation/Foundation.h>
@interface ActivityInfo:NSObject
@property (nonatomic,retain)NSString * activityName;
@property (nonatomic,retain)NSString * nameImgUrl;
@property (nonatomic,retain)NSString * activityUrl;
//@property (nonatomic,retain)NSString * activityStartTime;
//@property (nonatomic,retain)NSString * activityEndTime;
//@property (nonatomic,retain)NSString * activityUpdateTime;
@end

@interface GetActivityInfosResponse : NSObject
+(NSArray *)getActivityInfosResponseWithArray:(NSArray *)resultArray;
@end
