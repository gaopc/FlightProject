//
//  GetLcdCoinInfosResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LcdCoinInfo :NSObject
@property (nonatomic,retain) NSString * accumulatedLcdCoin;
@property (nonatomic,retain) NSString * usedLcdCoin;
@property (nonatomic,retain) NSString * usingLcdCoin;
@property (nonatomic,retain) NSString * noGetLcdCoin;
@end

@interface GetLcdCoinInfosResponse : NSObject
+(LcdCoinInfo *) getLcdCoinInfosResponseWithArray : (NSArray *)resultArray;
@end
