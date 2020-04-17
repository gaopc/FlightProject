//
//  FlightDynamicResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

// 手机航班动态查询接口
#import <UIKit/UIKit.h>
#import "RootRequestModel.h"

@interface  FlightDynamicRequest : RootRequestModel

@property(nonatomic, retain) NSString *vDate;
@property(nonatomic, retain) NSString *vNum;
@property(nonatomic, retain) NSString *vOrg;
@property(nonatomic, retain) NSString *vDst;

@end

@interface FlightDynamic : NSObject

@property (nonatomic, retain) NSString *flightCompany;   // 航空公司（汉字名称）
@property (nonatomic, retain) NSString *flightNo;    // 航班号（航空公司二字码+航班号）
@property (nonatomic, retain) NSString *flightDepcode;    // 出发地三字码
@property (nonatomic, retain) NSString *flightArrcode;    // 目的地三字码
@property (nonatomic, retain) NSString *flightDep;    // 出发城市汉字
@property (nonatomic, retain) NSString *flightArr;    // 目的地城市汉字
@property (nonatomic, retain) NSString *flightDeptimeReady;  // 预计起飞时间
@property (nonatomic, retain) NSString *flightArrtimeReady;  // 预计起飞时间
@property (nonatomic, retain) NSString *flightDeptime;  // 实际起飞时间
@property (nonatomic, retain) NSString *flightArrtime;  // 实际起飞时间
@property (nonatomic, retain) NSString *flightState;    // 航班当前状态：计划，起飞，到达，取消，延误，备降
@property (nonatomic, retain) NSString *flightHTerminal;    // 起飞航站楼
@property (nonatomic, retain) NSString *flightTerminal;    // 到达航站楼
//@property (nonatomic, retain) NSString *expectedlandingTime;
@property (nonatomic, retain) NSString *flightDeptimePlan;   // 计划起飞时间
@property (nonatomic, retain) NSString *flightArrtimePlan;   // 计划起飞时间

@end

@interface FlightDynamicResponse : NSObject

+(NSArray *)flightDynamicResponseWithArray:(NSArray *)resultArray;

@end
