//
//  HotelPassengerDataResponse.h
//  FlightProject
//
//  Created by green kevin on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelPassengerDataResponse : NSObject
@property (nonatomic,retain) NSMutableArray * _hotelPassengerArray; //入住人列表
@property (nonatomic,retain) NSMutableArray * _creditCardArray; //入住人列表
@property (nonatomic,retain) NSString * _id; // 乘机人主键
//旅馆入住人列表
+ (NSMutableArray *)checkPersonnelList:(NSDictionary *)dic;
//提交入住人信息
+ (int) addCheckPersonnel:(NSDictionary *)dic;


//信用卡列表
+ (HotelPassengerDataResponse *)creditCardList:(NSDictionary *)dic;
//提交信用卡
+ (HotelPassengerDataResponse *) addCreditCard:(NSDictionary *)dic;
//编辑信用卡
+ (HotelPassengerDataResponse *) updateCreditCard:(NSDictionary *)dic;
//删除信用卡
+ (HotelPassengerDataResponse *) deleteCreditCard:(NSDictionary *)dic;
@end

//入住人
@interface HotelPersonnelInfo: NSObject

@property (nonatomic,retain)NSString * _id; 
@property (nonatomic,retain)NSString * _name; // 入住人姓名

@end

//信用卡
@interface HotelCreditCardInfo: NSObject

@property (nonatomic,retain)NSString * _id;  
@property (nonatomic,retain)NSString * _userName; // 信用卡用户姓名
@property (nonatomic,retain)NSString * _idCard; //身份证号码
@property (nonatomic,retain)NSString * _bank;// 所属银行
@property (nonatomic)int _bankId;//  所属银行id
@property (nonatomic,retain)NSString * _bankIdCard;// 所属银行卡号,卡号后四位没有
@property (nonatomic,retain)NSString * _validityDate;//  有效期,格式月年

@end



