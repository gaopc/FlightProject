//
//  CarModel.h
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject
@property (nonatomic,retain) NSString * _cityCode;
@property (nonatomic,retain) NSString * _storeCode;
@property (nonatomic,retain) NSString * _toCityCode;
@property (nonatomic,retain) NSString * _toStoreCode;
@property (nonatomic,retain) NSString * _fromDate;
@property (nonatomic,retain) NSString * _toDate;

@property (nonatomic,retain) NSString * _fromDateDsc;
@property (nonatomic,retain) NSString * _toDateDsc;

@property (nonatomic,retain) NSString * _storeCodeDsc;
@property (nonatomic,retain) NSString * _toStoreCodeDsc;

@end
