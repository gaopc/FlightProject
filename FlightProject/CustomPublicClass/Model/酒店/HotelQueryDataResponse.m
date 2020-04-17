//
//  HotelQueryDataResponse.m
//  FlightProject
//
//  Created by green kevin on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelQueryDataResponse.h"

@implementation HotelQueryDataResponse

@synthesize _number,_hotelQueryInfoArray,_roomTypeArray,_hotelInfo,_picUrlArray,_hotelCommArray,_bankInfoArray;
@synthesize _lcdRate,_lcdValue,_lcdActivityId,_specialOfferNumber;

-(void)dealloc
{
	self._number = nil;
	self._hotelQueryInfoArray = nil;
	self._hotelInfo = nil;
	self._roomTypeArray = nil;
	self._picUrlArray = nil;
	self._hotelCommArray = nil;
	self._bankInfoArray = nil;
	self._lcdRate = nil;
	self._lcdValue = nil;
	self._lcdActivityId =nil;
	self._specialOfferNumber = nil;
	[super dealloc];
}


//旅馆列表查询
+ (HotelQueryDataResponse *)hotelQuery:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	HotelQueryDataResponse * hotelQueryDR = [[[HotelQueryDataResponse  alloc] init] autorelease];
	hotelQueryDR._number =  [NSString stringWithFormat:@"%@",[[dic objectForKey:@"number"] isKindOfClass:[NSNull class]]?@"0":[dic objectForKey:@"number"]];
	hotelQueryDR._specialOfferNumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"specialOfferNumber"]];
	hotelQueryDR._lcdRate =   [dic objectForKey:@"lcdRate"];
	hotelQueryDR._lcdValue = [dic objectForKey:@"lcdValue"];
        hotelQueryDR._lcdActivityId = [NSString stringWithFormat:@"%@", [dic objectForKey:@"lcdActivityId"]];
	
	NSArray *autoInfolist = [dic valueForKey:@"hotel"];
	
	NSMutableArray *list = [[NSMutableArray alloc] init]; 
	if ([autoInfolist isKindOfClass:[NSArray class]]) {
		for (NSDictionary *dicList in autoInfolist) {
			HotelInfo *hotelInfo = [[HotelInfo alloc] init];
			hotelInfo._hotelId =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"hotelId"]];
			hotelInfo._hotelName =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"hotelName"]];
			hotelInfo._address = [NSString stringWithFormat:@"%@",[dicList objectForKey:@"address"]];
			hotelInfo._picUrl =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"picUrl"]];
			hotelInfo._starCode =  [[NSString stringWithFormat:@"%@", [dicList objectForKey:@"starCode"]]intValue];
			hotelInfo._diamond =  [[NSString stringWithFormat:@"%@", [dicList objectForKey:@"diamond"]]boolValue];
			hotelInfo._lowestPrice = [[NSString stringWithFormat:@"%@", [dicList objectForKey:@"lowestPrice"]]floatValue];
			hotelInfo._rating = [[NSString stringWithFormat:@"%@", [dicList objectForKey:@"rating"]]floatValue];
			hotelInfo._districtName =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"districtName"]];
			
			hotelInfo._returnLcdFee =  [[NSString stringWithFormat:@"%@",[dicList objectForKey:@"returnLcdFee"]] intValue]; 
			hotelInfo._dropFee =  [[NSString stringWithFormat:@"%@",[dicList objectForKey:@"dropFee"]] intValue]; 
			hotelInfo._longitude =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"longitude"]]; 
			hotelInfo._latitude =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"latitude"]]; 
			
			[list addObject: hotelInfo];
			[hotelInfo release];
		}
	}

	hotelQueryDR._hotelQueryInfoArray=list;
	[list release];
    if ([hotelQueryDR._hotelQueryInfoArray count] == 0) {
        hotelQueryDR._hotelQueryInfoArray = nil;
    }
	return hotelQueryDR;
}

