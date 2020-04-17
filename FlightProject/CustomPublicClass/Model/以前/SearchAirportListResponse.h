//
//  SearchAirportListResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirportInfo : NSObject
@property (nonatomic,retain) NSString * airportID;
@property (nonatomic,retain) NSString * airportName;
@end


@interface SearchAirportListResponse : NSObject
+(NSArray *)searchAirportLisResponseWithArray:(NSArray *)resultArray;
@end
