//
//  SearchRuleResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//  退改签查询接口
#import <Foundation/Foundation.h>
@interface SearchRuleReques : RootRequestModel
@property (nonatomic,retain)NSString * airCode;
@property (nonatomic,retain)NSString * cabin;
@property (nonatomic,retain)NSString * flightStartTime;
@end

@interface SearchRuleResponse : NSObject
// 改退签内容
+(NSString *)searchRuleResponseWithArray:(NSArray * ) resultArray;

@end