//酒店详情
+ (HotelQueryDataResponse *)hotelInformation:(NSDictionary *)dic withHotelInfo:(HotelInfo *) hotelInfo
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	HotelQueryDataResponse * hotelInformation = [[[HotelQueryDataResponse  alloc] init] autorelease];
	
	hotelInfo._longitude =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"longitude"]];
        hotelInfo._latitude =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"latitude"]];
	hotelInfo._isCollection =   [[NSString stringWithFormat:@"%@",[dic objectForKey:@"collection"]] boolValue];;
	hotelInfo._featureInfo =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"featureInfo"]];
	hotelInfo._generalAmenities =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"generalAmenities"]];
	hotelInfo._trafficAndAroundInformations =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"trafficAndAroundInformations"]];
	
	hotelInformation._hotelInfo = hotelInfo;
	
	NSArray *picUrllist = [dic valueForKey:@"picUrlList"];
	NSMutableArray *plist = [[NSMutableArray alloc] init]; 
	if ([picUrllist isKindOfClass:[NSArray class]]) {
		for (NSDictionary *dicList in picUrllist) {
			HotelPicUrl *hotelPicUrl = [[HotelPicUrl alloc] init];
			hotelPicUrl._smallPicUrls =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"smallPicUrls"]];
			hotelPicUrl._picUrls =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"picUrls"]];
			[plist addObject: hotelPicUrl];
			[hotelPicUrl release];
		}
	}
	
	hotelInformation._picUrlArray=plist;
	[plist release];
    if ([hotelInformation._picUrlArray count]==0) {
        hotelInformation._picUrlArray = nil;
    }
	
	NSArray *roomTypelist = [dic valueForKey:@"roomType"];
	NSMutableArray *rlist = [[NSMutableArray alloc] init]; 
	if ([roomTypelist isKindOfClass:[NSArray class]]) {
		for (NSDictionary *dicList in roomTypelist) {
			HotelRoomType *roomType = [[HotelRoomType alloc] init];
			roomType._roomTypeId =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"roomTypeId"]];
			roomType._averagePrice =  [[NSString stringWithFormat:@"%@",[dicList objectForKey:@"averagePrice"]]floatValue];
			roomType._totalPrice =  [[NSString stringWithFormat:@"%@",[dicList objectForKey:@"totalPrice"]]floatValue];
			
			roomType._type =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"type"]];
			roomType._picUrl =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"picUrl"]];
			roomType._area =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"area"]];
			roomType._floor =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"floor"]];
			roomType._bedType =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"bedType"]];
			roomType._breakfast =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"breakfast"]];
			roomType._descrition =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"descrition"]];
			roomType._network =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"network"]];
			
			roomType._minCheckinRooms =   [[NSString stringWithFormat:@"%@",[dicList objectForKey:@"minCheckinRooms"]] intValue];
			roomType._firstDayPrice =   [[NSString stringWithFormat:@"%@",[dicList objectForKey:@"firstDayPrice"]] floatValue];
			roomType._isArriveTimeVouch =   [[NSString stringWithFormat:@"%@",[dicList objectForKey:@"isArriveTimeVouch"]] boolValue];
			roomType._isRoomCountVouch =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"isRoomCountVouch"]];
			roomType._arriveEndTime =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"arriveEndTime"]];
			roomType._arriveStartTime =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"arriveStartTime"]];
			roomType._roomCount =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"roomCount"]];
			roomType._vouchMoneyType =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"vouchMoneyType"]];
			roomType._ratePlanId =   [[NSString stringWithFormat:@"%@",[dicList objectForKey:@"ratePlanId"]] intValue];
			roomType._guestType =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"guestType"]];
			roomType._returnLcdFee=   [[NSString stringWithFormat:@"%@",[dicList objectForKey:@"returnLcdFee"]]intValue ];
			roomType._dropFee =   [[NSString stringWithFormat:@"%@",[dicList objectForKey:@"dropFee"]] intValue];
			roomType._isScheduled =   [[NSString stringWithFormat:@"%@",[dicList objectForKey:@"scheduled"]] boolValue];
            
                        roomType._totalLcdFee =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"totalLcdFee"]];
            
			[rlist addObject: roomType];
			[roomType release];
		}
	}
	
	hotelInformation._roomTypeArray=rlist;
	[rlist release];
	if ([hotelInformation._roomTypeArray count] == 0) {
        hotelInformation._roomTypeArray = nil;
    }
	return hotelInformation;
}

//旅馆评论列表查询
+ (NSMutableArray *)queryComment:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray *autoInfolist = [dic valueForKey:@"commentList"];
	//NSMutableArray *list = [[NSMutableArray alloc] init]; 
	NSMutableArray *list = [NSMutableArray array];

	if ([autoInfolist isKindOfClass:[NSArray class]]) {
		for (NSDictionary *dicList in autoInfolist) {
			HotelCommentInfo *hotelCommentInfo = [[HotelCommentInfo alloc] init];
			hotelCommentInfo._name =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"name"]];
			hotelCommentInfo._time =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"time"]];
			hotelCommentInfo._evaluate = [NSString stringWithFormat:@"%@",[dicList objectForKey:@"evaluate"]];
			
			[list addObject: hotelCommentInfo];
			[hotelCommentInfo release];
		}
	}
	if ([list count] == 0) {
        return nil;
    }
	return list;
	
}





