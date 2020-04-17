//
//  GetFeedbackInfosResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//2.44	会员反馈信息查询接口
#import <Foundation/Foundation.h>

@interface FeedbackInfo : NSObject
@property (nonatomic,retain)NSString * problem;
@property (nonatomic,retain)NSString * answer;
@end

@interface GetFeedbackInfosResponse : NSObject
+(NSArray *)getFeedbackInfosResponseWithArray:(NSArray *)resultArray;
@end
