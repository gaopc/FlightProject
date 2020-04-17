//
//  GetEquipmentAddressResponse.m
//  FlightProject
//
//  Created by longcd on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetEquipmentAddressResponse.h"

@implementation CityAddrInfo

@synthesize equipmentAddress,province,city,longitude,latitude;
-(void)dealloc
{
    self.equipmentAddress = nil;
    self.province = nil;
    self.city = nil;
    self.longitude = nil;
    self.latitude = nil;
    [super dealloc];
}

@end

@implementation GetEquipmentAddressResponse
@synthesize totalCount,totalPageNum,cityAddrInfos;
-(void)dealloc
{
    self.totalCount = nil;
    self.totalPageNum = nil;
    self.cityAddrInfos = nil;
    [super dealloc];
}
+(CityAddrInfo *) getEquipmentAddressResponseWithElem:(NSArray *)elem
{
    CityAddrInfo * info = [[CityAddrInfo alloc] init];
    info.equipmentAddress = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
    info.province = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
    info.city = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
    info.longitude = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
    info.latitude = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
    return [info autorelease];

}
+(GetEquipmentAddressResponse *)getEquipmentAddressResponseWithArray:(NSArray *)resultArray
{
    GetEquipmentAddressResponse * cityAddressInfo = nil;
    if ([[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:0]] isEqualToString:@"0"]) {
        cityAddressInfo = [[GetEquipmentAddressResponse alloc] init];
        cityAddressInfo.totalCount = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:2]];
        cityAddressInfo.totalPageNum = [NSString stringWithFormat:@"%@",[resultArray objectAtIndex:3]];
        NSArray * array  = [resultArray objectAtIndex:4];
        NSMutableArray * tempArray = [[NSMutableArray alloc] init];
        for (NSArray * elem in array) {
            [tempArray addObject:[self getEquipmentAddressResponseWithElem:elem]];
        }
        cityAddressInfo.cityAddrInfos = tempArray;
        [tempArray release];
    }
    else {
        [UIAlertView alertViewWithMessage:[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:1]] ];
    }
    return [cityAddressInfo autorelease];

}
@end


@implementation GetEquipmentAddressByAddressResponse

@end
