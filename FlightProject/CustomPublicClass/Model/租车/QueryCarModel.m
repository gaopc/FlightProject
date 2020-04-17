//
//  QueryCarModel.m
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QueryCarModel.h"

@implementation QueryCarModel

@synthesize _pageIndex;

-(void)dealloc
{
    [super dealloc];
}

@end

@implementation CarModelDetail

@synthesize  _modeCode,_picUrl,_typeDesc,_typeName,_insurance,_preAuthorization,_dayPrice,_modeLevel,_modeLevelName;
@synthesize _levelType;
@synthesize _packageType, _packageInfo;
@synthesize _orderType, _productType;
-(void)dealloc
{
    self._orderType = nil;
    self._productType = nil;
    self._modeLevel = nil;
    self._picUrl = nil;
    self._typeName = nil;
    self._typeDesc = nil;
    self._insurance = nil;
    self._preAuthorization = nil;
    self._dayPrice = nil;
    self._modeLevel = nil;
    self._modeLevelName = nil;
    self._levelType = nil;
    self._packageType = nil;
    self._packageInfo = nil;
    [super dealloc];
}
+(id)CarModelDetail:(NSDictionary * )resultDic
{
    if (![resultDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    CarModelDetail * aClass = (CarModelDetail *) [[[self class] alloc] init];
    aClass._modeCode = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"modeCode"]];
    aClass._picUrl = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"picUrl"]];
    aClass._typeDesc = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"typeDesc"]];
    aClass._typeName = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"typeName"]];
    aClass._insurance = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"insurance"]];
    aClass._preAuthorization = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"preAuthorization"]];
    aClass._dayPrice = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"dayPrice"]];
    aClass._modeLevelName = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"modeLevelName"]];
    aClass._modeLevel = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"modeLevel"]];
    aClass._levelType = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"levelType"]];
    aClass._orderType = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"orderType"]];
    aClass._productType = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"productType"]];
    
    NSDictionary *tmp = [resultDic objectForKey:@"packages"];
    if ([tmp isKindOfClass:[NSDictionary class]]) {
        aClass._packageInfo = [CarPackageResponse CarPackageInfo:tmp];
        aClass._packageType = @"1";
    }
    else{
        aClass._packageInfo = nil;
        aClass._packageType = @"0";
    }
//     aClass._packageType = @"1";
    
    return  [aClass autorelease];
}
@end

@implementation QueryCarModelResponse
@synthesize _storeCode;
@synthesize _deptype;
@synthesize _shopName,_shopAddress;
@synthesize  _detail;
-(void)dealloc
{
    self._storeCode = nil;
    self._deptype = nil;
    self._shopName = nil;
    self._shopAddress = nil;
    self._detail = nil;
    [super dealloc];
}

+(NSArray *)QueryCarModelResponse:(NSDictionary *)resultDic
{
    if (![resultDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSMutableArray * queryCarModelResponseArray = [NSMutableArray array];
    NSArray * carModeArray = [resultDic objectForKey:@"carModel"];
    if ([carModeArray isKindOfClass:[NSArray class]]) {
        for (NSDictionary * carModeArrayDic in carModeArray) {
            QueryCarModelResponse * instance = [self CarModelDetail:carModeArrayDic];
            instance._storeCode = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"storeCode"]];
            instance._deptype = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"deptype"]];
            instance._shopName = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"shopName"]];
            instance._shopAddress = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"shopAddress"]];
            instance._detail = [NSMutableArray array];
            if ([instance._levelType intValue] == 0) {
                [instance._detail addObject:[self CarModelDetail:carModeArrayDic]];
            }
            NSArray * carModeDetailArray = [carModeArrayDic objectForKey:@"detail"];
            for (NSDictionary * detailDic in carModeDetailArray) {
                [instance._detail addObject:[self CarModelDetail:detailDic]];
            }
            [queryCarModelResponseArray addObject:instance];
        }
    }
    if ([queryCarModelResponseArray count] == 0) {
        return nil;
    }
    return queryCarModelResponseArray;
}

@end


@implementation CarPackageResponse
@synthesize _day, _discount, _packageInfo, _total;
@synthesize _orderType, _productType;

- (void)dealloc
{
    self._productType = nil;
    self._orderType = nil;
    self._day = nil;
    self._discount = nil;
    self._packageInfo = nil;
    self._total = nil;
    [super dealloc];
}

+ (CarPackageResponse *)CarPackageInfo:(NSDictionary * )dic
{
    CarPackageResponse * pClass = [[CarPackageResponse alloc] init];
    pClass._total = [NSString stringWithFormat:@"%@", [dic objectForKey:@"total"]];
    pClass._discount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"discount"]];
    pClass._day = [NSString stringWithFormat:@"%@",[dic objectForKey:@"day"]];
    pClass._packageInfo = [NSString stringWithFormat:@"%@",[dic objectForKey:@"packageInfo"]];
    pClass._orderType = [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderType"]];
    pClass._productType = [NSString stringWithFormat:@"%@",[dic objectForKey:@"productType"]];
    return [pClass autorelease];
}
@end
