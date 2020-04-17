//
//  PassengerInfoDataResponse.h
//  FlightProject
//
//  Created by green kevin on 12-9-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PassengerInfoDataResponse : NSObject
@property (nonatomic)int _id; // 乘机人主键
@property (nonatomic,retain)NSMutableArray * _passengerInfoArray; //乘机人数组
@property (nonatomic,retain)NSMutableArray * _pickPersonInfoArray; //接机人数组
@property (nonatomic,retain)NSString *_maximum; //最多接机人数量
@property (nonatomic,retain)NSString *_total; //接机人列表数量
//乘机人信息列表
+ (NSMutableArray *)queryPassengerInfoList:(NSDictionary *)dic;
//接机人信息列表
- (void)queryPickPersonInfoList:(NSDictionary *)dic;
//+ (NSMutableArray *)queryPickPersonInfoList:(NSDictionary *)dic;
//提交乘机人信息
+ (int) addPassenger:(NSDictionary *)dic;
//提交接机人信息
+ (int) addPickPerson:(NSDictionary *)dic;
@end

@interface PassengerInfoItem : NSObject
@property (nonatomic,retain)NSString * _id; //乘机人
@property (nonatomic,retain)NSString * _name; //姓名
@property (nonatomic,retain)NSString * _type;//类型
@property (nonatomic,retain)NSString * _certType;//证件类型
@property (nonatomic,retain)NSString * _certNum; //证件号
@property (nonatomic,retain)NSString * _birthday; //生日

@end

@interface PickPersonInfoItem : NSObject
@property (nonatomic,retain)NSString * _id; //乘机人
@property (nonatomic,retain)NSString * _name; //接机人姓名
@property (nonatomic,retain)NSString * _phone;//接机人电话
@property (nonatomic, retain) NSString* _selected;

@end