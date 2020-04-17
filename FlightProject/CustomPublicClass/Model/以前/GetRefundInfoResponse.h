//
//  GetRefundInfoResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//2.63	获取退票提示内容接口
#import <Foundation/Foundation.h>

@interface RefundInfo : NSObject
@property (nonatomic,retain) NSString * ticketNo;  //  票号
@property (nonatomic,retain) NSString * totalPrice;  //  原票价
@property (nonatomic,retain) NSString * refundPrice;  //  退票手续费
@property (nonatomic,retain) NSString * refundPriceP;  //  退款金额

@property (nonatomic,retain) NSString * refundCoin;  //  退畅达币金额
@property (nonatomic,retain) NSString * refundMoney;  //  退回卡金额
@end

@interface GetRefundInfoResponse : NSObject

+(NSArray *)getRefundInfoResponseWithArray:(NSArray *)resultArray;

@end
