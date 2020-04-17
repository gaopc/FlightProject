//
//  GetOrderCarInformation.m
//  FlightProject
//
//  Created by 月 小 on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetOrderCarInformation.h"

@implementation GetOrderCarInformation
@synthesize _orderNumber,_orderStatus,_orderType,_takeShop,_returnShop,_bussinessTime,_typeName,_typeDesc,_service,_preAuthorization,_rent,_insuranceAmount,_selectedService,_totalCarRentMoney,_lcdFee,_serviceFee, _fromDate, _identityNumber, _mobileNumber, _name, _submitDate, _toDate;

- (void)dealloc
{
    self._orderNumber = nil;
    self._orderStatus = nil;
    self._orderType = nil;
    self._takeShop = nil;
    self._returnShop = nil;
    self._bussinessTime = nil;
    self._typeName = nil;
    self._typeDesc = nil;
    self._service = nil;
    self._preAuthorization = nil;
    self._rent = nil;
    self._insuranceAmount = nil;
    self._selectedService = nil;
    self._totalCarRentMoney = nil;
    self._lcdFee = nil;
    self._serviceFee = nil;
    
    self._fromDate = nil;
    self._identityNumber = nil;
    self._mobileNumber = nil;
    self._name = nil;
    self._submitDate = nil;
    self._toDate = nil;
    [super dealloc];
}
//[NSString stringWithFormat:@"%@", ]
+(GetOrderCarInformation*)GetOrderCarInformation:(NSDictionary*)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    GetOrderCarInformation *getOrderCarInformation = [[GetOrderCarInformation alloc] init];
    getOrderCarInformation._orderNumber = [NSString stringWithFormat:@"%@", [dic objectForKey:@"orderNumber"]];
    getOrderCarInformation._orderStatus = [NSString stringWithFormat:@"%@", [dic objectForKey:@"orderStatus"]];
    getOrderCarInformation._orderType = [NSString stringWithFormat:@"%@", [dic objectForKey:@"orderType"]];
    getOrderCarInformation._takeShop = [NSString stringWithFormat:@"%@", [dic objectForKey:@"takeShop"]];
    getOrderCarInformation._returnShop = [NSString stringWithFormat:@"%@", [dic objectForKey:@"returnShop"]];
    getOrderCarInformation._bussinessTime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"bussinessTime"]];
    getOrderCarInformation._typeName = [NSString stringWithFormat:@"%@", [dic objectForKey:@"typeName"]];
    getOrderCarInformation._typeDesc = [NSString stringWithFormat:@"%@", [dic objectForKey:@"typeDesc"]];
    getOrderCarInformation._service = [NSString stringWithFormat:@"%@", [dic objectForKey:@"service"]];
    getOrderCarInformation._preAuthorization = [NSString stringWithFormat:@"%@", [dic objectForKey:@"preAuthorization"]];
    getOrderCarInformation._rent = [NSString stringWithFormat:@"%@", [dic objectForKey:@"rent"]];
    getOrderCarInformation._insuranceAmount = [NSString stringWithFormat:@"%@", [dic objectForKey:@"insuranceAmount"]];
    
    NSString * _serviecFee =  [dic objectForKey:@"selectedService"];
    if ([_serviecFee isKindOfClass:[NSNull class]] || _serviecFee.length == 0) {
        getOrderCarInformation._selectedService = nil;
    }
    else {
        NSMutableArray * mArray = [NSMutableArray array];
        for (NSString * elem in [_serviecFee componentsSeparatedByString:@","]) {
            NSArray * array = [elem componentsSeparatedByString:@"￥"];
            CarServiceList * service = [[CarServiceList alloc] init];
            service._serviceName = [array objectAtIndex:0];
            if ([array count] > 1) {
                service._servicePrice = [array objectAtIndex:1];
            }
            [mArray addObject:service];
            [service release];
        }
        if ([mArray count]>0) {
            getOrderCarInformation._selectedService = mArray;
        }
        else{
            getOrderCarInformation._selectedService = nil;
        }
    }
    
    getOrderCarInformation._totalCarRentMoney = [NSString stringWithFormat:@"%@", [dic objectForKey:@"totalCarRentMoney"]];
    getOrderCarInformation._lcdFee = [NSString stringWithFormat:@"%@", [dic objectForKey:@"lcdFee"]];
    getOrderCarInformation._serviceFee = [NSString stringWithFormat:@"%@", [dic objectForKey:@"serviceFee"]];
    
    getOrderCarInformation._fromDate = [NSString stringWithFormat:@"%@", [dic objectForKey:@"fromDate"]];
    getOrderCarInformation._toDate = [NSString stringWithFormat:@"%@", [dic objectForKey:@"toDate"]];
    getOrderCarInformation._submitDate = [NSString stringWithFormat:@"%@", [dic objectForKey:@"submitDate"]];
    getOrderCarInformation._name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
    getOrderCarInformation._identityNumber = [NSString stringWithFormat:@"%@", [dic objectForKey:@"identityNumber"]];
    getOrderCarInformation._mobileNumber = [NSString stringWithFormat:@"%@", [dic objectForKey:@"mobileNumber"]];
    return [getOrderCarInformation autorelease];
    
}
@end
