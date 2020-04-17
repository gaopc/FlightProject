//
//  UpdateCreditCard.h
//  FlightProject
//
//  Created by longcd on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateCreditCard : NSObject
@property (nonatomic,retain) NSString * _userId; // 填写信用卡使用

@property (nonatomic,retain) NSString * _id;
@property (nonatomic,retain) NSString * _username;//用户名
@property (nonatomic,retain) NSString * _idCard;//证件号码
@property (nonatomic,retain) NSString * _bank;//银行名
@property (nonatomic,retain) NSString * _bankId;//银行id
@property (nonatomic,retain) NSString * _bankIdCard;//信用卡号
@property (nonatomic,retain) NSString * _validityDate;//有效期
@property (nonatomic,retain) NSString * _cVV2Code;//CVV2码

@end
