//
//  PayDataClass.h
//  LCDFlight
//
//  Created by longcd on 12-8-9.
//  Copyright (c) 2012年 BeyondSoft. All rights reserved.
//  张晓婷 20120809 添加 用于支付宝支付和银联支付

#import <Foundation/Foundation.h>

@interface PayDataClass : NSObject

@end

@interface  GetDealKeyRequest : NSObject
@property (nonatomic,retain) NSString * terminalId;
@property (nonatomic,retain) NSString * orderID;
@property (nonatomic,retain) NSString * payMoney;
@property (nonatomic,retain) NSString * payCoin;
@property (nonatomic,retain) NSString * payType;
@property (nonatomic,retain) NSString * userID;
@end

//@interface GetDealKeyResponse : NSObject
//@property (nonatomic,retain) NSString * result;
//@property (nonatomic,retain) NSString * errorDescription;
//@property (nonatomic,retain) NSString * packets;
//+(NSString *)GetDealKeyResponse:(NSArray *)resultArray;
//@end

@interface GetPaymentInfoRequest : NSObject
@property (nonatomic,retain) NSString * terminalId;
@property (nonatomic,retain) NSString * phonePackets;
@property (nonatomic,retain) NSString * paymentChannels;
@property (nonatomic,retain) NSString * times;
@property (nonatomic,retain) NSString * orderID;
@property (nonatomic,retain) NSString * userID;
@end

@interface GetPaymentInfoResphonse : NSObject
@property (nonatomic,retain) NSString * result;
@property (nonatomic,retain) NSString * message;
+(GetPaymentInfoResphonse *) GetPaymentInfoResphonse:(NSDictionary *)resultDic;

@end