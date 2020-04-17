//
//  QueryFacilityService.h
//  FlightProject
//
//  Created by 月 小 on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface FacilityServiceData : NSObject
@property(nonatomic,retain)NSString *ids;
@property(nonatomic,retain)NSString *name;
@end

@interface QueryFacilityService : NSObject
@property(nonatomic,retain)NSArray *serviceList;

+(QueryFacilityService*)GetQueryFacilityServiceByAirportCode:(NSDictionary*)dic;
@end
