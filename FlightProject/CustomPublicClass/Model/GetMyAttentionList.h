//
//  GetMyAttentionList.h
//  FlightProject
//
//  Created by 月 小 on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAttention : NSObject
@property(nonatomic,retain)NSString *ids;
@property(nonatomic,retain)NSString *flightCompang;
@property(nonatomic,retain)NSString *flightLogo;
@property(nonatomic,retain)NSString *flightNo;
@property(nonatomic,retain)NSString *departure;
@property(nonatomic,retain)NSString *arrival;
@end

@interface GetMyAttentionList : NSObject
@property(nonatomic,retain)NSMutableArray *myAttentionList;

+(GetMyAttentionList*)getMyAttentionList:(NSDictionary *)dic;
@end
