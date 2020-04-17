//
//  GetOrderCarList.h
//  FlightProject
//
//  Created by 月 小 on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderCarModel : NSObject
@property(nonatomic,retain)NSString *ids;
@property(nonatomic,retain)NSString *submitDate;
@property(nonatomic,retain)NSString *carName;
@property(nonatomic,retain)NSString *typeDesc;
@property(nonatomic,retain)NSString *takeDate;
@property(nonatomic,retain)NSString *returnDate;
@property(nonatomic,retain)NSString *orderStatus;
@property(nonatomic,retain)NSString *totalPrice;
@end


@interface GetOrderCarList : NSObject
@property(nonatomic,retain)NSMutableArray *carList;
@property(nonatomic,retain)NSString *totalPage;

+(GetOrderCarList*)GetOrderCarList:(NSDictionary *)dic;
@end
