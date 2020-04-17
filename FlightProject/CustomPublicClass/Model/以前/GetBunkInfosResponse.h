//
//  GetBunkInfosResponse.h
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataClass.h"

@interface BunkInfo : NSObject
@property (nonatomic,retain) NSString *airport_code;
@property (nonatomic,retain) NSString *cabin_code;
@property (nonatomic,retain) NSString *cabin_name;
@property (nonatomic,retain) NSString *standard_cabin_code;
@end

@interface GetBunkInfosResponse : NSObject
+(NSArray *) getBunkInfosResponseeWithArray:(NSArray * ) resultArray;
@end
