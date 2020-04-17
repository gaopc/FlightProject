////
////  GetOrderInfosResponse.m
////  FlightProject
////
////  Created by longcd on 12-6-14.
////  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
////
//
//#import "GetOrderInfosResponse.h"
//@implementation OrderInfo
//@synthesize orderID,lcdOrderID,flightNO,departureDate,passengerCount,addTime,isAcceptSevice,state,totalPrice,dptCity,dstCity;
//-(void)dealloc
//{
//    self.orderID = nil;
//    self.lcdOrderID = nil;
//    self.flightNO = nil;
//    self.departureDate = nil;
//    self.passengerCount = nil;
//    self.addTime = nil;
//    self.isAcceptSevice = nil;
//    self.state = nil;
//    self.totalPrice = nil;
//    self.dptCity = nil;
//    self.dstCity = nil;
//    [super dealloc];
//}
//@end
//
//@implementation GetOrderInfosResponse
//+(OrderInfo *)getOrderInfosResponseWithElem:(NSArray *)elem
//{
//    OrderInfo * orderInfo = [[OrderInfo alloc] init];
//    orderInfo.orderID = [NSString stringWithFormat:@"%@",[elem objectAtIndex:0]];
//    orderInfo.lcdOrderID = [NSString stringWithFormat:@"%@",[elem objectAtIndex:1]];
//    orderInfo.flightNO = [NSString stringWithFormat:@"%@",[elem objectAtIndex:2]];
//    orderInfo.departureDate = [NSString stringWithFormat:@"%@",[elem objectAtIndex:3]];
//    orderInfo.passengerCount = [NSString stringWithFormat:@"%@",[elem objectAtIndex:4]];
//    orderInfo.addTime = [NSString stringWithFormat:@"%@",[elem objectAtIndex:5]];
//    orderInfo.isAcceptSevice = [NSString stringWithFormat:@"%@",[elem objectAtIndex:6]];
//    switch ([orderInfo.isAcceptSevice intValue]) {
//        case 0:
//            orderInfo.isAcceptSevice = @"接受";
//            break;
//        case 1:
//            orderInfo.isAcceptSevice = @"不接受";
//            break;   
//        default:
//            break;
//    }
//    orderInfo.state = [NSString stringWithFormat:@"%@",[elem objectAtIndex:7]];
//    switch ([orderInfo.state intValue]) {
//        case 0:
//            orderInfo.state = @"待支付(预定成功)";
//            break;
//        case 1:
//            orderInfo.state = @"已出票";
//            break;
//        case 2:
//            orderInfo.state = @"取消";
//            break;
//        case 3:
//            orderInfo.state = @"支付中";
//            break;
//            
//        default:
//            break;
//    }
//    orderInfo.totalPrice = [NSString stringWithFormat:@"%@",[elem objectAtIndex:8]];
//    orderInfo.dptCity = [NSString stringWithFormat:@"%@",[elem objectAtIndex:9]];
//    orderInfo.dstCity = [NSString stringWithFormat:@"%@",[elem objectAtIndex:10]];
//    return [orderInfo autorelease];
//}
//+(NSArray *)getOrderInfosResponseWithArray:(NSArray *)resultArray
//{
//    NSArray * array = [resultArray objectAtIndex:0];
//    if ([[array objectAtIndex:0] isEqualToString:@"0"]) {
//        NSMutableArray * mArray = [[NSMutableArray alloc] init];
//        for (int i=1; i<[resultArray count]; i++) {
//            [mArray addObject:[self getOrderInfosResponseWithElem:[resultArray objectAtIndex:i]]];
//        }
//        return [mArray autorelease];
//    }
//    else {
//        [UIAlertView alertViewWithMessage:[array objectAtIndex:1]];
//    }
//    return nil;
//
//}
//@end
