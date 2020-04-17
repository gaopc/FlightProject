//
//  AutoDepreciateDataResponse.h
//  FlightProject
//
//  Created by 崔立东 on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  自动降价数据响应
//

#import <Foundation/Foundation.h>

@class AutomaticallyInfo;

@interface AutomaticallyDataResponse : NSObject

@property (nonatomic,assign)int _cumulationPrice; //累计畅达币
@property (nonatomic,retain)NSMutableArray * _autoMaticallyArray; //自动降价数组
@property (nonatomic,retain)NSMutableArray * _pushDetailArray; //推送历史纪录数组
@property (nonatomic,retain)AutomaticallyInfo * _automaticallyInfo; //自动降价对象
//自劢降价列表查询
+ (AutomaticallyDataResponse *)queryAutomaticallyDroppedList:(NSDictionary *)dic;
//自动降价推荐内容
+ (AutomaticallyDataResponse *)queryAutomaticallyDroppedDetail:(NSDictionary *)dic;
@end

@interface AutomaticallyInfo : NSObject
@property (nonatomic,retain)NSString * _ticketNo; //票号
@property (nonatomic,retain)NSString * _flightNo; //航班号
@property (nonatomic,retain)NSString * _startDate;//起飞日期
@property (nonatomic,retain)NSString * _departure;//起飞城市
@property (nonatomic,retain)NSString * _arrival; //降落城市
@property (nonatomic,retain)NSString * _pushTime; //推送次数
@property (nonatomic,retain)NSString * _createDate;//创建日期

@property (nonatomic,retain)NSString * _airline; //航空公司
@property (nonatomic,retain)NSString * _planeType; //航空公司
@property (nonatomic,retain)NSString * _cabin; //舱位类型
@property (nonatomic,retain)NSString * _cabinCode; //舱位码
@property (nonatomic,retain)NSString * _startTime; //起飞时间
@property (nonatomic,retain)NSString * _endTime; //降落时间
@property (nonatomic,retain)NSString * _startAirport; //起飞机场
@property (nonatomic,retain)NSString * _startTerminal; //起飞航站楼
@property (nonatomic,retain)NSString * _endAirport; //降落机场
@property (nonatomic,retain)NSString * _endTerminal; // 降落航站楼
@property (nonatomic,retain)NSString * _ticketPrice; // 总金额
@property (nonatomic,retain)NSString * _discount; //折扣
@property (nonatomic,retain)NSString * _type; //是否可以拨打电话

@property (nonatomic,retain)NSString * _pushPrice; //推送价格
@property (nonatomic,retain)NSString * _savingPrice; //节省金额
@property (nonatomic,retain)NSString * _pushDiscount; //推送折扣
@property (nonatomic,retain)NSString * _pushCabin; //舱位类型
@property (nonatomic,retain)NSString * _pushCabinCode; //舱位码
@end

@interface PushDetailInfo : NSObject
@property (nonatomic,retain)NSString * _date; //推送日期
@property (nonatomic,retain)NSString * _price; //票价
@property (nonatomic,retain)NSString * _discount; //折扣
@property (nonatomic,retain)NSString * _savingPrice; //节省金额
@end