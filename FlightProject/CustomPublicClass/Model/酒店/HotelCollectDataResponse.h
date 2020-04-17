//
//  HotelCollectDataResponse.h
//  FlightProject
//
//  Created by z1 on 13-6-26.
//
//

#import <Foundation/Foundation.h>

@interface HotelCollectDataResponse : NSObject
@property (nonatomic,retain) NSMutableArray * _hotelCollectQueryArray; //收藏列表
@property(nonatomic,assign) int _totalPage;

+ (HotelCollectDataResponse *)hotelCollectQuery:(NSDictionary *)dic;
//收藏成功提示
+ (NSString*)hotelCollectAddMessage:(NSDictionary *)dic;
//收藏删除成功提示
+ (NSString*)hotelCollectDelMessage:(NSDictionary *)dic;
@end

//酒店收藏
@interface HotelCollect : NSObject

@property (nonatomic,retain)NSString * _hotelId;
@property (nonatomic,retain)NSString * _hotelName; // 酒店名称
@property (nonatomic)int _starCode; // 酒店星级
@property (nonatomic)BOOL _diamond; //是否显示砖石
@property (nonatomic)float _rating;  //double 酒店评分
@property (nonatomic,retain)NSString * _districtName;  //行政区域名称
@property (nonatomic,retain)NSString * _city;  //城市名
@property (nonatomic,retain)NSString * _cityCode; // 酒店地址

@end