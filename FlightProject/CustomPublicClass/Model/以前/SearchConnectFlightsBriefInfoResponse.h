//
//  SearchConnectFlightsBriefInfoResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchFlightsBriefInfoResponse.h"

@interface SearchConnectFlightsBriefInfoRequest : RootRequestModel 

@property(nonatomic, retain) NSString *dptCity;
@property(nonatomic, retain) NSString *transit;
@property(nonatomic, retain) NSString *arrCity;
@property(nonatomic, retain) NSString *departureDate;

@end

@interface SearchConnectFlightsBriefInfoResponse : FlightsBriefInfo

@property (nonatomic,retain) NSString * legNum;

+(NSArray *)searchConnectFlightsBriefInfoResponseFirstWithArray:(NSArray *)resultArray;
+(NSArray *)searchConnectFlightsBriefInfoResponseSecondWithArray:(NSArray *)resultArray;
@end
