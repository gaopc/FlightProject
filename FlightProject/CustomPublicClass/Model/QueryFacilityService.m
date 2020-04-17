//
//  QueryFacilityService.m
//  FlightProject
//
//  Created by 月 小 on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QueryFacilityService.h"
@implementation FacilityServiceData
@synthesize ids,name;

- (void)dealloc
{
    self.ids = nil;
    self.name = nil;
    [super dealloc];
}

@end

@implementation QueryFacilityService
@synthesize serviceList;

- (void)dealloc
{
    self.serviceList = nil;
    [super dealloc];
}

+(QueryFacilityService*)GetQueryFacilityServiceByAirportCode:(NSDictionary*)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    QueryFacilityService *queryFacilityService = [[QueryFacilityService alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *temp = [dic objectForKey:@"serviceList"];
    if ([temp isKindOfClass:[NSArray class]]) {
        for(id elem in temp)
        {
            FacilityServiceData *facilityServiceData = [[FacilityServiceData alloc] init];
            facilityServiceData.ids = [NSString stringWithFormat:@"%@",[elem objectForKey:@"id"]];
            facilityServiceData.name = [NSString stringWithFormat:@"%@",[elem objectForKey:@"name"]];
            [array addObject:facilityServiceData];
            [facilityServiceData release];
        }
    }
   
    queryFacilityService.serviceList = array;
    [array release];
    if ([queryFacilityService.serviceList count] == 0) {
        queryFacilityService.serviceList = nil;
    }
    return [queryFacilityService autorelease];
}
@end
