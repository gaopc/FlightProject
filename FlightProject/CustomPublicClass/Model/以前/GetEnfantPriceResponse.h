//
//  getEnfantPriceResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
// 儿童机票票价查询接口
@interface GetEnfantPriceReques : RootRequestModel
@property (nonatomic,retain)NSString * cabin;
@property (nonatomic,retain)NSString * baseCabin;
@property (nonatomic,retain)NSString * price;
@end

@interface GetEnfantPriceResponse : NSObject
+(NSString *)GetEnfantPriceResponseWithArray:(NSArray * ) resultArray;
@end
