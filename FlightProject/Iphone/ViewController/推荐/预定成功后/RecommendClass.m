//
//  RecommendClass.m
//  FlightProject
//
//  Created by longcd on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RecommendClass.h"
#import "QueryFlightTicket.h"
@implementation RecommendClass
@synthesize ticketQueryDataModel,hotelQueryDataModel,carQueryDataModel;
@synthesize delegate;
-(void)dealloc
{
    self.ticketQueryDataModel = nil;
    self.hotelQueryDataModel = nil;
    self.carQueryDataModel = nil;
    self.delegate = nil;
    [super dealloc];
}
- (void)recommendFlightWithDeparture:(NSString *)departure withArrival:(NSString *)arrival withStartDate:(NSString *)startDate //73
{
    ASIFormDataRequest * theRequest =  [InterfaceClass recommendFlightWithDeparture:departure withArrival:arrival withStartDate:startDate];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onRecommendFlightPaseredResult:) Delegate:self needUserType:Default];
    
}
- (void)recommendHotelWithCityName:(NSString *)cityName withCheckInDate:(NSString *)checkInDate //74
{
    ASIFormDataRequest * theRequest =  [InterfaceClass recommendHotelWithCityName:cityName withCheckInDate:checkInDate];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onRecommendHotelPaseredResult:) Delegate:self needUserType:Default];
}
- (void)recommendCarWithCityCode:(NSString *)cityCode withFromDate:(NSString *)fromDate withToDate:(NSString *)toDate //75
{
    ASIFormDataRequest * theRequest =  [InterfaceClass recommendCarWithCityCode:cityCode withFromDate:fromDate withToDate:toDate];
    [[SendRequstCatchQueue shareSendRequstCatchQueue] sendRequstCatchQueue:theRequest Selector:@selector(onRecommendCarPaseredResult:) Delegate:self needUserType:Default];
}
static NSInteger sortArrayByPriceAsce(id item1, id item2, void *context){//升序
    if ([item1 isKindOfClass:[FlightInfo class]]) {
        FlightInfo *info1 = item1;
        FlightInfo *info2 = item2;
        int v1 = [info1._ticketPrice intValue];
        int v2 = [info2._ticketPrice intValue];
        
        if (v1 < v2)
            return NSOrderedAscending;//降序
        else if (v1 >v2)
            return NSOrderedDescending;//升序
        else
            return NSOrderedSame;
    }
    else if ([item1 isKindOfClass:[HotelInfo class]]) {
        HotelInfo *info1 = item1;
        HotelInfo *info2 = item2;
        if (info1._lowestPrice < info2._lowestPrice)
            return NSOrderedAscending;
        else if (info1._lowestPrice > info2._lowestPrice)
            return NSOrderedDescending;
        else
            return NSOrderedSame;
    }	
    else if ([item1 isKindOfClass:[QueryCarModelResponse class]]) {
        QueryCarModelResponse * info1 = item1;
        QueryCarModelResponse * info2 = item2;
        if (info1._dayPrice < info2._dayPrice)
            return NSOrderedAscending;
        else if (info1._dayPrice > info2._dayPrice)
            return NSOrderedDescending;
        else
            return NSOrderedSame;

    }
    else {
        return 0;
    }
}

//static NSInteger sortArrayByPriceDesc(id item1, id item2, void *context){//降序
//
//    if ([item1 isKindOfClass:[FlightInfo class]]) {
//        FlightInfo *info1 = item1;
//        FlightInfo *info2 = item2;
//        int v1 = [info1._ticketPrice intValue];
//        int v2 = [info2._ticketPrice intValue];
//        if (v1 < v2)
//            return NSOrderedDescending;//降序
//        else if (v1 >v2)
//            return NSOrderedAscending;//升序
//        else
//            return NSOrderedSame;
//
//    }
//    else if ([item1 isKindOfClass:[HotelInfo class]]) {
//        HotelInfo *info1 = item1;
//        HotelInfo *info2 = item2;
//        if (info1._lowestPrice > info2._lowestPrice)
//            return NSOrderedAscending;
//        else if (info1._lowestPrice < info2._lowestPrice)
//            return NSOrderedDescending;
//        else
//            return NSOrderedSame;
//    }	
//    else if ([item1 isKindOfClass:[QueryCarModelResponse class]]) {
//        QueryCarModelResponse * info1 = item1;
//        QueryCarModelResponse * info2 = item2;
//        if (info1._dayPrice > info2._dayPrice)
//            return NSOrderedAscending;
//        else if (info1._dayPrice < info2._dayPrice)
//            return NSOrderedDescending;
//        else
//            return NSOrderedSame;
//
//    }
//    else {
//        return 0;
//    }
//
//}

-(void)onRecommendFlightPaseredResult:(NSDictionary *)resultDic
{
    QueryFlightTicket * flightTicket= [QueryFlightTicket QueryFlightTicket:resultDic];
    if ([flightTicket._firstFlightInfo count] > 0) {
        flightTicket._firstFlightInfo=[flightTicket._firstFlightInfo sortedArrayUsingFunction:sortArrayByPriceAsce context:NULL];
        if (self.delegate && [self.delegate respondsToSelector:@selector(recommendTicketSucessful:)]) {
            [self.delegate performSelector:@selector(recommendTicketSucessful:) withObject:flightTicket];
        }
    }
}
-(void)onRecommendHotelPaseredResult:(NSDictionary *)resultDic
{
    HotelQueryDataResponse * hotelQueryDR = [HotelQueryDataResponse hotelQuery:resultDic];
    if ([hotelQueryDR._hotelQueryInfoArray count] >0) {
        hotelQueryDR._hotelQueryInfoArray=(NSMutableArray *)[hotelQueryDR._hotelQueryInfoArray sortedArrayUsingFunction:sortArrayByPriceAsce context:nil];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(recommendHotelSucessful:)]) {
            [self.delegate performSelector:@selector(recommendHotelSucessful:) withObject:hotelQueryDR];
        }
    }
}
-(void)onRecommendCarPaseredResult:(NSDictionary *)resultDic
{
    NSArray * array =  [QueryCarModelResponse QueryCarModelResponse:resultDic ];
    if ([array count] >0) {
        array=[array sortedArrayUsingFunction:sortArrayByPriceAsce context:nil];
        if (self.delegate && [self.delegate respondsToSelector:@selector(recommendCarSucessful:)]) {
            [self.delegate performSelector:@selector(recommendCarSucessful:) withObject:array];
        }
    }
}
@end
