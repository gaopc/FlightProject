//
//  UpdateOrdercontactorResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactorInfo.h"
@interface UpdateOrdercontactorRequst:NSObject
@property (nonatomic,retain)NSString * userID;
@property (nonatomic,retain)NSString * orderID;
@property (nonatomic,retain)ContactorInfo * contactor;
@end

@interface UpdateOrdercontactorResponse : NSObject
+(void)updateOrdercontactorResponseWithArray:(NSArray *)resultArray;
@end
