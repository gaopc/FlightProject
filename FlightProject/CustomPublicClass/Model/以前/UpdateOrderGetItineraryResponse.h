//
//  UpdateOrderGetItineraryResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MailPsgInfo.h"
@interface UpdateOrderGetItineraryRequst:NSObject
@property (nonatomic,retain)NSString * orderID;
@property (nonatomic,retain)NSString * getLtinerary;
@property (nonatomic,retain)MailPsgInfo * mailPsg;
@end

@interface UpdateOrderGetItineraryResponse : NSObject
+(void)updateOrderGetItineraryResponseWithArray:(NSArray *)resultArray;
@end
