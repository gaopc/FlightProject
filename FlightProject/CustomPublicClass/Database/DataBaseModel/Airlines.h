//
//  Airlines.h
//  FlightProject
//
//  Created by longcd on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Airlines : NSObject
@property (nonatomic,retain)NSString * _airline_code;
@property (nonatomic,retain)NSString * _airline_name;
@property (nonatomic,retain)NSString * _airline_name_abbreviation;
@property (nonatomic,retain)NSString * _airline_telephone;
@property (nonatomic,retain)NSString * _airline_png;
+(NSArray *)AirlinesWithArray:(NSArray *)array;
@end
