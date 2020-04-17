//
//  GetOrderCarList.m
//  FlightProject
//
//  Created by 月 小 on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetOrderCarList.h"

@implementation OrderCarModel
@synthesize ids,submitDate,carName,typeDesc,takeDate,returnDate,orderStatus,totalPrice;
- (void)dealloc
{
    self.ids = nil;
    self.submitDate = nil;
    self.carName = nil;
    self.typeDesc = nil;
    self.takeDate = nil;
    self.returnDate = nil;
    self.orderStatus = nil;
    self.totalPrice = nil;
    [super dealloc];
}
@end

@implementation GetOrderCarList
@synthesize carList,totalPage;

- (void)dealloc
{
    self.carList = nil;
    [super dealloc];
}

+(GetOrderCarList*)GetOrderCarList:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    GetOrderCarList *getOrderCarList = [[GetOrderCarList alloc] init];
    getOrderCarList.totalPage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalPage"]];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray * carListArray = [dic objectForKey:@"carList"];
    if ([carListArray isKindOfClass:[NSArray class]]) {
        for(id elem in carListArray)
        {
            OrderCarModel *orderCarModel = [[OrderCarModel alloc] init];
            orderCarModel.ids = [NSString stringWithFormat:@"%@",[elem objectForKey:@"id"]];
            orderCarModel.submitDate = [NSString stringWithFormat:@"%@",[elem objectForKey:@"submitDate"]];
            orderCarModel.carName = [NSString stringWithFormat:@"%@",[elem objectForKey:@"carName"]];
            orderCarModel.typeDesc = [NSString stringWithFormat:@"%@",[elem objectForKey:@"typeDesc"]];
            orderCarModel.takeDate = [NSString stringWithFormat:@"%@",[elem objectForKey:@"takeDate"]];
            orderCarModel.returnDate = [NSString stringWithFormat:@"%@",[elem objectForKey:@"returnDate"]];
            orderCarModel.orderStatus = [NSString stringWithFormat:@"%@",[elem objectForKey:@"orderStatus"]];
            orderCarModel.totalPrice = [NSString stringWithFormat:@"%@",[elem objectForKey:@"totalPrice"]];
            [array addObject:orderCarModel];
            [orderCarModel release];
        }
    }
    if ([array count]>0) {
        getOrderCarList.carList = array;
        [array release];
    }
    else{
        getOrderCarList.carList = nil;
        [array release];
    }
    
    return [getOrderCarList autorelease];
}
@end