@end


@implementation HotelInfo

@synthesize _hotelId,_hotelName,_address,_picUrl,_starCode,_diamond,_lowestPrice,_rating,_districtName,_longitude,_latitude,_featureInfo,_generalAmenities,_trafficAndAroundInformations,_returnLcdFee,_dropFee,_picUrlListArray,_roomTypeArray,_isCollection;

-(void)dealloc
{
	self._hotelId = nil;
	self._hotelName = nil;
	self._address = nil;
	self._picUrl = nil;
	self._lowestPrice = 0.0;
	self._rating = 0.0;
	self._diamond = FALSE;
	self._isCollection = FALSE;
	self._districtName = nil;
        self._starCode = 0;
	self._latitude = nil;
	self._longitude = nil;
	self._featureInfo = nil;
	self._generalAmenities = nil;
	self._trafficAndAroundInformations = nil;
	self._dropFee = 0;
	self._returnLcdFee = 0;
	self._picUrlListArray = nil;
	self._roomTypeArray = nil;
	
	[super dealloc];
}

@end

@implementation HotelPicUrl
@synthesize _smallPicUrls,_picUrls;

-(void)dealloc
{
	self._smallPicUrls = nil;
	self._picUrls = nil;
	[super dealloc];
}

@end

@implementation HotelRoomType

@synthesize _roomTypeId,_averagePrice,_totalPrice,_type,_picUrl,_area,_floor,_bedType,_breakfast,_descrition,_network,_minCheckinRooms,_firstDayPrice,_isArriveTimeVouch,_isRoomCountVouch,_arriveEndTime,_arriveStartTime,_roomCount,_vouchMoneyType,_ratePlanId,_guestType,_returnLcdFee,_dropFee,_isScheduled;

@synthesize _totalLcdFee;

-(void)dealloc
{
	self._roomTypeId = nil;
	self._averagePrice = 0.0;
	self._totalPrice = 0.0;
	self._type = nil;
	self._picUrl = nil;
	self._area = nil;
	
	self._floor = nil;
	self._bedType = nil;
	self._breakfast = nil;
	self._descrition = nil;
	self._network = nil;
	self._minCheckinRooms = 0;
	self._firstDayPrice = 0.0;
	self._isArriveTimeVouch = 0.0;
	self._arriveEndTime = nil;
	self._arriveStartTime  = nil;
	self._roomCount = nil;
	self._vouchMoneyType = nil;
	self._ratePlanId  = 0;
	self._guestType = nil;
	self._isArriveTimeVouch = TRUE;
	self._isScheduled =TRUE;
	self._dropFee = 0;
	self._returnLcdFee = 0;
    
    self._totalLcdFee = 0;
	[super dealloc];
}

@end


@implementation HotelCommentInfo
@synthesize _name,_time,_evaluate;

-(void)dealloc
{
	self._name = nil;
	self._time = nil;
	self._evaluate = nil;
	[super dealloc];
}

@end



@implementation HotelRequestPara
@synthesize _cityCode,_checkInDate,_checkOutDate,_hotelName,_highestPrice,_lowestPrice,_star,_hotelBrandID,_longitude,_latitude,_pageIndex,_byStar,_byPrice,_administrativeArea,_businessArea,_isSpecialOffer;
@synthesize _hotelArea,_hotelBrandName,_starName,_priceName;
-(void)dealloc
{
	self._cityCode = nil;
	self._checkInDate = nil;
	self._checkOutDate = nil;
	self._hotelName = nil;
	self._highestPrice = nil;
	self._lowestPrice = nil;
	self._star = 0;
	self._hotelBrandID = nil;
	self._longitude = nil;
	self._latitude = nil;
	self._pageIndex = 0;
	self._byStar = nil;
	self._byPrice = nil;
	self._administrativeArea = nil;
	self._businessArea = nil;
	self._isSpecialOffer = FALSE;
	self._hotelArea = nil;
	self._hotelBrandName = nil;
	self._starName = nil;
	self._priceName = nil;
	
	[super dealloc];
}

@end

@implementation BankInfo
@synthesize _id,_cvv,_bankName;

-(void)dealloc
{
	self._id = 0;
	self._cvv = 0;
	self._bankName = nil;
	[super dealloc];
}

@end

