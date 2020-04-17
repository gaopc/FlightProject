//
//  UserRefundTicketNewResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//2.46	新退票接口（支持多票退票）
#import <Foundation/Foundation.h>

@interface autorRefundTicketRequest : NSObject
@property (nonatomic,retain) NSString * userID; //会员ID
@property (nonatomic,retain) NSArray * ticketNoList; // 票号列表
@property (nonatomic,retain) NSString * refundType; // 退票方式  0：退畅达币 1：原卡退回
@end

@interface UserRefundTicketNewResponse : NSObject
+(void)userRefundTicketNewResponseWithArray:(NSArray *)resultArray;
@end

//2.59	一键式退票接口
