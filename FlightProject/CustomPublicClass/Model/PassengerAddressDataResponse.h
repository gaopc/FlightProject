//
//  PassengerAddressDataResponse.h
//  FlightProject
//
//  Created by lidong  cui on 12-10-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PassengerAddressDataResponse : NSObject
@property (nonatomic)int _id; // 乘机人地址主键
@property (nonatomic,retain)NSMutableArray * _passengerAddressArray; //乘机人地址

+ (PassengerAddressDataResponse *)queryPassengerAddressList:(NSDictionary *)dic;
//提交乘机人信息
+ (int) addPassengerAddress:(NSDictionary *)dic;

//删除邮寄地址
+ (void) deletePassengerAddress:(NSDictionary *)dic;
@end


@interface PassengerAddressItem : NSObject
@property (nonatomic,retain)NSString * _id; //主键ID
@property (nonatomic,retain)NSString * _name; //收件人姓名
@property (nonatomic,retain)NSString * _postCode; //邮政编码
@property (nonatomic,retain)NSString * _postAddress; //邮寄地址
@property (nonatomic,retain)NSString * _mobile; //手机号
@property (nonatomic, retain) NSString* _selected;
@property (nonatomic, retain) NSString* _city;
@property (nonatomic, retain) NSString* _province;
@property (nonatomic, retain) NSString* _county;
@end