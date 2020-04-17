//
//  HotelInquiryDataResponse.m
//  FlightProject
//
//  Created by 崔立东 on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  旅馆查询
//

#import "HotelInquiryDataResponse.h"

@implementation HotelInquiryDataResponse

@synthesize _filterHoteDictionary,_hoteNameDictionary,_hoteInquiryNameDictionary,_administrativeAreaArray,_metroArray,_trafficArray,_businessAreaArray,_chargesArray,_levelArray,_brandArray;

//酒店筛选
+ (HotelInquiryDataResponse *)inquiryHotel:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
	HotelInquiryDataResponse * hotelDataResponse = [[[HotelInquiryDataResponse  alloc] init] autorelease];
	
	NSMutableDictionary *filterHoteDictionary = [[NSMutableDictionary alloc] init];
	NSMutableDictionary *hoteNameDictionary = [[NSMutableDictionary alloc] init];
	NSMutableDictionary *hoteInquiryNameDictionary = [[NSMutableDictionary alloc] init];
	
	int i = 0;
	//行政区
	hotelDataResponse._administrativeAreaArray = [dic objectForKey:@"administrativeArea"];
	if (hotelDataResponse._administrativeAreaArray.count>0) {
		//filterHotelInfo._administrativeArea =  @"行政区";
		[hoteInquiryNameDictionary setObject:@"行政区" forKey:[NSString stringWithFormat:@"%d",i]];
		[filterHoteDictionary setObject:hotelDataResponse._administrativeAreaArray forKey:@"行政区"];
		i++;
	}
	
	//热门商圈
	hotelDataResponse._businessAreaArray = [dic objectForKey:@"businessArea"];
	if (hotelDataResponse._businessAreaArray.count>0) {
		//filterHotelInfo._businessArea =  @"热门商圈";
		[hoteInquiryNameDictionary setObject:@"热门商圈" forKey:[NSString stringWithFormat:@"%d",i]];
		[filterHoteDictionary setObject:hotelDataResponse._businessAreaArray forKey:@"热门商圈"];
		i++;
	}
	
	//地铁
	NSArray *metroList = [dic valueForKey:@"metro"];
	if ( [metroList isKindOfClass:[NSArray class]] && metroList.count>0) {
		//filterHotelInfo._metro = @"地铁";
		NSMutableArray *list = [[NSMutableArray alloc] init];
		
		for (NSDictionary *dicList in metroList) {
			Metro *metro = [[Metro alloc] init];
			metro._name =  [NSString stringWithFormat:@"%@",[dicList objectForKey:@"name"]];
			NSArray *infoList = [dicList valueForKey:@"info"];
			NSMutableArray *ilist = [[NSMutableArray alloc] init];
			
			for (NSDictionary *diciList in infoList) {
				MetroInfo *metroInfo = [[MetroInfo alloc] init];
				metroInfo._name =  [NSString stringWithFormat:@"%@",[diciList objectForKey:@"name"]];
				metroInfo._longitude = [NSString stringWithFormat:@"%@",[diciList objectForKey:@"longitude"]];
				metroInfo._latitude=  [NSString stringWithFormat:@"%@",[diciList objectForKey:@"latitude"]];
				[ilist addObject: metroInfo];
				[metroInfo release];
			}
			
			metro._metroInfoArray = ilist;
			[ilist release];
			[list addObject: metro];
			[metro release];
		}
		hotelDataResponse._metroArray = list;
		[list release];
        if ([hotelDataResponse._metroArray count] == 0) {
            hotelDataResponse._metroArray = nil;
        }
		[hoteInquiryNameDictionary setObject: @"地铁"forKey:[NSString stringWithFormat:@"%d",i]];
		[filterHoteDictionary setObject:hotelDataResponse._metroArray forKey: @"地铁"];
		i++;
	}
	
	
	NSArray *trafficList = [dic valueForKey:@"traffic"];
	if ([trafficList isKindOfClass:[NSArray class]] && trafficList.count>0) {
		NSMutableArray *tlist = [[NSMutableArray alloc] init];
		//filterHotelInfo._traffic =  @"交通枢纽";
		for (NSDictionary *dictList in trafficList) {
			Traffic *trafficInfo = [[Traffic alloc] init];
			trafficInfo._name = [NSString stringWithFormat:@"%@",[dictList objectForKey:@"name"]];
			trafficInfo._longitude = [NSString stringWithFormat:@"%@",[dictList objectForKey:@"longitude"]];
			trafficInfo._latitude=  [NSString stringWithFormat:@"%@",[dictList objectForKey:@"latitude"]];
			[tlist addObject: trafficInfo];
			[trafficInfo release];
		}
		hotelDataResponse._trafficArray = tlist;
		[tlist release];
        if ([hotelDataResponse._trafficArray count] == 0) {
            hotelDataResponse._trafficArray = nil;
        }
		[hoteInquiryNameDictionary setObject:@"交通枢纽"  forKey:[NSString stringWithFormat:@"%d",i]];
		[filterHoteDictionary setObject:hotelDataResponse._trafficArray forKey:@"交通枢纽"];
		i++;
	}
	
	i = 1;
	
	hotelDataResponse._chargesArray = [dic objectForKey:@"charges"];
	if (hotelDataResponse._chargesArray.count>0) {
		//filterHotelInfo._charges =  @"酒店房价";
		[hotelDataResponse._chargesArray insertObject:@"房价不限" atIndex:0];
		[hoteNameDictionary setObject:@"酒店房价"  forKey:[NSString stringWithFormat:@"%d",i]];
		[filterHoteDictionary setObject:hotelDataResponse._chargesArray forKey:@"酒店房价"];
		i++;
	}
	
	
	
	hotelDataResponse._levelArray = [dic objectForKey:@"level"];
	if (hotelDataResponse._levelArray.count>0) {
		//filterHotelInfo._level = @"酒店星级";
		[hoteNameDictionary setObject:@"酒店星级"  forKey:[NSString stringWithFormat:@"%d",i]];
		[filterHoteDictionary setObject:hotelDataResponse._levelArray forKey: @"酒店星级"];
		i++;
	}
	
	//品牌
	NSArray *brandList = [dic valueForKey:@"brand"];
	if ([brandList isKindOfClass:[NSArray class]]&& brandList.count>0) {
		//filterHotelInfo._brand = @"品牌";
		NSMutableArray *blist = [[NSMutableArray alloc] init];
		for (NSDictionary *dicbList in brandList) {
			Brand *brandInfo = [[Brand alloc] init];
			brandInfo._id =   [NSString stringWithFormat:@"%@",[dicbList objectForKey:@"id"]];
			brandInfo._brandName =  [NSString stringWithFormat:@"%@",[dicbList objectForKey:@"brandName"]];
			[blist addObject: brandInfo];
			[brandInfo release];
		}
		[blist insertObject:@"品牌不限" atIndex:0];
		hotelDataResponse._brandArray = blist;
		[blist release];
        if ([hotelDataResponse._brandArray count] == 0) {
            hotelDataResponse._brandArray = nil;
        }
		[hoteNameDictionary setObject: @"品牌" forKey:[NSString stringWithFormat:@"%d",i]];
		[filterHoteDictionary setObject:hotelDataResponse._brandArray forKey: @"品牌"];
		i++;
	}
	
	hotelDataResponse._filterHoteDictionary = filterHoteDictionary;
	hotelDataResponse._hoteNameDictionary = hoteNameDictionary;
	hotelDataResponse._hoteInquiryNameDictionary = hoteInquiryNameDictionary;
	
	[filterHoteDictionary release];
	[hoteNameDictionary release];
	[hoteInquiryNameDictionary release];
	
	return hotelDataResponse;
}


