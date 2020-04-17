//
//  GetOrderInfoResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//2.26	订单详情查询接口
#import "PassengerInfo.h"
#import "SegsInfo.h"
#import "ContactorInfo.h"

@interface LtineraryMailInfo:NSObject
@property (nonatomic,retain)NSString * orderID;
@property (nonatomic,retain)NSString * getType;
@property (nonatomic,retain)NSString * result;
@end

@interface PayInfo : NSObject
@property (nonatomic, retain) NSString *orderId;
@property (nonatomic, retain) NSString *isPay;
@property (nonatomic, retain) NSString *cardId;
@property (nonatomic, retain) NSString *payPrice;
@property (nonatomic, retain) NSString *payTime;
@end

@interface LCDCoinInfo : NSObject

@property (nonatomic, retain) NSString *lcdCoin;
@property (nonatomic, retain) NSString *waitLcdCoin;

@end

@interface AcceptServicesInfo : NSObject

@property (nonatomic, retain) NSString *ticketNo;
@property (nonatomic, retain) NSString *isAccept;
@property (nonatomic, retain) NSString *status;

@end

@interface TicketInfo : NSObject

@property (nonatomic, retain) NSString *ticketNo;
@property (nonatomic, retain) NSString *ticketStatus;
@property (nonatomic, retain) NSString *passengeName;
@property (nonatomic, retain) NSString *psgType;
@property (nonatomic, retain) NSString *psgIdno;
@property (nonatomic, retain) NSString *flightSite;

@end

@interface OrderInfoDetail : NSObject
@property (nonatomic,retain) NSArray * psgInfos;
@property (nonatomic,retain) NSArray *segsInfos;
@property (nonatomic,retain) LtineraryMailInfo *ltineraryMailInfos;
@property (nonatomic,retain) LCDCoinInfo * lcdCoinInfos;
@property (nonatomic,retain) NSArray *acceptSevicesInfos;
@property (nonatomic,retain) ContactorInfo * contactorInfo;
@property (nonatomic,retain) PayInfo * payInfo;
@property (nonatomic,retain) NSArray * ticketInfos;
@end

@interface GetOrderInfoDetailResponse : NSObject
+(OrderInfoDetail *)getOrderInfoDetailResponseWithArray:(NSDictionary *)resultDic;
@end
