//
//  GetLcdCoinDetailsInfoResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//2.42	会员畅达币明细接口
#import <Foundation/Foundation.h>

@interface LCDCoinDetailInfo : NSObject

@property (nonatomic,retain)NSString * lcdCoin; // 畅达币数
@property (nonatomic,retain)NSString * date; // 变动日期
@property (nonatomic,retain)NSString * inOrOut; // 使用还是获取 “0” 使用  “1” 获取
@property (nonatomic,retain)NSString * source; // 来源如果inOrOut为“1”获取 则此项有值“0” 注册“1” 低价推送“2” 返积分“3” 其他
@property (nonatomic,retain)NSString * Ticketno; // 票号

@end

@interface GetLcdCoinDetailsInfoResponse : NSObject
+(LCDCoinDetailInfo *) getLcdCoinDetailsInfoResponseWithArray : (NSArray *)resultArray;
@end
