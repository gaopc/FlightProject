//
//  CarModel.m
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel
@synthesize _cityCode,_storeCode,_toCityCode,_toStoreCode,_fromDate,_toDate;
@synthesize _fromDateDsc,_toDateDsc;
@synthesize _storeCodeDsc,_toStoreCodeDsc;
-(void)dealloc
{
    self._cityCode = nil;
    self._storeCode = nil;
    self._toCityCode = nil;
    self._toStoreCode = nil;
    self._fromDate = nil;
    self._toDate = nil;
    
    self._fromDateDsc = nil;
    self._toDateDsc = nil;
    
    self._storeCodeDsc = nil;
    self._toStoreCodeDsc = nil;
    [super dealloc];
}

@end
