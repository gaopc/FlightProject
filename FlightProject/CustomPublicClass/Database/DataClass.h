//
//  DataClass.h
//  FlightProject
//
//  Created by longcd on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

// 所有用到的和数据库交互的具体方法，可以直接在这个类中写方法

#import <Foundation/Foundation.h>
#import "DataBaseClass.h"
#import "Citys.h"
#import "Airlines.h"

@interface DataClass : NSObject

// 20121008 zxt 重新创建数据库
// --------添加
+(void) insertIntoAirportCityListWithArray:(NSArray *)array;
+(void) insertIntoAirportListWithArray:(NSArray *)array;
+(void) insertIntointernationalAirportCityListWithArray:(NSArray *)array;//3.6期
+(void) insertIntoCarRentalListWithArray:(NSArray *)array;
+(void) insertIntoTrainCitysListWithArray:(NSArray *)array;
+(void) insertIntoWeatherCitysListWithArray:(NSArray *)array;

+(void) insertIntoHotelCityListWithArray:(NSArray *)array;
+(BOOL) insertIntoFlight_City_HistortyWithArray:(NSArray *)array;
+(BOOL) insertIntoFlight_Num_HistortyWithArray:(NSArray *)array;
+(void) insertIntoFlight_City_HotWithArray:(NSArray *)array;
+(BOOL) insertIntoFlight_Search_HistoryWithArray:(NSArray *)array;
+(BOOL) insertIntoTrain_Num_HistoryWithArray:(NSArray *)array;
+(BOOL) insertIntoTrain_Station_HistoryWithArray:(NSArray *)array;
+ (BOOL) insertIntoTrain_Searth_HistoryWithArray:(NSArray *)array;

// --------查询
+(NSArray *) selectFromAirportCityList;
+(NSArray *) selectFromWeatherCityList;
+(NSArray *) selectFromIntointernationalAirportCityList;//3.6期
+(NSArray *) selectFromAirportList;
+(NSArray *) selectFromCarRentalList;
+(NSArray *) selectFromHotelCityList;
+(NSArray *) selectFromTrainCitysList;
+(NSArray *) selectAllFromTrainCitysList;
+(NSArray *) selectFromFlight_City_Historty;
+(NSArray *) selectFromFlight_Num_Historty;
+(NSArray *) selectFromFlight_Search_History;
+(NSArray *) selectFromVersions;
+(NSArray *) selectFromTrain_Num_History;
+(NSArray *) selectFromTrain_Station_History;
+ (NSArray *) selectFromTrain_Search_History;

+(NSString * ) selectFromAirportCityListWithCityName:(NSString *)cityName;
+(NSString * ) selectFromAirportCityListWithCityCode:(NSString *)cityCode;
+(NSString *  ) selectFromHotelCityListWithCityName:(NSString *)cityName;
+(NSString *  ) selectFromCarRentalListWithCityName:(NSString *)cityName;
+(NSString *  ) selectFromCarRentalListWithCityCode:(NSString *)cityCode;

// --------删除
// 20121008 zxt 重新创建数据库

+(void)insertIntoCitysWithArray:(NSArray *)array;
+(void) insertintoBunk_infoWithArray:(NSArray *)array;
+(NSString *)selectBunkInfoVersion;
+(void) insertintoDirectCityWithArray:(NSArray *)array;
+(NSString *)selectDirectCityVersion;
+(void)insertIntoDeviceAddressWithArray:(NSArray *)array;
+(void)insertIntoAirlinesWithArray:(NSArray *)array;
+(NSArray *)selectAirlines;
+(NSString *)selectFromAirlinesWithCode:(NSString *)code;
+(NSString *)selectFromCitysWithCode:(NSString *)code;
+(NSString *)selectCityNameFromCitysWithCode:(NSString *)code;
+(NSString *) selectFromBunkInfoWithCode:(NSString *)code;
+(bool)selectFormDirectCityWithFrom:(NSString *)fromCity addArr:(NSString*)arrCity;
+(NSArray *)selectConnectCitysFormDirectCityWithFrom:(NSString *)fromCity addArr:(NSString*)arrCity;
+ (NSArray *)selectDeviceAddress:(NSString *) cityName;       //获取城市经纬度
+ (NSArray *)selectDeviceAddressCitys;
+(NSString *)selectAirlineNameFromAirlinesWithCode:(NSString *)code;
/* // 先注释掉，如有需要再拿出来
+(NSArray *) selectFromFlightquery;
+(void) deleteFlightqueryWithMinseqid:(NSString *)seqid;
+(void) deleteFlightquery:(NSString *)fromC second:(NSString *)toC;
+(NSArray *) selectFromLandingGround;
+(NSArray *) selectDptCityFromLandingGround:(NSString * )fromCity add:(NSString *)toCity;
+(NSArray *) selectFromFlightnumtable;
+(void) insertintoFlightnumtableWithNum:(NSString *)num;
+(NSArray *) selectFromFlightnumtableWithNum:(NSString * )num;
+(void) deleteFlightnumtable;
+(void) deleteLandingGround;
+(void) deleteBunkInfo;
+(void) insertintoLogtableWithText:(NSString *)text;
+(NSArray *) selectBunkinfoWithKey:(NSString *)key;
+(NSArray *) selectRoutemaptable;
+(void) insertintoRoutemapTableWithArray:(NSArray *)dataArray;
+(NSArray *) selectDirectRoute:(NSString *)fromCity second:(NSString *)toCity;
+(NSArray *) selectTransitRoute:(NSString *)fromCity second:(NSString *)toCity;
+(void) insertintoFlightquery:(NSString *)fromCity add:(NSString *) toCity;
 */
@end
