//
//  UpdateOrderAllResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateOrderAllRequest : NSObject
@property (nonatomic ,retain) NSString * userID;   //  修改订单行程单邮寄信息和修改订单联系人信息时必填
@property (nonatomic ,retain) NSString * orderID;   //  订单号 必填
@property (nonatomic ,retain) NSArray * mailInfo;   //  修改行程单获取方式时必填
@property (nonatomic ,retain) NSString * name;   //  修改订单行程单邮寄信息时必填
@property (nonatomic ,retain) NSString * postCode;   //  修改订单行程单邮寄信息时必填
@property (nonatomic ,retain) NSString * postalAddress;   //  修改订单行程单邮寄信息时必填
@property (nonatomic ,retain) NSString * contactorName;   //  修改订单联系人信息时必填
@property (nonatomic ,retain) NSString * mobile;   //  收件人或联系人手机 修改订单行程单邮寄信息和修改订单联系人信息时必填
@property (nonatomic ,retain) NSString * telephone;   //  联系人电话 修改订单联系人信息时必填
@property (nonatomic ,retain) NSString * isBuy;   //  是否买保险 “0”买保险 “1”取消购保 取消/购买保险时必填
@property (nonatomic ,retain) NSString * getItinerary;   //  行程单获取方式  “ 0” 无需行程单  “ 1“ 免费邮寄 “ 2“ 民航自助售票打印  修改行程单获取方式时必填
@end

@interface UpdateOrderAllResponse : NSObject
+(void)updateOrderAllResponseWithArray:(NSArray *)resultArray;
@end
