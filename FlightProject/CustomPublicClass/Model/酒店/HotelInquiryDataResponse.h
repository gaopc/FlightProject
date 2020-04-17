//
//  HotelInquiryDataResponse.h
//  FlightProject
//
//  Created by 崔立东 on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  酒店筛选接口
//

#import <Foundation/Foundation.h>

@interface HotelInquiryDataResponse : NSObject
@property (nonatomic,retain) NSArray * _administrativeAreaArray; //行政区
@property (nonatomic,retain) NSArray * _metroArray; //地铁数组
@property (nonatomic,retain) NSArray * _trafficArray; //交通枢纽
@property (nonatomic,retain) NSArray * _businessAreaArray; //交通枢纽
@property (nonatomic,retain) NSMutableArray * _chargesArray; //酒店房价
@property (nonatomic,retain) NSArray * _levelArray; //酒店房价
@property (nonatomic,retain) NSArray * _brandArray; //品牌 返回一定数量的品牌
@property (nonatomic,retain) NSMutableDictionary *_filterHoteDictionary;//酒店筛选字典
@property (nonatomic,retain) NSMutableDictionary *_hoteNameDictionary;//名称字典
@property (nonatomic,retain) NSMutableDictionary *_hoteInquiryNameDictionary;//名称字典


//酒店筛选
+ (HotelInquiryDataResponse *)inquiryHotel:(NSDictionary *)dic;
@end


@interface FilterHotelInfo : NSObject

@property (nonatomic,retain)NSString * _administrativeArea; // 行政区
@property (nonatomic,retain)NSString * _metro; //地铁
@property (nonatomic,retain)NSString * _traffic;// 交通枢纽
@property (nonatomic,retain)NSString * _businessArea; // 热门商圈
@property (nonatomic,retain)NSString * _charges; // 酒店房价
@property (nonatomic,retain)NSString * _level; // 酒店星级
@property (nonatomic,retain)NSString * _brand; // 品牌 返回一定数量的品牌

@end

@interface Metro : NSObject
@property (nonatomic,retain)NSString * _name; // 地铁
@property (nonatomic,retain)NSMutableArray * _metroInfoArray; // 信息
@end

@interface MetroInfo : NSObject
@property (nonatomic,retain)NSString * _name; // 站名
@property (nonatomic,retain)NSString * _longitude;//经度
@property (nonatomic,retain)NSString * _latitude; //纬度
@end

@interface Traffic : NSObject
@property (nonatomic,retain)NSString * _name; // 名称
@property (nonatomic,retain)NSString * _longitude;//经度
@property (nonatomic,retain)NSString * _latitude; //纬度
@end

@interface Brand : NSObject
@property (nonatomic,retain)NSString * _id; // 名称
@property (nonatomic,retain)NSString * _brandName;//名称






@end