-(void)dealloc
{
	self._filterHoteDictionary = nil;
	self._hoteNameDictionary = nil;
	self._hoteInquiryNameDictionary = nil;
	self._administrativeAreaArray = nil;
	self._metroArray = nil;
	self._trafficArray = nil;
	self._businessAreaArray = nil;
	self._chargesArray = nil;
	self._levelArray = nil;
	self._brandArray = nil;
	
	[super dealloc];
}


@end



@implementation FilterHotelInfo

@synthesize _administrativeArea,_metro,_traffic,_businessArea,_charges,_level,_brand;

-(void)dealloc
{
	self._administrativeArea = nil;
	self._metro = nil;
	self._traffic = nil;
	self._businessArea = nil;
	self._charges = nil;
	self._level = nil;
	self._brand = nil;
	[super dealloc];
}

@end


@implementation Metro 
@synthesize _name,_metroInfoArray;
-(void)dealloc
{
	self._name = nil;
	self._metroInfoArray = nil;
	[super dealloc];
}
@end

@implementation MetroInfo 
@synthesize _name,_longitude,_latitude;
-(void)dealloc
{
	self._name = nil;
	self._longitude = nil;
	self._latitude = nil;
	[super dealloc];
}
@end

@implementation Traffic 
@synthesize _name,_longitude,_latitude;
-(void)dealloc
{
	self._name = nil;
	self._longitude = nil;
	self._latitude = nil;
	[super dealloc];
}
@end

@implementation Brand 
@synthesize _id,_brandName;
-(void)dealloc
{
	self._id = nil;
	self._brandName = nil;
	
	[super dealloc];
}
@end




