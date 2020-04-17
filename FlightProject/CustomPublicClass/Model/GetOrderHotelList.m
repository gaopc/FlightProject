//
//  GetOrderHotelList.m
//  FlightProject
//
//  Created by 月 小 on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetOrderHotelList.h"

@implementation HotelModel
@synthesize orderNo,scheduleDate,totelMoney,checkInDate,checkOutDate,hotelName,hotelAddress,roomTypeName,stateCode,peopleName,lcdCurrency, breakfast,stateString;

- (void)dealloc
{
    self.breakfast = nil;
    self.orderNo = nil;
    self.scheduleDate = nil;
    self.totelMoney = nil;
    self.checkInDate = nil;
    self.checkOutDate = nil;
    self.hotelName = nil;
    self.hotelAddress = nil;
    self.roomTypeName = nil;
    self.stateCode = nil;
    self.peopleName = nil;
    self.lcdCurrency = nil;
    self.stateString = nil;
    [super dealloc];
}

+ (HotelModel*)GetOrderHotelDetail:(NSDictionary*)dic
{
    HotelModel *hotelModel = [[HotelModel alloc] init];
    hotelModel.orderNo = [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderNo"]];
    hotelModel.scheduleDate = [NSString stringWithFormat:@"%@",[dic objectForKey:@"scheduleDate"]];
    hotelModel.totelMoney = [NSString stringWithFormat:@"%@", [dic objectForKey:@"totelMoney"]];
    hotelModel.checkInDate = [NSString stringWithFormat:@"%@",[dic objectForKey:@"checkInDate"]];
    hotelModel.checkOutDate = [NSString stringWithFormat:@"%@",[dic objectForKey:@"checkOutDate"]];
    hotelModel.hotelName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"hotelName"]];
    hotelModel.hotelAddress = [NSString stringWithFormat:@"%@",[dic objectForKey:@"hotelAddress"]];
    hotelModel.roomTypeName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"roomTypeName"]];
    hotelModel.stateCode = [NSString stringWithFormat:@"%@",[dic objectForKey:@"stateCode"]];
    hotelModel.peopleName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"peopleName"]];
    hotelModel.lcdCurrency = [NSString stringWithFormat:@"%@", [dic objectForKey:@"lcdCurrency"]];
    hotelModel.breakfast = [NSString stringWithFormat:@"%@", [dic objectForKey:@"breakfast"]];
    switch ([[dic objectForKey:@"stateCode"] intValue]) {
        case 0:
            hotelModel.stateString = @"处理中";
            break;
        case 1:
            hotelModel.stateString = @"未入住";
            break;
        case 2:
            hotelModel.stateString = @"已结账";
            break;
        case 3:
            hotelModel.stateString = @"已取消";
            break;
        case 4:
            hotelModel.stateString = @"已确认";
            break;
        default:
            break;
    }

    return [hotelModel autorelease];
}

@end

@implementation GetOrderHotelList
@synthesize hotelList,totalPage;

- (void)dealloc
{
    self.hotelList = nil;
    self.totalPage = nil;
    [super dealloc];
}

+(GetOrderHotelList*)GetOrderHotelList:(NSDictionary*)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    GetOrderHotelList *getOrderHotelList = [[GetOrderHotelList alloc] init];
    getOrderHotelList.totalPage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalPage"]];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray * hotelList = [dic objectForKey:@"hotelList"];
    if ([hotelList isKindOfClass:[NSArray class]]) {
        for (id elem in hotelList) {
            HotelModel *hotelModel = [[HotelModel alloc] init];
            hotelModel.orderNo = [NSString stringWithFormat:@"%@",[elem objectForKey:@"orderNo"]];
            hotelModel.scheduleDate = [NSString stringWithFormat:@"%@",[elem objectForKey:@"scheduleDate"]];
            hotelModel.totelMoney = [NSString stringWithFormat:@"%@", [elem objectForKey:@"totelMoney"]];
            hotelModel.checkInDate = [NSString stringWithFormat:@"%@",[elem objectForKey:@"checkInDate"]];
            hotelModel.checkOutDate = [NSString stringWithFormat:@"%@",[elem objectForKey:@"checkOutDate"]];
            hotelModel.hotelName = [NSString stringWithFormat:@"%@",[elem objectForKey:@"hotelName"]];
            hotelModel.hotelAddress = [NSString stringWithFormat:@"%@",[elem objectForKey:@"hotelAddress"]];
            hotelModel.roomTypeName = [NSString stringWithFormat:@"%@",[elem objectForKey:@"roomTypeName"]];
            hotelModel.stateCode = [NSString stringWithFormat:@"%@",[elem objectForKey:@"stateCode"]];
            hotelModel.peopleName = [NSString stringWithFormat:@"%@",[elem objectForKey:@"peopleName"]];
            hotelModel.lcdCurrency = [NSString stringWithFormat:@"%@", [elem objectForKey:@"lcdCurrency"]];
            hotelModel.breakfast = [NSString stringWithFormat:@"%@", [elem objectForKey:@"breakfast"]];
            switch ([[elem objectForKey:@"stateCode"] intValue]) {
                case 0:
                    hotelModel.stateString = @"处理中";
                    break;
                case 1:
                    hotelModel.stateString = @"未入住";
                    break;
                case 2:
                    hotelModel.stateString = @"已结账";
                    break;
                case 3:
                    hotelModel.stateString = @"已取消";
                    break;
                case 4:
                    hotelModel.stateString = @"已确认";
                    break;
                default:
                    break;
            }
            [array addObject:hotelModel];
            [hotelModel release];
        }

    }
    if ([array count]>0) {
        getOrderHotelList.hotelList = array;
        [array release];
    }
    else{
        getOrderHotelList.hotelList = nil;
        [array release];
    }
    return [getOrderHotelList autorelease];
}
@end
