//
//  CityPickerViewModel.m
//  FlightProject
//
//  Created by gaopengcheng on 14-9-4.
//
//

#import "CityPickerViewModel.h"

@implementation TsCounty

@synthesize _countyName;
-(void)dealloc
{
    self._countyName = nil;
    [super dealloc];
}

+(TsCounty *)setCountyData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    TsCounty * county = [[TsCounty alloc] init];
    county._countyName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"countyName"]];
    
    return [county autorelease];
}
@end


@implementation TsCity

@synthesize _cityName,_county;
-(void)dealloc
{
    self._county = nil;
    self._cityName = nil;
    [super dealloc];
}

+(TsCity *)setCityData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    TsCity * city = [[TsCity alloc] init];
    city._cityName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cityName"]];
    city._county = [dic objectForKey:@"countys"];
    
    return [city autorelease];
}
@end


@implementation TsProvince

@synthesize _citys,_provinceName;
-(void)dealloc
{
    self._provinceName = nil;
    self._citys = nil;
    [super dealloc];
}

+ (TsProvince *)setProvinceData:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    TsProvince *provinceData = [[TsProvince alloc] init];
    provinceData._provinceName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    provinceData._citys = [dic objectForKey:@"citys"];
    
    return [provinceData autorelease];
}
@end
