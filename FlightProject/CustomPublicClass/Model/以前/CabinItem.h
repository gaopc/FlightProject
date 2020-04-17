//
//  CabinItem.h
//  LCDFlight
//
//  Created by zzz on 18/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CabinItem : NSObject {
	//F ;\u003e9 ; 250.0 ; ; CNY ; 283000; 0
	//舱位代码 +“;” + 剩余座位数量 +“;” + 折扣率 + “;” + 基准舱位+“;” + 货币类型 +“;”+ 单程价格(折扣价)+”;”+舱位类型(0为正常折扣舱位,1为单程特价舱位,2是往返特价舱位)+”;”+特价退改签编码+”;特价舱位的基准舱位
	NSString *cabinNO;//舱位代码
	NSString *sits;//座位数
	NSString *discount;//折扣率
	NSString *moneyType;//货币类型
	NSString *oneWayPrice;//基准舱位价格
	NSString *cabinType;//舱位类型
	NSString *baseCabin;//基准舱位
	NSString *specialFlightNum;//特价退改签编码
    NSString *specialBaseCabin;//特价舱位的基准舱位
}
@property (nonatomic, retain) NSString *cabinNO;
@property (nonatomic, retain) NSString *sits;
@property (nonatomic, retain) NSString *discount;
@property (nonatomic, retain) NSString *moneyType;
@property (nonatomic, retain) NSString *oneWayPrice;
@property (nonatomic, retain) NSString *cabinType;
@property (nonatomic, retain) NSString *baseCabin;
@property (nonatomic, retain) NSString *specialFlightNum;
@property (nonatomic, retain) NSString *specialBaseCabin;
@end
