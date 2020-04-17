//
//  QueryCarStore.h
//  FlightProject
//
//  Created by dyl mac mini 04 on 12-10-22.
//
//

#import <Foundation/Foundation.h>

@interface CarStore : NSObject
@property(nonatomic,retain)NSString *_areaCode;
@property(nonatomic,retain)NSString *_areaName;
@property(nonatomic,retain)NSArray *_shops;

@end

@interface Shops : NSObject
@property(nonatomic,retain)NSString *_storeCode;
@property(nonatomic,retain)NSString *_shopName;
@property(nonatomic,retain)NSString *_shopAddress;
@property(nonatomic,retain)NSString *_startOpeningHours;
@property(nonatomic,retain)NSString *_endOpeningHours;
@property(nonatomic,retain)NSString *_deptype;
@end

@interface QueryCarStore : NSObject

+(NSArray *)getQueryCarStore:(NSDictionary *)dic;
@end