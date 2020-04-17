//
//  SubmitOrderCar.m
//  FlightProject
//
//  Created by longcd on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SubmitOrderCar.h"

@implementation SubmitOrderCar

@synthesize _modeCode,_vehicleLevel,_serviceId,_activityId;

-(void)dealloc
{
    self._modeCode = nil;
    self._vehicleLevel = nil;
    self._serviceId = nil;
    self._activityId = nil;
    [super dealloc];
}

@end

@implementation CarServiceList

@synthesize _serviceName,_servicePrice;
-(void)dealloc
{
    self._serviceName = nil;
    self._servicePrice = nil;
    [super dealloc];
}

@end

@implementation SubmitOrderCarResponse

@synthesize _totalCarRentMoney,_totalCarFee,_insuranceFee,_serviceFee,_otherFee,_lcdFee;
@synthesize _lcdRate,_lcdValue;
-(void)dealloc
{
    self._totalCarRentMoney = nil;
    self._totalCarFee = nil;
    self._insuranceFee = nil;
    self._serviceFee = nil;
    self._otherFee = nil;
    self._lcdFee = nil;
    self._lcdValue = nil;
    self._lcdRate = nil;
    [super dealloc];
}
+(SubmitOrderCarResponse *) SubmitOrderCarResponse:(NSDictionary *)resultDic
{
    if (![resultDic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    SubmitOrderCarResponse * instance = [[SubmitOrderCarResponse alloc] init];
    instance._totalCarRentMoney = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"totalCarRentMoney"]]; // 费用总和
    instance._totalCarFee = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"totalCarFee"]]; // 租车费用
    instance._insuranceFee = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"insuranceFee"]]; // 保险费用
    
    NSString * _serviecFee =  [resultDic objectForKey:@"serviceFee"];
    
    if (((![_serviecFee isKindOfClass:[NSNull class]])) && ![_serviecFee isEqualToString:@""] &&[[_serviecFee componentsSeparatedByString:@"+"] count]>0) {
            NSMutableArray * mArray = [NSMutableArray array];
            for (NSString * elem in [_serviecFee componentsSeparatedByString:@"+"]) {
            NSArray * array = [elem componentsSeparatedByString:@"￥"];
            CarServiceList * service = [[CarServiceList alloc] init];
            service._serviceName = [array objectAtIndex:0];
            if ([array count] > 1) {
                service._servicePrice = [array objectAtIndex:1];
            }
            [mArray addObject:service];
            [service release];
        }
        instance._serviceFee = mArray; // 增值服务
        if ([instance._serviceFee count] == 0) {
            instance._serviceFee = nil;
        }
    }
        
    instance._otherFee = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"otherFee"]]; // 服务费
    instance._lcdFee = [NSString stringWithFormat:@"%d",[[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"lcdFee"] ] intValue]]; // 返畅达币
    instance._lcdRate = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"lcdRate"]  ]; 
    instance._lcdValue =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"lcdValue"]  ]; 
    return [instance autorelease];
}
@end
