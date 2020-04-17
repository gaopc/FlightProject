//
//  SearchServicesInfosResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//2.54	查询会员低价推送信息接口
#import <Foundation/Foundation.h>

@interface IsServiceString : NSObject
@property (nonatomic,retain) NSString * lastTicketNo; //低价推送新票号
@property (nonatomic,retain) NSString * price;//原价
@property (nonatomic,retain) NSString * nowPrice;//新票价
@property (nonatomic,retain) NSString * departure;//出发地
@property (nonatomic,retain) NSString * arrival;//到达地
@property (nonatomic,retain) NSString * returnCoin;//返还的畅达币
@property (nonatomic,retain) NSString * departureDate;//低价推送日期
@end

@interface NoServiceString : NSObject
@property (nonatomic,retain) NSString * lastTicketNo; //最终票号
@property (nonatomic,retain) NSString * price;//原价
@property (nonatomic,retain) NSString * nowPrice;//现价
@property (nonatomic,retain) NSString * departure;//出发地
@property (nonatomic,retain) NSString * arrival;//到达地
@property (nonatomic,retain) NSString * returnCoin;//返还的畅达币
@property (nonatomic,retain) NSString * departureDate;//起飞时间
@end

@interface SearchServicesInfosResponse : NSObject
@property (nonatomic,retain) NSString * coin;
@property (nonatomic,retain) NSArray * isServiceString;
@property (nonatomic,retain) NSArray * noServiceString;

+(SearchServicesInfosResponse *)searchServicesInfosResponseWithDic:(NSDictionary *)resultDic;
@end
