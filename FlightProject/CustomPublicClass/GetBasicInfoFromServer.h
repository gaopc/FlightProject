//
//  GetBasicInfoFromServer.h
//  FlightProject
//
//  Created by longcd on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterfaceClass.h"
#import "SendRequstCatchQueue.h"
#import "DataClass.h"
#import "GetConfiguration.h"

@protocol CityListDelegate <NSObject>
@optional
- (void)didCityInfoResult:(NSArray *)cityArray;
- (void)didBasicInfoResult:(NSDictionary *)dic;
@end


@interface GetBasicInfoFromServer : NSObject

@property (nonatomic,retain) id delegate;
@property (nonatomic, assign) id <CityListDelegate>cityDelegate;
@property (nonatomic,retain) NSDictionary *configerDic;

-(void) getConfiguration:(NSString *)deviceToken;
-(void) onConfigurationPaseredResult:(NSDictionary *) resultDic;

- (void)getAirportInfo;
- (void)getAirportCityInfo;
- (void)getHotelCityList;
- (void)getCarRentalList;
- (void) getTrainCitysVersion;
- (void)getTrainCitysList;
- (void)getWeatherCitysList;
- (NSArray *)getVersionsFromDB;
@end
