//
//  HotelQueryDataResponse.h
//  FlightProject
//
//  Created by 崔立东 on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  酒店接口
//

#import <Foundation/Foundation.h>
@class HotelInfo;
@interface HotelQueryDataResponse : NSObject
@property (nonatomic,retain)NSString * _number; // 多少家酒店
@property (nonatomic,retain) NSMutableArray * _hotelQueryInfoArray; //旅馆列表
@property (nonatomic,retain) NSMutableArray * _roomTypeArray; //酒店房型
@property (nonatomic,retain) NSMutableArray * _hotelCommArray; //酒店评论
@property (nonatomic,retain) NSMutableArray * _picUrlArray; //酒店房型
@property (nonatomic,retain) NSMutableArray * _bankInfoArray; //银行数组
@property (nonatomic,retain) HotelInfo * _hotelInfo; //酒店信息

@property (nonatomic,retain) NSString * _lcdRate; //畅达币返点率
@property (nonatomic,retain) NSString * _lcdValue; //畅达币返值
@property (nonatomic,retain) NSString * _lcdActivityId; //畅达币有效天数
@property (nonatomic,retain) NSString * _specialOfferNumber; //今日特价酒店数量

//旅馆列表查询
+ (HotelQueryDataResponse *)hotelQuery:(NSDictionary *)dic;
//酒店详情
+ (HotelQueryDataResponse *)hotelInformation:(NSDictionary *)dic withHotelInfo:(HotelInfo *) hotelInfo;
//旅馆评论列表查询
+ (NSMutableArray *)queryComment:(NSDictionary *)dic;


@end

//酒店接口
@interface HotelInfo : NSObject
//酒店列表
@property (nonatomic,retain)NSString * _hotelId; 
@property (nonatomic,retain)NSString * _hotelName; // 酒店名称
@property (nonatomic,retain)NSString * _address; // 酒店地址
@property (nonatomic,retain)NSString * _picUrl; // 酒店图片地址
@property (nonatomic)int _starCode; // 酒店星级
@property (nonatomic)BOOL _diamond; //是否显示砖石
@property (nonatomic)float _lowestPrice; //double 最低价格
@property (nonatomic)float _rating;  //double 酒店评分
@property (nonatomic,retain)NSString * _districtName;  //行政区域名称
@property (nonatomic)int _returnLcdFee; //还多少畅达币
@property (nonatomic)int _dropFee; // 降,0表示不降


//酒店详情
@property (nonatomic,retain)NSString * _longitude; // 酒店经度
@property (nonatomic,retain)NSString * _latitude; // 酒店纬度
@property (nonatomic,retain)NSString * _featureInfo;  // 特色介绍
@property (nonatomic,retain)NSString * _generalAmenities; //设施与服务
@property (nonatomic,retain)NSString * _trafficAndAroundInformations; //交通状况
@property (nonatomic)BOOL _isCollection; //是否收藏
@property (nonatomic,retain) NSMutableArray * _picUrlListArray; //旅馆图片
@property (nonatomic,retain) NSMutableArray * _roomTypeArray; //房形


@end

//旅馆图片
@interface HotelPicUrl : NSObject

@property (nonatomic,retain)NSString * _smallPicUrls; // 小图
@property (nonatomic,retain)NSString * _picUrls; //大图

@end


//旅馆图片
@interface HotelRoomType : NSObject

@property (nonatomic,retain)NSString * _roomTypeId; 
@property (nonatomic)float _averagePrice; // double 均价
@property (nonatomic)float _totalPrice; // double 总价
@property (nonatomic,retain)NSString * _type;// 房型
@property (nonatomic,retain)NSString * _picUrl;// 房型小图片地址
@property (nonatomic,retain)NSString * _area; // 房间面积
@property (nonatomic,retain)NSString * _floor;// 楼层
@property (nonatomic,retain)NSString * _bedType;// 床的类型
@property (nonatomic,retain)NSString * _breakfast; // 早餐
@property (nonatomic,retain)NSString * _descrition; //担保条件
@property (nonatomic,retain)NSString * _network; //宽带无线
@property (nonatomic)int _minCheckinRooms; // 首日最少房间数
@property (nonatomic)float _firstDayPrice; //  首日价
@property (nonatomic)BOOL _isArriveTimeVouch; // 是否到店时间担保
@property (nonatomic,retain)NSString * _isRoomCountVouch;// 是否房量担保
@property (nonatomic,retain)NSString * _arriveEndTime; // 担保有效的最晚到店时间
@property (nonatomic,retain)NSString * _arriveStartTime; //担保有效的最早到店时间
@property (nonatomic,retain)NSString * _roomCount; //担保有效的房量
@property (nonatomic,retain)NSString * _vouchMoneyType; //担保金额类型
@property (nonatomic)int _ratePlanId; // 不推荐用户数
@property (nonatomic,retain)NSString * _guestType; //客户类型
@property (nonatomic)int _returnLcdFee; // 还多少畅达币 
@property (nonatomic)int _dropFee; // int 降,0表示不降,则反之
@property (nonatomic)BOOL _isScheduled; // 否可以预定
@property (nonatomic,retain)NSString * _totalLcdFee; //单间总返畅达币

@end

//酒店评论
@interface HotelCommentInfo : NSObject

@property (nonatomic,retain)NSString * _name; 
@property (nonatomic,retain)NSString * _time; 
@property (nonatomic,retain)NSString * _evaluate; 

@end

//酒店请求参数
@interface HotelRequestPara : NSObject

@property (nonatomic,retain)NSString * _cityCode; 
@property (nonatomic,retain)NSString * _checkInDate; // 入住日期
@property (nonatomic,retain)NSString * _checkOutDate;// 退房日期
@property (nonatomic,retain)NSString * _hotelName; 
@property (nonatomic,retain)NSString * _highestPrice;// 价格上限,为”0”时表示不限
@property (nonatomic,retain)NSString * _lowestPrice; // 价格下限,为”0”时表示不限
@property (nonatomic)int _star;  // 星级,具体的数字表示多少星级,0表示不限
@property (nonatomic,retain)NSString * _hotelBrandID;  // 酒店品牌ID

@property (nonatomic,retain)NSString  *_longitude;  //经度 只在地铁和交通枢纽有用
@property (nonatomic,retain)NSString  *_latitude;  //纬度 只在地铁和交通枢纽有用
@property (nonatomic)int _pageIndex;  // 当前页数 int

@property (nonatomic,retain)NSString * _byStar;  // 星级排序
@property (nonatomic,retain)NSString * _byPrice;  // 价格排序
@property (nonatomic,retain)NSString * _administrativeArea;  // 行政区
@property (nonatomic,retain)NSString * _businessArea;  // 商圈

@property (nonatomic,assign)BOOL _isSpecialOffer;  // 是否是今日特价酒店

@property (nonatomic, retain) NSString *_hotelArea; //地区
@property (nonatomic, retain) NSString *_hotelBrandName; // 酒店品牌ID
@property (nonatomic, retain) NSString *_starName; // 酒店品牌ID
@property (nonatomic, retain) NSString *_priceName; // 酒店品牌ID

@end

//银行信息
@interface BankInfo : NSObject

@property (nonatomic)int _id; 
@property (nonatomic)int _cvv; 
@property (nonatomic,retain)NSString * _bankName; 

@end


