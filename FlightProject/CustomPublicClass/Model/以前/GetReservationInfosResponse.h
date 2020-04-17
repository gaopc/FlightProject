//
//  GetReservationInfosResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddReservationResponse.h"
@interface ReservationInfos : ReservationInfo
@property (nonatomic,retain) NSString * reservationID;
@end

@interface GetReservationInfosResponse : NSObject
+(NSArray *)getReservationInfosResponseWithArray:(NSArray *)resultArray;
@end
