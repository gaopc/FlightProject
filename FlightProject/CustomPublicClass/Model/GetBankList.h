//
//  GetBankList.h
//  FlightProject
//
//  Created by longcd on 12-11-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankListInfo : NSObject

@property(nonatomic,retain) NSString * _bankName;
//@property(nonatomic,retain) NSString * _flightBankId;
@property(nonatomic,retain) NSString * _hotelBankId;
+(BankListInfo *) bankInfoWithDic:(NSDictionary *)elem;
@end

@interface GetBankList : NSObject
+(NSArray *)GetBankList:(NSDictionary * ) dic;
@end
