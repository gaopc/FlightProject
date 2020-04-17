//
//  HotelCollectDataResponse.m
//  FlightProject
//
//  Created by z1 on 13-6-26.
//
//

#import "HotelCollectDataResponse.h"

@implementation HotelCollectDataResponse
@synthesize _totalPage,_hotelCollectQueryArray;

-(void)dealloc
{
	self._hotelCollectQueryArray = nil;

	[super dealloc];
}

//旅馆收藏列表查询
+ (HotelCollectDataResponse *)hotelCollectQuery:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	HotelCollectDataResponse * hotelCollectQueryDR = [[[HotelCollectDataResponse  alloc] init] autorelease];
	hotelCollectQueryDR._totalPage = [[NSString stringWithFormat:@"%@", [dic objectForKey:@"totalPage"]]intValue];
	NSArray *autoInfolist = [dic valueForKey:@"list"];
	NSMutableArray *list = [[NSMutableArray alloc] init];
	if ([autoInfolist isKindOfClass:[NSArray class]]) {
		for (NSDictionary *dicList in autoInfolist) {
			HotelCollect *hotelInfo = [[HotelCollect alloc] init];
			hotelInfo._hotelId =   [NSString stringWithFormat:@"%@",[dicList objectForKey:@"hotelId"]];
			hotelInfo._hotelName =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"hotelName"]];
			hotelInfo._starCode =  [[NSString stringWithFormat:@"%@", [dicList objectForKey:@"starCode"]]intValue];
			hotelInfo._diamond =  [[NSString stringWithFormat:@"%@", [dicList objectForKey:@"diamond"]]boolValue];
			hotelInfo._rating = [[NSString stringWithFormat:@"%@", [dicList objectForKey:@"rating"]]floatValue];
			hotelInfo._districtName =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"districtName"]];
			hotelInfo._city=  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"city"]];
			hotelInfo._cityCode =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"cityCode"]];
			[list addObject: hotelInfo];
			[hotelInfo release];
		}
	}
	
	hotelCollectQueryDR._hotelCollectQueryArray=list;
	[list release];
	if ([hotelCollectQueryDR._hotelCollectQueryArray count] == 0) {
		hotelCollectQueryDR._hotelCollectQueryArray = nil;
	}
	return hotelCollectQueryDR;
}

//收藏添加成功提示
+ (NSString*)hotelCollectAddMessage:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	NSString * message = [dic objectForKey:@"message"];
	return message;
}

//收藏删除成功提示
+ (NSString*)hotelCollectDelMessage:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	NSString * message = [dic objectForKey:@"message"];
	return message;
}


@end

@implementation HotelCollect
@synthesize _hotelId,_hotelName,_starCode,_diamond,_rating,_districtName,_city,_cityCode;

-(void)dealloc
{
	self._hotelId = nil;
	self._hotelName = nil;
	self._rating = 0.0;
	self._diamond = FALSE;
	self._districtName = nil;
        self._starCode = 0;
	self._city = nil;
	self._cityCode = nil;
	[super dealloc];
}

@end