//
//  MyLCDCoinDataResponse.h
//  FlightProject
//
//  Created by green kevin on 12-10-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyLCDCoinInfo;
@interface MyLCDCoinDataResponse : NSObject
@property (nonatomic,retain) MyLCDCoinInfo * _myLCDCoinInfo; //畅达币
@property (nonatomic,retain) NSMutableArray * _myLCDCoinDetailArray; //畅达币历史纪录

//获取我的畅达货
+ (MyLCDCoinDataResponse *)myLCDCoin:(NSDictionary *)dic;

@end


@interface MyLCDCoinInfo : NSObject

@property (nonatomic,retain)NSString * _availableLcdCurrency; // 可用畅达币总数
@property (nonatomic,retain)NSString * _lcdCurrency; //累计获取畅达币
@property (nonatomic,retain)NSString * _useLcdCurrency; //已用畅达币
@property (nonatomic,retain)NSString * _notReturnLcdCurrency; //未返还畅达币数

@end


@interface MyLCDCoinDetailInfo : NSObject
@property (nonatomic,retain)NSString * _type;//注册、推荐、退票款、购票、返还、退票手续费、活动
@property (nonatomic,retain)NSString * _content; //票价
@property (nonatomic,retain)NSString * _amount; //交易额度
@property (nonatomic,retain)NSString * _incomeOrExpenses; // 0:表示收入,1:表示支出
@property (nonatomic,retain)NSString * _date; //交易日期

@end