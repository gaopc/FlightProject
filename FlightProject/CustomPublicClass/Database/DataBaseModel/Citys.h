//
//  Citys.h
//  FlightProject
//
//  Created by longcd on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Citys : NSObject
@property (nonatomic,retain)NSString * _city_code;
@property (nonatomic,retain)NSString * _city_name;
@property (nonatomic,retain)NSString * _ename;
@property (nonatomic,retain)NSString * _first_letter;
@property (nonatomic,retain)NSString * _jian_pin;
@property (nonatomic,retain)NSString * _flag;

+(Citys *) cityFromElem:(NSArray *)array;
+(Citys*) citysWithNameCode:(NSString*)name code:(NSString*)code;
+(NSDictionary *) AirportCitysDicFromArray:(NSArray *)array hotName:(NSString *)hotName;

@end

@interface HotelCitys : Citys
//@property (nonatomic,retain) NSString * _city_code;
//@property (nonatomic,retain) NSString * _city_name;
//@property (nonatomic,retain) NSString * _first_letter;
//@property (nonatomic,retain) NSString * _flag;
//@property (nonatomic,retain)NSString * _jian_pin;
//@property (nonatomic,retain)NSString * _ename;

+(HotelCitys *) cityFromElem:(NSArray *)array;
@end

@interface CarCitys : Citys
//@property (nonatomic,retain) NSString * _city_code;
//@property (nonatomic,retain) NSString * _city_name;
//@property (nonatomic,retain) NSString * _first_letter;
//@property (nonatomic,retain) NSString * _flag;
//@property (nonatomic,retain)NSString * _jian_pin;
//@property (nonatomic,retain)NSString * _ename;

+(CarCitys *) cityFromElem:(NSArray *)array;
@end

@interface AirportList : Citys
//@property (nonatomic,retain) NSString * _airport_code;
//@property (nonatomic,retain) NSString * _airport_name;
//@property (nonatomic,retain) NSString * _first_letter;
//@property (nonatomic,retain) NSString * _flag;
//@property (nonatomic,retain)NSString * _jian_pin;
//@property (nonatomic,retain)NSString * _ename;

+(AirportList *) airportFromElem:(NSArray *)array;
@end

@interface TrainCitysList : Citys
//@property (nonatomic,retain) NSString * _airport_code;
//@property (nonatomic,retain) NSString * _airport_name;
//@property (nonatomic,retain) NSString * _first_letter;
//@property (nonatomic,retain) NSString * _flag;
//@property (nonatomic,retain)NSString * _jian_pin;
//@property (nonatomic,retain)NSString * _ename;

+(TrainCitysList *) airportFromElem:(NSArray *)array;
@end
