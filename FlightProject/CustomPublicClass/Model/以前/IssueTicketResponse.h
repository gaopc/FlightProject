//
//  IssueTicketResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//2.14	机票支付出票接口
#import <Foundation/Foundation.h>
#import "RootRequestModel.h"
@interface IssueTicketRequest : RootRequestModel

@property (nonatomic, retain) NSString *flowNo;
@property (nonatomic, retain) NSString *cardNo;
@property (nonatomic, retain) NSString *expiredDate;
@property (nonatomic, retain) NSString *cvv;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *identitycard;
@property (nonatomic, retain) NSString *telephone;
@property (nonatomic, retain) NSString *totalMoney;
@property (nonatomic, retain) NSString *batchNo;
@property (nonatomic, retain) NSString *tradeTime;
@property (nonatomic, retain) NSString *lcdCoin;
@property (nonatomic, retain) NSString *encryptType;
@property (nonatomic, retain) NSString *bankGateway;

@end

@interface lssueTicket : NSObject
@property (nonatomic,retain) NSString * psgName;
@property (nonatomic,retain) NSString * psgType;
@property (nonatomic,retain) NSString * idNo;
@property (nonatomic,retain) NSString * ticketNoList;
@end

@interface IssueTicketResponse : NSObject

@property (nonatomic,retain) NSString * orderID;
@property (nonatomic,retain) lssueTicket * ticket;

+(IssueTicketResponse *)issueTicketResponseWithArray:(NSArray *)resultArray;
@end

