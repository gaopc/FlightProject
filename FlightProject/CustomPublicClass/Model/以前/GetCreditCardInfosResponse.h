//
//  GetCreditCardInfosResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//2.17	会员信用卡信息查询接口
#import <Foundation/Foundation.h>

@interface GetCreditCardInfosResponse : NSObject

@property(nonatomic,retain) NSString* cardID;  //  信用卡号 
@property(nonatomic,retain) NSString* useName;  //  卡主姓名
@property(nonatomic,retain) NSString* certNum;  //  证件号
@property(nonatomic,retain) NSString* bankID;  //  银行ID
@property(nonatomic,retain) NSString* bankName;  //  银行名称
@property(nonatomic,retain) NSString* bankGateway;  //  银行网关

+(NSArray *)getCreditCardInfosResponseWithArray:(NSArray *)resultArray;
@end
