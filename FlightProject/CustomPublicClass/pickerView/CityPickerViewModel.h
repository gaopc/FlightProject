//
//  CityPickerViewModel.h
//  FlightProject
//
//  Created by gaopengcheng on 14-9-4.
//
//

#import <Foundation/Foundation.h>

@interface TsCounty : NSObject
@property (nonatomic, retain) NSString *_countyName;
+(TsCounty *)setCountyData:(NSDictionary *)dic;
@end

@interface TsCity : NSObject
@property (nonatomic, retain) NSMutableArray *_county;
@property (nonatomic, retain) NSString *_cityName;
+(TsCity *)setCityData:(NSDictionary *)dic;
@end

@interface TsProvince : NSObject
@property (nonatomic,retain) NSMutableArray * _citys;
@property (nonatomic,retain) NSString * _provinceName;
+ (TsProvince *)setProvinceData:(NSDictionary *)dic;
@end

